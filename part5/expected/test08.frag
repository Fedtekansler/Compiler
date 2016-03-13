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
            CJUMP(GT,
              CONST 10,
              CONST 20,
              L1_if_then,L2_if_else),
            SEQ(
              LABEL L1_if_then,
              SEQ(
                MOVE(
                  TEMP t109,
                  CONST 30),
                SEQ(
                  JUMP(
                    NAME L3_if_join),
                  SEQ(
                    LABEL L2_if_else,
                    SEQ(
                      MOVE(
                        TEMP t109,
                        CONST 40),
                      LABEL L3_if_join)))))),
          TEMP t109)),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

