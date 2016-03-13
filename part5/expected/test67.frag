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
              CJUMP(LT,
                CONST 1,
                CONST 2,
                L1_unEx_t,L2_unEx_f),
              SEQ(
                LABEL L2_unEx_f,
                SEQ(
                  MOVE(
                    TEMP t109,
                    CONST 0),
                  LABEL L1_unEx_t)))),
          TEMP t109)),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

