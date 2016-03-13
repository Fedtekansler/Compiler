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
        ESEQ(
          SEQ(
            MOVE(
              TEMP t109,
              CONST 1),
            SEQ(
              CJUMP(GE,
                CALL(
                  NAME ord,
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST 8)),
                  NAME L1_string),
                CALL(
                  NAME ord,
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST 8)),
                  NAME L2_string),
                L3_unEx_t,L4_unEx_f),
              SEQ(
                LABEL L4_unEx_f,
                SEQ(
                  MOVE(
                    TEMP t109,
                    CONST 0),
                  LABEL L3_unEx_t)))),
          TEMP t109)),
      EXP(
        CONST 0))))

STRING L2_string = "0"

STRING L1_string = "1"

STRING L0_string = "DefaultString"

