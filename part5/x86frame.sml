structure X86Frame: FRAME =
struct

(* We will use the following format for an activation record:
 *
 * ^ higher addresses
 * ------------------------------ previous frame
 *   ...
 *   argument n                   [FP+4*(2+n)]
 *   ...
 *   argument 1                   [FP+4*(2+1)]
 *   static link                  [FP+4*2]
 *   return address               [FP+4]
 * ------------------------------ current frame
 *   old frame pointer            [FP]            <-- frame pointer
 *   local variable 1             [FP-4*1]
 *   ...
 *   local variable m             [FP-4*m]
 *   temp 1                       [FP-4*(m+1)]
 *   ...
 *   temp k                       [FP-4*(m+k)]  <-- stack pointer, [SP]
 *   ---------------- if CALL..
 *   argument n'
 *   ...
 *   argument 1
 *   static link
 *   return address
 * ------------------------------ ..next frame will look like this
 *   old frame pointer
 *   ...
 * ------------------------------
 * v lower addresses
 *)

structure Sy = Symbol
structure Tm = Temp
structure Tr = Tree

exception Bug of string

type frame = { name: Tm.label           (* label of code of function *)
             , formals: bool list       (* for each formal, does it escape? *)
             , locals: int ref}         (* number of local vars *)

datatype access =
         InFrame of int                 (* value in memory, offset from FP *)
       | InReg of Tm.temp               (* value in register *)

datatype frag =
         PROC of {body: Tr.stm, frame: frame}
       | STRING of Tm.label * string

val FP = Tm.newtemp ()                  (* Frame pointer: %ebp *)
val SP = Tm.newtemp ()                  (* Stack pointer: %esp *)
val RV = Tm.newtemp ()                  (* Return value: %eax *)

val EAX = RV                            (* %eax: add, mult, .. *)
val EBX = Tm.newtemp ()                 (* %ebx: base of array *)
val ECX = Tm.newtemp ()                 (* %ecx: count of loop *)
val EDX = Tm.newtemp ()                 (* %edx: data *)
val ESI = Tm.newtemp ()                 (* %esi: source index (string cpy) *)
val EDI = Tm.newtemp ()                 (* %edi: destination index *)
val EIP = Tm.newtemp ()                 (* %eip: instruction pointer *)

val wordSize = 4                        (* 32 bit words *)

(* Register Lists *)
val allregs = [EAX, EBX, ECX, EDX, ESI, EDI, EIP, FP, SP]
val specialregs = [FP, SP, RV]
val argregs = nil
val calleesaves = nil
val callersaves = nil
val calldefs = callersaves @ [RV]

fun isRegister tmp =
    List.exists (fn reg => tmp=reg) allregs

fun newFrame {name, formals} = {name=name, formals=formals, locals=ref 0}

fun frameSize (f: frame) =
    let
        val formalsSize = wordSize * length (#formals f)
        val localsSize = wordSize * (!(#locals f))
        val overhead = 0 (* NB: may need extra space for some extensions *)
    in
        formalsSize + localsSize + overhead
    end

fun name (fr:frame) = #name fr

fun offsetOfFormal nr = 8 + nr * wordSize

fun accessOfFormal nr escaping =
    if escaping then InFrame (offsetOfFormal nr)
    else InReg (Tm.newtemp ())

fun formals (fr:frame) =
    let
        fun accessesOfFormals _ [] = []
          | accessesOfFormals nr (h::r) =
            accessOfFormal nr h :: accessesOfFormals (nr+1) r
    in
        accessesOfFormals 1 (#formals fr)
    end

fun local2access (escapes: bool, noOfLocals: int) =
    if escapes
    then InFrame (~ noOfLocals * wordSize)
    else InReg (Tm.newtemp ())

fun allocLocal (f:frame) escapes =
    let
        val noOfLocals = #locals f
    in
        noOfLocals := !noOfLocals + 1;
        local2access (escapes, !noOfLocals)
    end

fun staticLinkOffset _ = 8

fun number2formal nr =
    Tr.MEM (Tr.BINOP ( Tr.PLUS
                     , Tr.TEMP FP
                     , Tr.CONST (offsetOfFormal nr)))

fun exp (InFrame k) fp =
    Tr.MEM (Tr.BINOP (Tr.PLUS, fp, Tr.CONST k))
  | exp (InReg temp) _ =
    Tr.TEMP temp

fun asEncode s =
    let
        fun ase [] = []
          | ase (#"\\"::cs) = #"\\" :: #"\\" :: (ase cs)
          | ase (#"\""::cs) = #"\\" :: #"\"" :: (ase cs)
          | ase (c::cs) =
            let
                val ordc = ord(c)
                val charsc = Int.fmt StringCvt.OCT ordc
            in
                if 32 <= ordc andalso ordc < 128 then c :: (ase cs)
                else (#"\\" :: (explode charsc)) @ (ase cs)
            end
    in
        (implode o ase o explode) s
    end

fun string (label, str) =
    "\t.data\n" ^
    Sy.name label ^ ":\n" ^
    "\t.long " ^ Int.toString (size str) ^ "\n" ^
    "\t.asciz \"" ^ (asEncode str) ^ "\"\n"

fun move (reg, var) = Tr.MOVE (Tr.TEMP reg, Tr.TEMP var)

fun seq [] = Tr.EXP (Tr.CONST 0)
  | seq [exp] = exp
  | seq (exp :: exps) = (Tr.SEQ (exp, (seq exps)))

fun externalCall (str, args) = Tr.CALL (Tr.NAME (Tm.namedLabel str), args)

fun entryExit1 adjustBody (frame,body) =
    let
        (* extend body to save 'callee save' registers in temporaries *)
        val toSave = calleesaves
        val saved = map (fn _ => Temp.newtemp ()) toSave
        val saveIR = seq (ListPair.mapEq move (saved, toSave))
        val restoreIR = seq (ListPair.mapEq move (toSave, saved))
        val body' = seq [saveIR, adjustBody body, restoreIR]
        (* perform 'view shift': copy arguments passed in registers to
         * frame or temp---but we do not currently pass any arguments
         * in registers, so this will currently not do anything *)
        val funFormals = formals frame
        fun moveArg (arg, access) =
            Tr.MOVE (exp access (Tr.TEMP FP), Tr.TEMP arg)
        val viewShift = seq (ListPair.map moveArg (argregs, funFormals))
    in
        case funFormals
         of [] => body'
          | _  => Tr.SEQ (viewShift, body')
    end

fun funEntryExit1 (frame, body) =
    entryExit1 (fn body => Tr.MOVE (Tr.TEMP RV, body)) (frame, body)

fun procEntryExit1 (frame, body) =
    entryExit1 (fn body => body) (frame, body)

(* ---------- Printing ---------- *)

(* p208 *)
val tempMap = Temp.Table.fromList [ (FP,  "%ebp")
                                  , (SP,  "%esp")
                                  , (EAX, "%eax")
                                  , (EBX, "%ebx")
                                  , (ECX, "%ecx")
                                  , (EDX, "%edx")
                                  , (ESI, "%esi")
                                  , (EDI, "%edi")
                                  , (EIP, "%eip")]

fun asStringReg r =
    case Temp.Table.look (tempMap, r)
     of SOME regname => regname
      | NONE => Temp.makestring r

fun asStringFrame (frame:frame) =
    "{name = " ^
    Sy.name (#name frame) ^
    ", formals = " ^
    concat (map (fn b => if b then "t" else "f") (#formals frame)) ^
    ", locals = " ^
    Int.toString (!(#locals frame)) ^
    "}"

fun asStringAccess (InFrame i) =
    "InFrame(" ^
    Int.toString i ^
    ")"
  | asStringAccess (InReg tmp) =
    "InReg(" ^
    Tm.makestring tmp ^
    ")"

fun printx asStringX (outstream, x) =
    ( TextIO.output (outstream, asStringX x ^ "\n")
    ; TextIO.flushOut outstream)

fun printFrame (outstream, f)  = printx asStringFrame  (outstream, f)
fun printAccess (outstream, a) = printx asStringAccess (outstream, a)

end (* X86Frame *)
