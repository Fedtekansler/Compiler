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
                    CONST 1000),
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        TEMP t109,
                        CONST 4)),
                    NAME L1_string))),
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
                        L2_fieldvar_var_nil,L3_fieldvar_var_not_nil),
                      SEQ(
                        LABEL L2_fieldvar_var_nil,
                        SEQ(
                          EXP(
                            CALL(
                              NAME recFieldError,
                              NAME L4_string,
                              CONST 6,
                              CONST 10)),
                          LABEL L3_fieldvar_var_not_nil)))),
                  BINOP(PLUS,
                    TEMP t110,
                    CONST 4))),
              NAME L5_string),
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4))))),
      EXP(
        CONST 0))))

STRING L5_string = "Somebody"

STRING L4_string = "../testcases/test51.tig"

STRING L1_string = "Nobody"

STRING L0_string = "DefaultString"

