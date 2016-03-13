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
 *
 *)

structure Sy = Symbol
structure Tm = Temp
structure Tr = Tree
structure A = Assem

exception Bug of string
exception TODO

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

(* Register Lists - note that we do _not_ perform register
 * allocation as described in the textbook, so we leave the
 * '..saves' lists empty because no action will be needed to
 * save the registers around function invocations; the
 * following register list definitions must be modified
 * extensively in order to fit in with register allocation,
 * in case such a phase is added; also, 'allregs' must be
 * extended to include extra registers if any such are used
 * in the generated code (the x86 has various other registers,
 * e.g., used for floating points or MMX instructions, etc.etc.
 * but we have no intention to use assembly instructions that
 * involve those registers) *)

val allregs = [EAX, EBX, ECX, EDX, ESI, EDI, EIP, FP, SP]
val specialregs = [FP, SP, RV]
val argregs = nil
val calleesaves = nil
val callersaves = nil
val calldefs = callersaves @ [RV]

(* add this function to x86frame.sml *)
fun forceFrame {name, formals, locals} =
    {name=name, formals=formals, locals = ref locals}

fun isRegister tmp =
    List.exists (fn reg => tmp=reg) allregs

fun newFrame {name, formals} =
    {name=name, formals=formals, locals = ref 0}

fun frameSize (f: frame) =
    let
        val formalsSize = wordSize * length (#formals f)
        val localsSize = wordSize * (!(#locals f))
        val overhead = 0 (* NB: some extensions may need an overhead *)
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

fun staticLinkOffset _ =
    (* on p127 the static link is at the frame pointer, but we
     * store the old frame pointer there and the static link two
     * steps up *)
    8

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

fun externalCall (str, args) =
    (* the gcc generated code expects arguments pushed,
     * then the return address (due to CALL instruction),
     * and it will initially push the frame pointer; it
     * delivers the return value in register EAX; hence
     * it uses the same layout as the one we use for Tiger,
     * except that it omits the static link *)
    Tr.CALL (Tr.NAME (Tm.namedLabel str), args)

fun frameInfo {name, formals, locals} =
    "# FRAME " ^
    Sy.name name ^ "(" ^
    Int.toString (length formals) ^ " formals, " ^
    Int.toString (!locals) ^
    " locals)"

fun instr2temps (A.OPER {dst, src, ...}) = dst @ src
  | instr2temps (A.LABEL _) = nil
  | instr2temps (A.MOVE {dst, src, ...}) = [dst, src]

fun createTempOffsetMap (f: frame) (body: A.instr list) =
    (* create an int Temp.Table.table that maps each temp used
     * in body into its offset; along the way, allocate the space
     * for the temps in the frame *)
    let
        val tempsMayDup = List.concat (map instr2temps body)
        fun undup ([]: Temp.temp list) = []
          | undup (x::xs) =
            if List.exists (fn y => x=y) xs then undup xs else x :: undup xs
        val temps = undup tempsMayDup
        fun addTmp (tmp, toMap) =
            let
                val (InFrame offset) = allocLocal f true
            in
                Temp.Table.enter (toMap, tmp, offset)
            end
    in
        foldl addTmp Temp.Table.empty temps
    end

fun spillAllTemps toMap body =
    (* Using the temp-to-offset map 'toMap', transform the
     * instructions in 'body' such that every temp is located
     * InFrame; note that we only ever use `s0, `s1, `d0 in
     * generated assembly, which means that we can safely use
     * certain registers locally: %ebx, %ecx, and %edx.  We will
     * load and use these registers within that short list of
     * instructions that we create in each case, thus ensuring
     * that it makes no difference what they were used for
     * before, and causes no harm that they will be arbitrarily
     * overwritten.  Also note that even though some instructions
     * have (length dst > 1) we never use other elements than the
     * head, because there is no `dk for any k>0; similarly,
     * OPER instructions with (length src > 2) will only use at
     * most the first two elements.
     *
     * Note that `s0 needs to be loaded to a register which will
     * then be used; `d0 needs to be loaded to a register R, then
     * R is operated upon, then its value is stored to `d0.
     *
     * Sanity checks: for 'assem = assem' instructions with OPER, the
     * src/dst lists must have same length as the original instruction,
     * but the non-register temps have been changed to registers.  For
     * the added 'movl' instructions, length src + length dst = 1.
     * With MOVE, we change src,dst by replacing 0/1/2 of them to
     * EBX (one other temp) EBX,ECX (two).
     *)
    let
        fun ofs tmp =
            case Temp.Table.look (toMap, tmp)
             of SOME offset => if offset >= 0
                               then Int.toString offset
                               else "-" ^ Int.toString (~offset)
              | NONE => raise Bug "Encountered unknown temp in spillAllTemps"
        fun expand (A.OPER {src=s0::ss, jump = SOME (j::js), ...}) =
            raise Bug "Encountered OPER that uses temps and jumps"
          | expand (i as (A.OPER {src=[], dst=[], ...})) =
            [i]
          | expand (i as A.OPER {assem, src=[s0], dst=[], jump, doc}) =
            if isRegister s0 then [i]
            else (* s0 other temp *)
                [ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
                         , src = []
                         , dst = [EBX]
                         , jump = NONE
                         , doc = doc ^ " x86frame:265"}
                , A.OPER { assem = assem
                         , src = [EBX]
                         , dst = []
                         , jump = jump
                         , doc = doc ^ " x86frame:270"}]
          | expand (i as A.OPER {assem, src=(s0::s1::ss), dst=[], jump, doc}) =
            if isRegister s0 then
                if isRegister s1 then [i]
                else (* s0 register, s1 other temp *)
		      let
			    val t = (if s0 = EBX then ECX else EBX)
		      in
			    [ A.OPER { assem = "\tmovl " ^ ofs s1 ^ "(%ebp), `d0"
				     , src = []
				     , dst = [t]
				     , jump = NONE
				     , doc = doc ^ " x86frame:282"}
			    , A.OPER { assem = assem
				     , src = (s0 :: t :: ss)
				     , dst = []
				     , jump = jump
				     , doc = doc ^ " x86frame:287"}]
		      end
            else if isRegister s1 then
                  (* s0 other temp, s1 register *)
  		  let
			val t = (if s1 = EBX then ECX else EBX)
		  in
			[ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
				 , src = []
				 , dst = [t]
				 , jump = NONE
				 , doc = doc ^ " x86frame:298"}
			, A.OPER { assem = assem
				 , src = (t :: s1 :: ss)
				 , dst = []
				 , jump = jump
				 , doc = doc ^ " x86frame:303"}]
		  end
            else (* s0,s1 other temps *)
			    [ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
				     , src = []
				     , dst = [EBX]
				     , jump = NONE
				     , doc = doc ^ " x86frame:310"}
			    ,  A.OPER { assem = "\tmovl " ^ ofs s1 ^ "(%ebp), `d0"
				     , src = []
				     , dst = [ECX]
				     , jump = NONE
				     , doc = doc ^ " x86frame:315"}
			    , A.OPER { assem = assem
				     , src = (EBX :: ECX :: ss)
				     , dst = []
				     , jump = jump
				     , doc = doc ^ " x86frame:320"}]
          | expand (i as A.OPER {assem, src=[], dst=(d0::ds), jump, doc}) =
            if isRegister d0 then [i]
            else (* d0 other temp *)
		  [ A.OPER { assem = assem
                         , src = []
                         , dst = (EBX :: ds)
                         , jump = jump
                         , doc = doc ^ " x86frame:328"}
		  , A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
			   , src = [EBX]
			   , dst = []
			   , jump = NONE
			   , doc = doc ^ " x86frame:333"}]
          | expand (i as A.OPER {assem, src=[s0], dst=(d0::ds), jump, doc}) =
            if isRegister s0 then
                if isRegister d0 then [i]
                else (* s0 register, d0 other temp *)
		      let
			    val t = (if s0 = EBX then ECX else EBX)
		      in
		  [ A.OPER { assem = assem
                         , src = [s0]
                         , dst = (t :: ds)
                         , jump = jump
                         , doc = doc ^ " x86frame:345"}
		   , A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
				 , src = [t]
				 , dst = []
				 , jump = NONE
				 , doc = doc ^ " x86frame:350"}]
		      end
            else if isRegister d0 then
                (* s0 other temp, d0 register *)
		  let
			val t = (if d0 = EBX then ECX else EBX)
		  in
			[ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
				 , src = []
				 , dst = [t]
				 , jump = NONE
				 , doc = doc ^ " x86frame:361"}
			, A.OPER { assem = assem
				 , src = [t]
				 , dst = (d0 :: ds)
				 , jump = jump
				 , doc = doc ^ " x86frame:366"}]
		  end
            else (* s0,d0 other temp *)
                (* OLD_R_OPTIMIZATION *)
                if s0=d0 then
                    (* instruction uses old-d0, and "`s0" is
                     * not used in assem; must preload d0 *)
			[ A.OPER { assem = "\tmovl " ^ ofs d0 ^ "(%ebp), `d0"
				 , src = []
				 , dst = [EBX]
				 , jump = NONE
				 , doc = doc ^ " x86frame:377"}
			, A.OPER { assem = assem
				 , src = [EBX]
				 , dst = (EBX :: ds)
				 , jump = jump
				 , doc = doc ^ " x86frame:382"}
			, A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
				 , src = [EBX]
				 , dst = []
				 , jump = NONE
				 , doc = doc ^ " x86frame:387"}]
                else (* s0<>d0, and instruction does not use old-d0 *)
			[ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
				 , src = []
				 , dst = [EBX]
				 , jump = NONE
				 , doc = doc ^ " x86frame:393"}
			, A.OPER { assem = assem
				 , src = [EBX]
				 , dst = (ECX :: ds)
				 , jump = jump
				 , doc = doc ^ " x86frame:398"} 
			, A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
				 , src = [ECX]
				 , dst = []
				 , jump = NONE
				 , doc = doc ^ " x86frame:403"}]
          | expand (i as A.OPER { assem, src=(s0::s1::ss)
                                , dst=(d0::ds), jump, doc}) =
            if isRegister s0 then
                if isRegister s1 then
                    if isRegister d0 then [i]
                    else (* s0,s1 register, d0 other temp *)
                          (* OLD_R_OPTIMIZATION: s0<>d0, no pre-load needed *)
			  let
				val t = 
				    (if s0 = EBX then
					   if s1 = ECX then EDX else ECX
				     else if s1 = EBX then
					   if s0 = ECX then EDX else ECX
				     else EBX)
			  in
				[ A.OPER { assem = assem
					 , src = (s0::s1::ss)
					 , dst = (t :: ds)
					 , jump = jump
					 , doc = doc ^ " x86frame:423"}
				, A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
					 , src = [t]
					 , dst = []
					 , jump = NONE
					 , doc = doc ^ " x86frame:428"} ]
			  end
                else (* s0 register, s1 other temp *)
                    if isRegister d0 then
                        (* s0 register, s1 other temp, d0 register *)
  			  let
				val t = (if s0 = EBX then
					       if d0 = ECX then EDX else ECX
					 else if d0 = EBX then
					       if s0 = ECX then EDX else ECX
					 else EBX)
			  in
				[ A.OPER { assem = "\tmovl " ^ ofs s1 ^ "(%ebp), `d0"
					 , src = []
					 , dst = [t]
					 , jump = NONE
					 , doc = doc ^ " x86frame:444"}
				, A.OPER { assem = assem
					 , src = (s0 :: t :: ss)
					 , dst = (d0 :: ds)
					 , jump = jump
					 , doc = doc ^ " x86frame:449"}]
			  end
                    else (* s0 register, s1,d0 other temp *)
                        (* OLD_R_OPTIMIZATION: s0<>d0, no pre-load needed *)
  			  let
				val t1 = (if s0 = EBX then ECX else EBX)
				val t2 = (if s0 = EBX orelse s0 <> EDX then EDX else ECX)
			  in
				[ A.OPER { assem = "\tmovl " ^ ofs s1 ^ "(%ebp), `d0"
					 , src = []
					 , dst = [t1]
					 , jump = NONE
					 , doc = doc ^ " x86frame:461"}
				, A.OPER { assem = assem
					 , src = (s0 :: t1 :: ss)
					 , dst = (t2 :: ds)
					 , jump = jump
					 , doc = doc ^ " x86frame:466"}
				, A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
					 , src = [t2]
					 , dst = []
					 , jump = NONE
					 , doc = doc ^ " x86frame:471"}]
			  end
            else (* s0 other temp *)
                if isRegister s1 then
                    if isRegister d0 then
                        (* s0 other temp, s1,d0 register *)
  			  let
				val t = (if s1 = EBX then
					       if d0 = ECX then EDX else ECX
					 else if d0 = EBX then
					       if s1 = ECX then EDX else ECX
					 else EBX)
			  in
				[ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
					 , src = []
					 , dst = [t]
					 , jump = NONE
					 , doc = doc ^ " x86frame:488"}
				, A.OPER { assem = assem
					 , src = (t :: s1 :: ss)
					 , dst = (d0 :: ds)
					 , jump = jump
					 , doc = doc ^ " x86frame:493"}]
			  end
                    else (* s0 other temp, s1 register, d0 other temp *)
                        (* OLD_R_OPTIMIZATION *)
                          if s0=d0 then
                            (* instruction uses old-d0, and "`s0" is
                             * not used in assem; must preload d0 *)
				let
				      val t = (if s1 = EBX then ECX else EBX)
				in
				      [ A.OPER { assem = "\tmovl " ^ ofs d0 ^ "(%ebp), `d0"
					       , src = []
					       , dst = [t]
					       , jump = NONE
					       , doc = doc ^ " x86frame:507"}
				      , A.OPER { assem = assem
					       , src = (EBX :: s1 :: ss)
					       , dst = (EBX :: ds)
					       , jump = jump
					       , doc = doc ^ " x86frame:512"}
				      , A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
					       , src = [EBX]
					       , dst = []
					       , jump = NONE
					       , doc = doc ^ " x86frame:517"}]
				end				
                        else (* s0<>d0, and instruction does not use old-d0 *)
				let
				      val t1 = (if s1 = EBX then ECX else EBX)
				      val t2 = (if s1 = EBX orelse s1 <> EDX then EDX else ECX)
				in
				      [ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
					       , src = []
					       , dst = [t1]
					       , jump = NONE
					       , doc = doc ^ " x86frame:528"}
				      , A.OPER { assem = assem
					       , src = (t1 :: s1 :: ss)
					       , dst = (t2 :: ds)
					       , jump = jump
					       , doc = doc ^ " x86frame:533"}
				      , A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
					       , src = [t2]
					       , dst = []
					       , jump = NONE
					       , doc = doc ^ " x86frame:538"}]
				end		
                else if isRegister d0 then
                    (* s0,s1 other temp, d0 register *)
  			  let
				val t1 = (if d0 = EBX then ECX else EBX)
				val t2 = (if d0 = EBX orelse d0 <> EDX then EDX else ECX)
			  in
				[ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
					 , src = []
					 , dst = [t1]
					 , jump = NONE
					 , doc = doc ^ " x86frame:550"}
				, A.OPER { assem = "\tmovl " ^ ofs s1 ^ "(%ebp), `d0"
					 , src = []
					 , dst = [t2]
					 , jump = NONE
					 , doc = doc ^ " x86frame:555"}
				, A.OPER { assem = assem
					 , src = (t1 :: t2 :: ss)
					 , dst = (d0 :: ds)
					 , jump = jump
					 , doc = doc ^ " x86frame:560"}]
			  end
                else (* s0,s1,d0 other temp *)
                    (* OLD_R_OPTIMIZATION *)
                      if s0=d0 then
                        (* instruction uses old-d0, and "`s0" is
                         * not used in assem; must preload d0 *)
				  [ A.OPER { assem = "\tmovl " ^ ofs d0 ^ "(%ebp), `d0"
					   , src = []
					   , dst = [EBX]
					   , jump = NONE
					   , doc = doc ^ " x86frame:571"}
				  , A.OPER { assem = "\tmovl " ^ ofs s1 ^ "(%ebp), `d0"
					   , src = []
					   , dst = [ECX]
					   , jump = NONE
					   , doc = doc ^ " x86frame:576"}
				  , A.OPER { assem = assem
					   , src = (EBX :: ECX :: ss)
					   , dst = (EBX :: ds)
					   , jump = jump
					   , doc = doc ^ " x86frame:581"}
				  , A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
					   , src = [EBX]
					   , dst = []
					   , jump = NONE
					   , doc = doc ^ " x86frame:586"}]
                     else (* s0<>d0, and instruction does not use old-d0 *)
				  [ A.OPER { assem = "\tmovl " ^ ofs s0 ^ "(%ebp), `d0"
					   , src = []
					   , dst = [EBX]
					   , jump = NONE
					   , doc = doc ^ " x86frame:592"}
				  , A.OPER { assem = "\tmovl " ^ ofs s1 ^ "(%ebp), `d0"
					   , src = []
					   , dst = [ECX]
					   , jump = NONE
					   , doc = doc ^ " x86frame:597"}
				  , A.OPER { assem = assem
					   , src = (EBX :: ECX :: ss)
					   , dst = (EDX :: ds)
					   , jump = jump
					   , doc = doc ^ " x86frame:602"}
				  , A.OPER { assem = "\tmovl `s0, " ^ ofs d0 ^ "(%ebp)"
					   , src = [EDX]
					   , dst = []
					   , jump = NONE
					   , doc = doc ^ " x86frame:607"}]
          | expand (i as (A.LABEL _)) = [i]
          | expand (i as A.MOVE {assem, src, dst, doc}) =
            (* we ignore assem because src/dst reveals the semantics
             * of the A.MOVE exactly, so we can reconstruct it *)
            if isRegister src then
                if isRegister dst then [i]
                else (* src register, dst other temp *)
		    [ A.OPER { assem = "\tmovl `s0, " ^ ofs dst ^ "(%ebp)"
			     , src = [src]
			     , dst = []
			     , jump = NONE
			     , doc = doc ^ " x86frame:619"}]
            else if isRegister dst then
                (* src other temp, dst register *)
		    [ A.OPER { assem = "\tmovl " ^ ofs src ^ "(%ebp), `d0"
			     , src = []
			     , dst = [dst]
			     , jump = NONE
			     , doc = doc ^ " x86frame:626"}]
            else
                (* src, dst other temp *)
		[ A.OPER { assem = "\tmovl " ^ ofs src ^ "(%ebp), `d0"
			 , src = []
			 , dst = [EBX]
			 , jump = NONE
			 , doc = doc ^ " x86frame:633"}
		, A.OPER { assem = "\tmovl `s0, " ^ ofs dst ^ "(%ebp)"
			 , src = [EBX]
			 , dst = []
			 , jump = NONE
			 , doc = doc ^ " x86frame:638"}]
    in
        List.concat (map expand body)
    end

fun entryExit1 adjustBody (frame,body) =
    let
        (* extend body to save 'callee save' registers in temporaries *)
        val toSave = calleesaves
        val saved = map (fn _ => Temp.newtemp ()) toSave
        val saveIR = seq (ListPair.mapEq move (saved, toSave))
        val restoreIR = seq (ListPair.mapEq move (toSave, saved))
        val body' = seq [saveIR, adjustBody body, restoreIR]
        val funFormals = formals frame
        (* perform 'view shift': copy arguments passed in registers
         * to frame or temp---but we do not pass any arguments in
         * registers, so this will currently not do anything *)
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

(* inform register allocator about register usage *)
fun procEntryExit2 (frame, body) =
    (A.OPER { assem = "\t# SP, FP, calleesaves, argregs have values"
            , src = []
            , dst = [SP, FP] @ calleesaves @ argregs
            , jump = NONE
            , doc = ""})
    :: body
    @ [A.OPER { assem = "\t# FP, SP, RV, calleesaves still live"
              , src = specialregs @ calleesaves
              , dst = []
              , jump = SOME []
              , doc = ""}]

fun procEntryExit3 ( frame as {name, formals, locals}: frame
                   , body : A.instr list) =
    let
        val toMap = createTempOffsetMap frame body
        val body' = spillAllTemps toMap body
        val size = frameSize frame
        val id = Sy.name name
    in
        { prolog = "\t.text\n" ^
                   "# PROCEDURE " ^ id ^ "\n" ^
                   "\t.globl\t" ^ id ^ "\n" ^
                   "\t.func\t" ^ id ^ "\n" ^
                   "\t.type\t" ^ id ^ ", @function\n" ^
                   id ^ ":\n" ^
                   "\t" ^ frameInfo frame ^ "\n" ^
                   "\tpushl %ebp\n" ^
	           "\tmovl %esp, %ebp\n" ^
	           "\tsubl $" ^ Int.toString size ^ ", %esp\n"
        , body = body'
        , epilog = "\tleave\n" ^
                   "\tret\n" ^
                   "\t.size\t" ^ id ^ ", .-" ^ id ^ "\n" ^
                   "\t.endfunc\n" ^
                   "# END " ^ id ^ "\n\n"}
    end

(* ---------- Printing ---------- *)

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
