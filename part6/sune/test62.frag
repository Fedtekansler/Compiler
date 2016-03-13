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
            NAME L2_fun_compare,
            FP))),
      EXP(
        CONST 0))))

PROC {name = L2_fun_compare, formals = t, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      MOVE(
        RV,
        CALL(
          NAME stringGreater,
          MEM(
            BINOP(PLUS,
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST 8)),
              CONST ~4)),
          NAME L3_string)),
      EXP(
        CONST 0))))

STRING L3_string = "else"

STRING L1_string = "whatever"

STRING L0_string = "DefaultString"

