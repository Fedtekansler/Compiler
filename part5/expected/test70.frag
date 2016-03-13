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
          EXP(
            CONST 0),
          CALL(
            NAME getChar,
            MEM(
              BINOP(PLUS,
                FP,
                CONST 8))))),
      EXP(
        CONST 0))))

STRING L0_string = "DefaultString"

