PROC {name = tigermain, formals = t, locals = 1}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      SEQ(
        MOVE(
          MEM(
            BINOP(PLUS,
              FP,
              CONST ~4)),
          CALL(
            NAME initArray,
            CONST 10,
            CONST 0)),
        SEQ(
          CJUMP(EQ,
            MEM(
              ESEQ(
                SEQ(
                  MOVE(
                    TEMP t109,
                    CONST 4),
                  SEQ(
                    MOVE(
                      TEMP t110,
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST ~4))),
                    SEQ(
                      CJUMP(LT,
                        TEMP t109,
                        CONST 0,
                        L1_subs_neg,L2_subs_nneg),
                      SEQ(
                        LABEL L1_subs_neg,
                        SEQ(
                          EXP(
                            CALL(
                              NAME arrInxError,
                              TEMP t109)),
                          SEQ(
                            LABEL L2_subs_nneg,
                            SEQ(
                              CJUMP(GE,
                                TEMP t109,
                                MEM(
                                  BINOP(MINUS,
                                    TEMP t110,
                                    CONST 4)),
                                L3_subs_ovf,L4_subs_novf),
                              SEQ(
                                LABEL L3_subs_ovf,
                                SEQ(
                                  EXP(
                                    CALL(
                                      NAME arrInxError,
                                      TEMP t109)),
                                  LABEL L4_subs_novf))))))))),
                BINOP(PLUS,
                  TEMP t110,
                  BINOP(MUL,
                    TEMP t109,
                    CONST 4)))),
            CONST 0,
            L7_if_then,L8_if_else),
          SEQ(
            LABEL L7_if_then,
            SEQ(
              EXP(
                CALL(
                  NAME print,
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST 8)),
                  NAME L5_string)),
              SEQ(
                JUMP(
                  NAME L9_if_join),
                SEQ(
                  LABEL L8_if_else,
                  SEQ(
                    EXP(
                      CALL(
                        NAME print,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 8)),
                        NAME L6_string)),
                    LABEL L9_if_join))))))),
      EXP(
        CONST 0))))

STRING L6_string = "FAIL"

STRING L5_string = "SUCCESS"

STRING L0_string = "DefaultString"

