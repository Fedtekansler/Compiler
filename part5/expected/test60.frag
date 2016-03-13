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
          NAME stringNotEq,
          NAME L1_string,
          NAME L2_string)),
      EXP(
        CONST 0))))

STRING L2_string = "whateverelse"

STRING L1_string = "whatever"

STRING L0_string = "DefaultString"

