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
        CALL(
          NAME ord,
          MEM(
            BINOP(PLUS,
              FP,
              CONST 8)),
          NAME L1_string)),
      EXP(
        CONST 0))))

STRING L1_string = "0"

STRING L0_string = "DefaultString"

