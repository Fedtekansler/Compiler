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
            CALL(
              NAME initArray,
              CONST 10,
              CONST 0)),
          MEM(
            BINOP(PLUS,
              FP,
              CONST ~4)))),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

