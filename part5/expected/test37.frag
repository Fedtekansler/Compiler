PROC {name = tigermain, formals = t, locals = 2}
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
          SEQ(
            MOVE(
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~4)),
              CONST 0),
            MOVE(
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~8)),
              NAME L1_string)),
          MEM(
            BINOP(PLUS,
              FP,
              CONST ~8)))),
      EXP(
        CONST 0))))

STRING L1_string = " "

STRING L0_string = "DefaultString"

