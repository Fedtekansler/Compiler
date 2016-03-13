PROC {name = tigermain, formals = t, locals = 2}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      EXP(
        ESEQ(
          MOVE(
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4)),
            CONST 0),
          ESEQ(
            SEQ(
              MOVE(
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST ~8)),
                CONST 0),
              SEQ(
                MOVE(
                  TEMP t109,
                  CONST 100),
                SEQ(
                  CJUMP(LE,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST ~8)),
                    TEMP t109,
                    L2_for_body,L1_for),
                  SEQ(
                    LABEL L2_for_body,
                    SEQ(
                      SEQ(
                        MOVE(
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST ~4)),
                          BINOP(PLUS,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST ~4)),
                            CONST 1)),
                        EXP(
                          CONST 0)),
                      SEQ(
                        CJUMP(LT,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST ~8)),
                          TEMP t109,
                          L3_for_next,L1_for),
                        SEQ(
                          LABEL L3_for_next,
                          SEQ(
                            MOVE(
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST ~8)),
                              BINOP(PLUS,
                                CONST 1,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST ~8)))),
                            SEQ(
                              JUMP(
                                NAME L2_for_body),
                              LABEL L1_for))))))))),
            CONST 0))),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

