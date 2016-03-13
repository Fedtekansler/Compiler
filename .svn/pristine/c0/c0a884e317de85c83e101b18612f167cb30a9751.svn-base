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
          ESEQ(
            SEQ(
              MOVE(
                TEMP t109,
                CALL(
                  NAME allocRecord,
                  CONST 2)),
              SEQ(
                MOVE(
                  MEM(
                    BINOP(PLUS,
                      TEMP t109,
                      CONST 0)),
                  NAME L1_string),
                MOVE(
                  MEM(
                    BINOP(PLUS,
                      TEMP t109,
                      CONST 4)),
                  CONST 1000))),
            TEMP t109)),
        SEQ(
          MOVE(
            MEM(
              ESEQ(
                SEQ(
                  MOVE(
                    TEMP t110,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST ~4))),
                  SEQ(
                    CJUMP(EQ,
                      TEMP t110,
                      CONST 0,
                      L2_fvar_nil,L3_fvar_nnil),
                    SEQ(
                      LABEL L2_fvar_nil,
                      SEQ(
                        EXP(
                          CALL(
                            NAME recFieldError)),
                        LABEL L3_fvar_nnil)))),
                BINOP(PLUS,
                  TEMP t110,
                  BINOP(MUL,
                    CONST 0,
                    CONST 4)))),
            NAME L4_string),
          SEQ(
            CJUMP(EQ,
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~4)),
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~4)),
              L14_if_then,L15_if_else),
            SEQ(
              LABEL L14_if_then,
              SEQ(
                SEQ(
                  CJUMP(NE,
                    CALL(
                      NAME stringEqual,
                      MEM(
                        ESEQ(
                          SEQ(
                            MOVE(
                              TEMP t111,
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST ~4))),
                            SEQ(
                              CJUMP(EQ,
                                TEMP t111,
                                CONST 0,
                                L5_fvar_nil,L6_fvar_nnil),
                              SEQ(
                                LABEL L5_fvar_nil,
                                SEQ(
                                  EXP(
                                    CALL(
                                      NAME recFieldError)),
                                  LABEL L6_fvar_nnil)))),
                          BINOP(PLUS,
                            TEMP t111,
                            BINOP(MUL,
                              CONST 0,
                              CONST 4)))),
                      NAME L7_string),
                    CONST 0,
                    L10_if_then,L11_if_else),
                  SEQ(
                    LABEL L10_if_then,
                    SEQ(
                      EXP(
                        CALL(
                          NAME print,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST 8)),
                          NAME L8_string)),
                      SEQ(
                        JUMP(
                          NAME L12_if_join),
                        SEQ(
                          LABEL L11_if_else,
                          SEQ(
                            EXP(
                              CALL(
                                NAME print,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 8)),
                                NAME L9_string)),
                            LABEL L12_if_join)))))),
                SEQ(
                  JUMP(
                    NAME L16_if_join),
                  SEQ(
                    LABEL L15_if_else,
                    SEQ(
                      EXP(
                        CALL(
                          NAME print,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST 8)),
                          NAME L13_string)),
                      LABEL L16_if_join)))))))),
      EXP(
        CONST 0))))

STRING L13_string = "FAIL"

STRING L9_string = "FAIL"

STRING L8_string = "SUCCESS"

STRING L7_string = "Somebody"

STRING L4_string = "Somebody"

STRING L1_string = "Nobody"

STRING L0_string = "DefaultString"

