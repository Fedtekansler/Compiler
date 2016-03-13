PROC {name = tigermain, formals = t, locals = 1}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      MOVE(
        RV,
        ESEQ(
          MOVE(
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4)),
            NAME L1_string),
          CALL(
            NAME stringGreater,
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4)),
            NAME L2_string))),
      EXP(
        CONST 0))))

STRING L2_string = "else"

STRING L1_string = "whatever"

STRING L0_string = "DefaultString"

