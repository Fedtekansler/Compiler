functor PrintTree(F: FRAME):
        sig
            val asStringStm: Tree.stm -> string
            val asStringExp: Tree.exp -> string
            val asStringFrag: F.frag -> string
            val printStm: TextIO.outstream * Tree.stm -> unit
            val printExp: TextIO.outstream * Tree.exp -> unit
            val printFrag: TextIO.outstream * F.frag -> unit
        end =
struct

structure T = Tree
structure S = Symbol

val indentStep = 2

fun irStringEncode s =
    let
        fun ise [] = []
          | ise (#"\\"::cs) = #"\\" :: #"\\" :: (ise cs)
          | ise (#"\""::cs) = #"\\" :: #"\"" :: (ise cs)
          | ise (c::cs) =
            let
                val ordc = ord(c)
                val octc = Int.fmt StringCvt.OCT ordc
                val padoctc = StringCvt.padLeft #"0" 3 octc
            in
                if 32 <= ordc andalso ordc < 128 then c :: (ise cs)
                else (#"\\" :: (explode padoctc)) @ (ise cs)
            end
    in
        (implode o ise o explode) s
    end

fun indent 0 = ""
  | indent i = " " ^ indent (i-1)

fun stm (T.SEQ (a, b), d) =
    indent d ^
    "SEQ(\n" ^
    stm (a, d+indentStep) ^
    ",\n" ^
    stm (b, d+indentStep) ^
    ")"
  | stm (T.LABEL lab, d) =
    indent d ^
    "LABEL " ^
    S.name lab
  | stm (T.JUMP (e, _), d) =
    indent d ^
    "JUMP(\n" ^
    exp (e, d+indentStep) ^
    ")"
  | stm (T.CJUMP (r, a, b, t, f), d) =
    indent d ^
    "CJUMP(" ^
    relop r ^
    ",\n" ^
    exp (a, d+indentStep) ^
    ",\n" ^
    exp (b, d+indentStep) ^
    ",\n" ^
    indent (d+indentStep) ^
    S.name t ^
    "," ^
    S.name f ^
    ")"
  | stm (T.MOVE (a, b), d) =
    indent d ^
    "MOVE(\n" ^
    exp (a, d+indentStep) ^
    ",\n" ^
    exp (b, d+indentStep) ^
    ")"
  | stm (T.EXP e, d) =
    indent d ^
    "EXP(\n" ^
    exp (e, d+indentStep) ^
    ")"

and exp (T.BINOP (p, a, b), d) =
    indent d ^
    "BINOP(" ^
    binop p ^
    ",\n" ^
    exp (a, d+indentStep) ^
    ",\n" ^
    exp (b, d+indentStep) ^
    ")"
  | exp (T.MEM e, d) =
    indent d ^
    "MEM(\n" ^
    exp (e, d+indentStep) ^
    ")"
  | exp (T.TEMP t, d) =
    indent d ^
    (if t = F.FP then
         "FP"
     else if t = F.RV then
         "RV"
     else
         "TEMP t" ^
         Int.toString t)
  | exp (T.ESEQ (s, e), d) =
    indent d ^
    "ESEQ(\n" ^
    stm (s, d+indentStep) ^
    ",\n" ^
    exp (e, d+indentStep) ^
    ")"
  | exp (T.NAME lab, d) =
    indent d ^
    "NAME " ^
    S.name lab
  | exp (T.CONST i, d) =
    indent d ^
    "CONST " ^
    Int.toString i
  | exp (T.CALL (e, el), d) =
    indent d ^
    "CALL(\n" ^
    exp (e, d+indentStep) ^
    concat (map (fn a => ",\n" ^ exp (a, d+indentStep)) el) ^
    ")"

and binop T.PLUS = "PLUS"
  | binop T.MINUS = "MINUS"
  | binop T.MUL = "MUL"
  | binop T.DIV = "DIV"
  | binop T.AND = "AND"
  | binop T.OR = "OR"
  | binop T.LSHIFT = "LSHIFT"
  | binop T.RSHIFT = "RSHIFT"
  | binop T.ARSHIFT = "ARSHIFT"
  | binop T.XOR = "XOR"

and relop T.EQ = "EQ"
  | relop T.NE = "NE"
  | relop T.LT = "LT"
  | relop T.GT = "GT"
  | relop T.LE = "LE"
  | relop T.GE = "GE"
  | relop T.ULT = "ULT"
  | relop T.ULE = "ULE"
  | relop T.UGT = "UGT"
  | relop T.UGE = "UGE"

fun asStringStm s0 = stm (s0, 0)
fun asStringExp e0 = exp (e0, 0)

fun asStringFrag (F.PROC {body, frame}) =
    "PROC " ^
    F.asStringFrame frame ^
    "\n" ^
    asStringStm body ^
    "\n"

  | asStringFrag (F.STRING (lab, str)) =
    "STRING " ^
    Symbol.name lab ^
    " = \"" ^
    irStringEncode str ^
    "\"\n"

fun printx asStringX (outstream, x) =
    ( TextIO.output (outstream, asStringX x ^ "\n")
    ; TextIO.flushOut outstream)

fun printStm (outstream, s0) = printx asStringStm (outstream, s0)
fun printExp (outstream, e0) = printx asStringExp (outstream, e0)
fun printFrag (outstream, f) = printx asStringFrag (outstream, f)

end (* PrintTree *)

