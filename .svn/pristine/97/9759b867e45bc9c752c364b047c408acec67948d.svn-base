PROC {name = tigermain, formals = t, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      SEQ(
        CJUMP(EQ,
          CALL(
            NAME L1_nfactor,
            FP,
            CONST 10),
          CONST 3628800,
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
                  LABEL L9_if_join)))))),
      EXP(
        CONST 0))))

STRING L6_string = "FAIL"

STRING L5_string = "SUCCESS"

PROC {name = L1_nfactor, formals = tt, locals = 0}
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
            CJUMP(EQ,
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST 12)),
              CONST 0,
              L2_if_then,L3_if_else),
            SEQ(
              LABEL L2_if_then,
              SEQ(
                MOVE(
                  TEMP t109,
                  CONST 1),
                SEQ(
                  JUMP(
                    NAME L4_if_join),
                  SEQ(
                    LABEL L3_if_else,
                    SEQ(
                      MOVE(
                        TEMP t109,
                        BINOP(MUL,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST 12)),
                          CALL(
                            NAME L1_nfactor,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST 8)),
                            BINOP(MINUS,
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST 12)),
                              CONST 1)))),
                      LABEL L4_if_join)))))),
          TEMP t109)),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

