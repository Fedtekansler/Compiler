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
          ESEQ(
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
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4))))),
      EXP(
        CONST 0))))

STRING L4_string = "Somebody"

STRING L1_string = "Nobody"

STRING L0_string = "DefaultString"

