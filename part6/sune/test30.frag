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
            CALL(
              NAME initArray,
              CONST 10,
              CONST 0,
              NAME L1_string,
              CONST 6,
              CONST 20)),
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
                  L4_subs_nilerror,L6_subs_nnil),
                SEQ(
                  LABEL L4_subs_nilerror,
                  SEQ(
                    EXP(
                      CALL(
                        NAME arrNilError,
                        NAME L1_string,
                        CONST 8,
                        CONST 9)),
                    SEQ(
                      LABEL L6_subs_nnil,
                      SEQ(
                        MOVE(
                          TEMP t109,
                          CONST 2),
                        SEQ(
                          MOVE(
                            TEMP t112,
                            MEM(
                              BINOP(MINUS,
                                TEMP t110,
                                CONST 4))),
                          SEQ(
                            CJUMP(GE,
                              TEMP t109,
                              CONST 0,
                              L2_subs_nneg,L3_subs_idxerror),
                            SEQ(
                              LABEL L2_subs_nneg,
                              SEQ(
                                CJUMP(LT,
                                  TEMP t109,
                                  TEMP t112,
                                  L5_subs_noerror,L3_subs_idxerror),
                                SEQ(
                                  LABEL L3_subs_idxerror,
                                  SEQ(
                                    EXP(
                                      CALL(
                                        NAME arrInxError,
                                        CONST 2,
                                        NAME L1_string,
                                        CONST 8,
                                        CONST 9)),
                                    SEQ(
                                      LABEL L5_subs_noerror,
                                      MOVE(
                                        TEMP t111,
                                        BINOP(PLUS,
                                          TEMP t110,
                                          BINOP(MUL,
                                            TEMP t109,
                                            CONST 4)))))))))))))))),
            MEM(
              TEMP t111)))),
      EXP(
        CONST 0))))

STRING L1_string = "../testcases/test30.tig"

STRING L0_string = "DefaultString"

