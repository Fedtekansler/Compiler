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
          CALL(
            NAME L1_fun_g,
            FP,
            CONST 2))),
      EXP(
        CONST 0))))

PROC {name = L1_fun_g, formals = tt, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      MOVE(
        RV,
        MEM(
          BINOP(PLUS,
            FP,
            CONST 12))),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

