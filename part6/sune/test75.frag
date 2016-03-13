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
          NAME L1_fun_mod,
          FP,
          BINOP(MINUS,
            CONST 0,
            CONST 5),
          CONST 3)),
      EXP(
        CONST 0))))

PROC {name = L1_fun_mod, formals = ttt, locals = 0}
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
            CJUMP(GT,
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST 16)),
              CONST 0,
              L20_if_then,L21_if_else),
            SEQ(
              LABEL L20_if_then,
              SEQ(
                MOVE(
                  TEMP t112,
                  ESEQ(
                    SEQ(
                      CJUMP(GE,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 12)),
                        CONST 0,
                        L10_if_then,L11_if_else),
                      SEQ(
                        LABEL L10_if_then,
                        SEQ(
                          MOVE(
                            TEMP t109,
                            CALL(
                              NAME L2_fun_mod_pos,
                              FP,
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST 12)),
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST 16)))),
                          SEQ(
                            JUMP(
                              NAME L12_if_join),
                            SEQ(
                              LABEL L11_if_else,
                              SEQ(
                                MOVE(
                                  TEMP t109,
                                  CALL(
                                    NAME L3_fun_mod_neg,
                                    FP,
                                    MEM(
                                      BINOP(PLUS,
                                        FP,
                                        CONST 12)),
                                    MEM(
                                      BINOP(PLUS,
                                        FP,
                                        CONST 16)))),
                                LABEL L12_if_join)))))),
                    TEMP t109)),
                SEQ(
                  JUMP(
                    NAME L22_if_join),
                  SEQ(
                    LABEL L21_if_else,
                    SEQ(
                      MOVE(
                        TEMP t112,
                        ESEQ(
                          SEQ(
                            CJUMP(LT,
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST 16)),
                              CONST 0,
                              L17_if_then,L18_if_else),
                            SEQ(
                              LABEL L17_if_then,
                              SEQ(
                                MOVE(
                                  TEMP t111,
                                  ESEQ(
                                    SEQ(
                                      CJUMP(GE,
                                        MEM(
                                          BINOP(PLUS,
                                            FP,
                                            CONST 12)),
                                        CONST 0,
                                        L13_if_then,L14_if_else),
                                      SEQ(
                                        LABEL L13_if_then,
                                        SEQ(
                                          MOVE(
                                            TEMP t110,
                                            BINOP(MINUS,
                                              CONST 0,
                                              CALL(
                                                NAME L3_fun_mod_neg,
                                                FP,
                                                BINOP(MINUS,
                                                  CONST 0,
                                                  MEM(
                                                    BINOP(PLUS,
                                                      FP,
                                                      CONST 12))),
                                                BINOP(MINUS,
                                                  CONST 0,
                                                  MEM(
                                                    BINOP(PLUS,
                                                      FP,
                                                      CONST 16)))))),
                                          SEQ(
                                            JUMP(
                                              NAME L15_if_join),
                                            SEQ(
                                              LABEL L14_if_else,
                                              SEQ(
                                                MOVE(
                                                  TEMP t110,
                                                  BINOP(MINUS,
                                                    CONST 0,
                                                    CALL(
                                                      NAME L2_fun_mod_pos,
                                                      FP,
                                                      BINOP(MINUS,
                                                        CONST 0,
                                                        MEM(
                                                          BINOP(PLUS,
                                                            FP,
                                                            CONST 12))),
                                                      BINOP(MINUS,
                                                        CONST 0,
                                                        MEM(
                                                          BINOP(PLUS,
                                                            FP,
                                                            CONST 16)))))),
                                                LABEL L15_if_join)))))),
                                    TEMP t110)),
                                SEQ(
                                  JUMP(
                                    NAME L19_if_join),
                                  SEQ(
                                    LABEL L18_if_else,
                                    SEQ(
                                      MOVE(
                                        TEMP t111,
                                        ESEQ(
                                          EXP(
                                            CALL(
                                              NAME print,
                                              MEM(
                                                BINOP(PLUS,
                                                  MEM(
                                                    BINOP(PLUS,
                                                      FP,
                                                      CONST 8)),
                                                  CONST 8)),
                                              NAME L16_string)),
                                          ESEQ(
                                            EXP(
                                              CALL(
                                                NAME chr,
                                                MEM(
                                                  BINOP(PLUS,
                                                    MEM(
                                                      BINOP(PLUS,
                                                        FP,
                                                        CONST 8)),
                                                    CONST 8)),
                                                BINOP(MINUS,
                                                  CONST 0,
                                                  CONST 1))),
                                            CONST 0))),
                                      LABEL L19_if_join)))))),
                          TEMP t111)),
                      LABEL L22_if_join)))))),
          TEMP t112)),
      EXP(
        CONST 0))))

STRING L16_string = "Error: mod (_,0) "

PROC {name = L3_fun_mod_neg, formals = ttt, locals = 0}
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
            LABEL L8_while_test,
            SEQ(
              CJUMP(LT,
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 12)),
                CONST 0,
                L9_while_body,L7_while),
              SEQ(
                LABEL L9_while_body,
                SEQ(
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 12)),
                    BINOP(PLUS,
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST 12)),
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST 16)))),
                  SEQ(
                    JUMP(
                      NAME L8_while_test),
                    LABEL L7_while))))),
          MEM(
            BINOP(PLUS,
              FP,
              CONST 12)))),
      EXP(
        CONST 0))))

PROC {name = L2_fun_mod_pos, formals = ttt, locals = 0}
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
            LABEL L5_while_test,
            SEQ(
              CJUMP(GE,
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 12)),
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 16)),
                L6_while_body,L4_while),
              SEQ(
                LABEL L6_while_body,
                SEQ(
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 12)),
                    BINOP(MINUS,
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST 12)),
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST 16)))),
                  SEQ(
                    JUMP(
                      NAME L5_while_test),
                    LABEL L4_while))))),
          MEM(
            BINOP(PLUS,
              FP,
              CONST 12)))),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

