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
            NAME L2_fun_isdigit,
            FP))),
      EXP(
        CONST 0))))

PROC {name = L2_fun_isdigit, formals = t, locals = 0}
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
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 8)),
                    CONST ~4))),
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
              L10_if_then,L11_if_else),
            SEQ(
              LABEL L10_if_then,
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
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 8)),
                                CONST ~4))),
                          CALL(
                            NAME ord,
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 8)),
                                CONST 8)),
                            NAME L4_string),
                          L8_unEx_t,L9_unEx_f),
                        SEQ(
                          LABEL L9_unEx_f,
                          SEQ(
                            MOVE(
                              TEMP t109,
                              CONST 0),
                            LABEL L8_unEx_t)))),
                    TEMP t109)),
                SEQ(
                  JUMP(
                    NAME L12_if_join),
                  SEQ(
                    LABEL L11_if_else,
                    SEQ(
                      MOVE(
                        TEMP t110,
                        CONST 0),
                      LABEL L12_if_join)))))),
          TEMP t110)),
      EXP(
        CONST 0))))

STRING L4_string = "9"

STRING L3_string = "0"

STRING L1_string = "5"

STRING L0_string = "DefaultString"

