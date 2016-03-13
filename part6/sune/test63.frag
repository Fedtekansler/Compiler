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
          NAME L1_fun_isdigit,
          FP,
          NAME L12_string)),
      EXP(
        CONST 0))))

STRING L12_string = "1"

PROC {name = L1_fun_isdigit, formals = tt, locals = 0}
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
            CJUMP(GE,
              CALL(
                NAME ord,
                MEM(
                  BINOP(PLUS,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 8)),
                    CONST 8)),
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 12))),
              CALL(
                NAME ord,
                MEM(
                  BINOP(PLUS,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 8)),
                    CONST 8)),
                NAME L2_string),
              L9_if_then,L10_if_else),
            SEQ(
              LABEL L9_if_then,
              SEQ(
                MOVE(
                  TEMP t110,
                  ESEQ(
                    SEQ(
                      MOVE(
                        TEMP t109,
                        CONST 1),
                      SEQ(
                        CJUMP(LE,
                          CALL(
                            NAME ord,
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 8)),
                                CONST 8)),
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST 12))),
                          CALL(
                            NAME ord,
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 8)),
                                CONST 8)),
                            NAME L3_string),
                          L7_unEx_t,L8_unEx_f),
                        SEQ(
                          LABEL L8_unEx_f,
                          SEQ(
                            MOVE(
                              TEMP t109,
                              CONST 0),
                            LABEL L7_unEx_t)))),
                    TEMP t109)),
                SEQ(
                  JUMP(
                    NAME L11_if_join),
                  SEQ(
                    LABEL L10_if_else,
                    SEQ(
                      MOVE(
                        TEMP t110,
                        CONST 0),
                      LABEL L11_if_join)))))),
          TEMP t110)),
      EXP(
        CONST 0))))

STRING L3_string = "9"

STRING L2_string = "0"

STRING L0_string = "DefaultString"

