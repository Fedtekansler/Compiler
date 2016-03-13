PROC {name = tigermain, formals = t, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      SEQ(
        EXP(
          CALL(
            NAME L1_fun_chk,
            FP,
            CONST 1,
            CONST 1,
            NAME L6_string)),
        EXP(
          CALL(
            NAME L1_fun_chk,
            FP,
            CONST 0,
            CONST 1,
            NAME L7_string))),
      EXP(
        CONST 0))))

STRING L7_string = "Not OK"

STRING L6_string = "OK"

PROC {name = L1_fun_chk, formals = tttt, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      SEQ(
        CJUMP(EQ,
          MEM(
            BINOP(PLUS,
              FP,
              CONST 12)),
          MEM(
            BINOP(PLUS,
              FP,
              CONST 16)),
          L3_if_then,L4_if_else),
        SEQ(
          LABEL L3_if_then,
          SEQ(
            EXP(
              CALL(
                NAME print,
                MEM(
                  BINOP(PLUS,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 8)),
                    CONST 8)),
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 20)))),
            SEQ(
              JUMP(
                NAME L5_if_join),
              SEQ(
                LABEL L4_if_else,
                SEQ(
                  EXP(
                    CALL(
                      NAME print,
                      MEM(
                        BINOP(PLUS,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST 8)),
                          CONST 8)),
                      NAME L2_string)),
                  LABEL L5_if_join)))))),
      EXP(
        CONST 0))))

STRING L2_string = "."

STRING L0_string = "DefaultString"

