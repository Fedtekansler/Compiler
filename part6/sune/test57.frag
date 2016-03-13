PROC {name = tigermain, formals = t, locals = 2}
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
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~4)),
              CALL(
                NAME L1_fun_f,
                FP,
                CONST 10)),
            MOVE(
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~8)),
              CALL(
                NAME L1_fun_f,
                FP,
                CONST 0))),
          BINOP(PLUS,
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4)),
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~8))))),
      EXP(
        CONST 0))))

PROC {name = L1_fun_f, formals = tt, locals = 0}
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
                        CONST 2),
                      LABEL L4_if_join)))))),
          TEMP t109)),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

