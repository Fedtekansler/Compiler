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
          NAME L1_fun_f,
          FP,
          CONST 10)),
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
        CONST 42),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

