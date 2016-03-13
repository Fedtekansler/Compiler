PROC {name = tigermain, formals = t, locals = 0}
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
          NAME L1_fun_do_nothing1,
          FP,
          CONST 0,
          NAME L5_string)),
      EXP(
        CONST 0))))

STRING L5_string = "str2"

PROC {name = L2_fun_do_nothing2, formals = tt, locals = 0}
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
          EXP(
            CALL(
              NAME L1_fun_do_nothing1,
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST 8)),
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST 12)),
              NAME L3_string)),
          NAME L4_string)),
      EXP(
        CONST 0))))

STRING L4_string = " "

STRING L3_string = "str"

PROC {name = L1_fun_do_nothing1, formals = ttt, locals = 0}
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
          EXP(
            CALL(
              NAME L2_fun_do_nothing2,
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST 8)),
              BINOP(PLUS,
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 12)),
                CONST 1))),
          CONST 0)),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

