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
            CONST 0),
          ESEQ(
            EXP(
              CALL(
                NAME L1_fun_f,
                FP)),
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4))))),
      EXP(
        CONST 0))))

PROC {name = L1_fun_f, formals = t, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      MOVE(
        MEM(
          BINOP(PLUS,
            MEM(
              BINOP(PLUS,
                FP,
                CONST 8)),
            CONST ~4)),
        BINOP(PLUS,
          MEM(
            BINOP(PLUS,
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST 8)),
              CONST ~4)),
          CONST 1)),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

