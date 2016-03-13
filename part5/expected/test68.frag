PROC {name = tigermain, formals = t, locals = 2}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      EXP(
        ESEQ(
          SEQ(
            MOVE(
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~4)),
              CONST 1),
            MOVE(
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~8)),
              CONST 2)),
          ESEQ(
            MOVE(
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~4)),
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~8))),
            CONST 0))),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

