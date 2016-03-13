structure Tree: TREE =
struct

type label = Temp.label

datatype stm = SEQ of stm * stm
             | LABEL of label
             | JUMP of exp * label list
             | CJUMP of relop * exp * exp * label * label
	     | MOVE of exp * exp
             | EXP of exp

     and exp = BINOP of binop * exp * exp
             | MEM of exp
             | TEMP of Temp.temp
             | ESEQ of stm * exp
             | NAME of label
             | CONST of int
	     | CALL of exp * exp list

   and binop = PLUS | MINUS | MUL | DIV
             | AND | OR | LSHIFT | RSHIFT | ARSHIFT | XOR

   and relop = EQ | NE | LT | GT | LE | GE
             | ULT | ULE | UGT | UGE

fun notRel EQ = NE
  | notRel NE = EQ
  | notRel LT = GE
  | notRel GT = LE
  | notRel LE = GT
  | notRel GE = LT
  | notRel ULT = UGE
  | notRel ULE = UGT
  | notRel UGT = ULE
  | notRel UGE = ULT

fun symRel EQ = EQ
  | symRel NE = NE
  | symRel LT = GT
  | symRel GT = LT
  | symRel LE = GE
  | symRel GE = LE
  | symRel ULT = UGT
  | symRel ULE = UGE
  | symRel UGT = ULT
  | symRel UGE = ULE

end (* Tree *)

