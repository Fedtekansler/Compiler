PROC {name = tigermain, formals = t, locals = 3}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      EXP(
        ESEQ(
          SEQ(
            MOVE(
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~4)),
              CALL(
                NAME getChar,
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 8)))),
            SEQ(
              MOVE(
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST ~8)),
                CALL(
                  NAME L29_fun_readlist,
                  FP)),
              MOVE(
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST ~12)),
                ESEQ(
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST ~4)),
                    CALL(
                      NAME getChar,
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST 8)))),
                  CALL(
                    NAME L29_fun_readlist,
                    FP))))),
          ESEQ(
            EXP(
              CALL(
                NAME L32_fun_printlist,
                FP,
                CALL(
                  NAME L30_fun_merge,
                  FP,
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST ~8)),
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST ~12))))),
            CONST 0))),
      EXP(
        CONST 0))))

PROC {name = L32_fun_printlist, formals = tt, locals = 0}
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
          CONST 0,
          L77_if_then,L78_if_else),
        SEQ(
          LABEL L77_if_then,
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
                NAME L71_string)),
            SEQ(
              JUMP(
                NAME L79_if_join),
              SEQ(
                LABEL L78_if_else,
                SEQ(
                  SEQ(
                    EXP(
                      CALL(
                        NAME L31_fun_printint,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 8)),
                        MEM(
                          ESEQ(
                            SEQ(
                              MOVE(
                                TEMP t128,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 12))),
                              SEQ(
                                CJUMP(EQ,
                                  TEMP t128,
                                  CONST 0,
                                  L72_fieldvar_var_nil,L73_fieldvar_var_not_nil),
                                SEQ(
                                  LABEL L72_fieldvar_var_nil,
                                  SEQ(
                                    EXP(
                                      CALL(
                                        NAME recFieldError,
                                        NAME L24_string,
                                        CONST 56,
                                        CONST 26)),
                                    LABEL L73_fieldvar_var_not_nil)))),
                            BINOP(PLUS,
                              TEMP t128,
                              CONST 0))))),
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
                          NAME L74_string)),
                      EXP(
                        CALL(
                          NAME L32_fun_printlist,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST 8)),
                          MEM(
                            ESEQ(
                              SEQ(
                                MOVE(
                                  TEMP t129,
                                  MEM(
                                    BINOP(PLUS,
                                      FP,
                                      CONST 12))),
                                SEQ(
                                  CJUMP(EQ,
                                    TEMP t129,
                                    CONST 0,
                                    L75_fieldvar_var_nil,L76_fieldvar_var_not_nil),
                                  SEQ(
                                    LABEL L75_fieldvar_var_nil,
                                    SEQ(
                                      EXP(
                                        CALL(
                                          NAME recFieldError,
                                          NAME L24_string,
                                          CONST 56,
                                          CONST 58)),
                                      LABEL L76_fieldvar_var_not_nil)))),
                              BINOP(PLUS,
                                TEMP t129,
                                CONST 4))))))),
                  LABEL L79_if_join)))))),
      EXP(
        CONST 0))))

STRING L74_string = " "

STRING L71_string = "\012"

PROC {name = L31_fun_printint, formals = tt, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      SEQ(
        CJUMP(LT,
          MEM(
            BINOP(PLUS,
              FP,
              CONST 12)),
          CONST 0,
          L68_if_then,L69_if_else),
        SEQ(
          LABEL L68_if_then,
          SEQ(
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
                  NAME L63_string)),
              EXP(
                CALL(
                  NAME L59_fun_f,
                  FP,
                  BINOP(MINUS,
                    CONST 0,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 12)))))),
            SEQ(
              JUMP(
                NAME L70_if_join),
              SEQ(
                LABEL L69_if_else,
                SEQ(
                  SEQ(
                    CJUMP(GT,
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST 12)),
                      CONST 0,
                      L65_if_then,L66_if_else),
                    SEQ(
                      LABEL L65_if_then,
                      SEQ(
                        EXP(
                          CALL(
                            NAME L59_fun_f,
                            FP,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST 12)))),
                        SEQ(
                          JUMP(
                            NAME L67_if_join),
                          SEQ(
                            LABEL L66_if_else,
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
                                  NAME L64_string)),
                              LABEL L67_if_join)))))),
                  LABEL L70_if_join)))))),
      EXP(
        CONST 0))))

STRING L64_string = "0"

STRING L63_string = "-"

PROC {name = L59_fun_f, formals = tt, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      SEQ(
        CJUMP(GT,
          MEM(
            BINOP(PLUS,
              FP,
              CONST 12)),
          CONST 0,
          L61_if_then,L62_if_end),
        SEQ(
          LABEL L61_if_then,
          SEQ(
            SEQ(
              EXP(
                CALL(
                  NAME L59_fun_f,
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST 8)),
                  BINOP(DIV,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 12)),
                    CONST 10))),
              EXP(
                CALL(
                  NAME print,
                  MEM(
                    BINOP(PLUS,
                      MEM(
                        BINOP(PLUS,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST 8)),
                          CONST 8)),
                      CONST 8)),
                  CALL(
                    NAME chr,
                    MEM(
                      BINOP(PLUS,
                        MEM(
                          BINOP(PLUS,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST 8)),
                            CONST 8)),
                        CONST 8)),
                    BINOP(PLUS,
                      BINOP(MINUS,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 12)),
                        BINOP(MUL,
                          BINOP(DIV,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST 12)),
                            CONST 10),
                          CONST 10)),
                      CALL(
                        NAME ord,
                        MEM(
                          BINOP(PLUS,
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 8)),
                                CONST 8)),
                            CONST 8)),
                        NAME L60_string)))))),
            LABEL L62_if_end))),
      EXP(
        CONST 0))))

STRING L60_string = "0"

PROC {name = L30_fun_merge, formals = ttt, locals = 0}
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
              L56_if_then,L57_if_else),
            SEQ(
              LABEL L56_if_then,
              SEQ(
                MOVE(
                  TEMP t127,
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST 16))),
                SEQ(
                  JUMP(
                    NAME L58_if_join),
                  SEQ(
                    LABEL L57_if_else,
                    SEQ(
                      MOVE(
                        TEMP t127,
                        ESEQ(
                          SEQ(
                            CJUMP(EQ,
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST 16)),
                              CONST 0,
                              L53_if_then,L54_if_else),
                            SEQ(
                              LABEL L53_if_then,
                              SEQ(
                                MOVE(
                                  TEMP t126,
                                  MEM(
                                    BINOP(PLUS,
                                      FP,
                                      CONST 12))),
                                SEQ(
                                  JUMP(
                                    NAME L55_if_join),
                                  SEQ(
                                    LABEL L54_if_else,
                                    SEQ(
                                      MOVE(
                                        TEMP t126,
                                        ESEQ(
                                          SEQ(
                                            CJUMP(LT,
                                              MEM(
                                                ESEQ(
                                                  SEQ(
                                                    MOVE(
                                                      TEMP t117,
                                                      MEM(
                                                        BINOP(PLUS,
                                                          FP,
                                                          CONST 12))),
                                                    SEQ(
                                                      CJUMP(EQ,
                                                        TEMP t117,
                                                        CONST 0,
                                                        L38_fieldvar_var_nil,L39_fieldvar_var_not_nil),
                                                      SEQ(
                                                        LABEL L38_fieldvar_var_nil,
                                                        SEQ(
                                                          EXP(
                                                            CALL(
                                                              NAME recFieldError,
                                                              NAME L24_string,
                                                              CONST 40,
                                                              CONST 19)),
                                                          LABEL L39_fieldvar_var_not_nil)))),
                                                  BINOP(PLUS,
                                                    TEMP t117,
                                                    CONST 0))),
                                              MEM(
                                                ESEQ(
                                                  SEQ(
                                                    MOVE(
                                                      TEMP t118,
                                                      MEM(
                                                        BINOP(PLUS,
                                                          FP,
                                                          CONST 16))),
                                                    SEQ(
                                                      CJUMP(EQ,
                                                        TEMP t118,
                                                        CONST 0,
                                                        L40_fieldvar_var_nil,L41_fieldvar_var_not_nil),
                                                      SEQ(
                                                        LABEL L40_fieldvar_var_nil,
                                                        SEQ(
                                                          EXP(
                                                            CALL(
                                                              NAME recFieldError,
                                                              NAME L24_string,
                                                              CONST 40,
                                                              CONST 29)),
                                                          LABEL L41_fieldvar_var_not_nil)))),
                                                  BINOP(PLUS,
                                                    TEMP t118,
                                                    CONST 0))),
                                              L50_if_then,L51_if_else),
                                            SEQ(
                                              LABEL L50_if_then,
                                              SEQ(
                                                MOVE(
                                                  TEMP t125,
                                                  ESEQ(
                                                    SEQ(
                                                      MOVE(
                                                        TEMP t121,
                                                        CALL(
                                                          NAME allocRecord,
                                                          CONST 2)),
                                                      SEQ(
                                                        MOVE(
                                                          MEM(
                                                            BINOP(PLUS,
                                                              TEMP t121,
                                                              CONST 0)),
                                                          MEM(
                                                            ESEQ(
                                                              SEQ(
                                                                MOVE(
                                                                  TEMP t119,
                                                                  MEM(
                                                                    BINOP(PLUS,
                                                                      FP,
                                                                      CONST 12))),
                                                                SEQ(
                                                                  CJUMP(EQ,
                                                                    TEMP t119,
                                                                    CONST 0,
                                                                    L42_fieldvar_var_nil,L43_fieldvar_var_not_nil),
                                                                  SEQ(
                                                                    LABEL L42_fieldvar_var_nil,
                                                                    SEQ(
                                                                      EXP(
                                                                        CALL(
                                                                          NAME recFieldError,
                                                                          NAME L24_string,
                                                                          CONST 41,
                                                                          CONST 31)),
                                                                      LABEL L43_fieldvar_var_not_nil)))),
                                                              BINOP(PLUS,
                                                                TEMP t119,
                                                                CONST 0)))),
                                                        MOVE(
                                                          MEM(
                                                            BINOP(PLUS,
                                                              TEMP t121,
                                                              CONST 4)),
                                                          CALL(
                                                            NAME L30_fun_merge,
                                                            MEM(
                                                              BINOP(PLUS,
                                                                FP,
                                                                CONST 8)),
                                                            MEM(
                                                              ESEQ(
                                                                SEQ(
                                                                  MOVE(
                                                                    TEMP t120,
                                                                    MEM(
                                                                      BINOP(PLUS,
                                                                        FP,
                                                                        CONST 12))),
                                                                  SEQ(
                                                                    CJUMP(EQ,
                                                                      TEMP t120,
                                                                      CONST 0,
                                                                      L44_fieldvar_var_nil,L45_fieldvar_var_not_nil),
                                                                    SEQ(
                                                                      LABEL L44_fieldvar_var_nil,
                                                                      SEQ(
                                                                        EXP(
                                                                          CALL(
                                                                            NAME recFieldError,
                                                                            NAME L24_string,
                                                                            CONST 41,
                                                                            CONST 51)),
                                                                        LABEL L45_fieldvar_var_not_nil)))),
                                                                BINOP(PLUS,
                                                                  TEMP t120,
                                                                  CONST 4))),
                                                            MEM(
                                                              BINOP(PLUS,
                                                                FP,
                                                                CONST 16)))))),
                                                    TEMP t121)),
                                                SEQ(
                                                  JUMP(
                                                    NAME L52_if_join),
                                                  SEQ(
                                                    LABEL L51_if_else,
                                                    SEQ(
                                                      MOVE(
                                                        TEMP t125,
                                                        ESEQ(
                                                          SEQ(
                                                            MOVE(
                                                              TEMP t124,
                                                              CALL(
                                                                NAME allocRecord,
                                                                CONST 2)),
                                                            SEQ(
                                                              MOVE(
                                                                MEM(
                                                                  BINOP(PLUS,
                                                                    TEMP t124,
                                                                    CONST 0)),
                                                                MEM(
                                                                  ESEQ(
                                                                    SEQ(
                                                                      MOVE(
                                                                        TEMP t122,
                                                                        MEM(
                                                                          BINOP(PLUS,
                                                                            FP,
                                                                            CONST 16))),
                                                                      SEQ(
                                                                        CJUMP(EQ,
                                                                          TEMP t122,
                                                                          CONST 0,
                                                                          L46_fieldvar_var_nil,L47_fieldvar_var_not_nil),
                                                                        SEQ(
                                                                          LABEL L46_fieldvar_var_nil,
                                                                          SEQ(
                                                                            EXP(
                                                                              CALL(
                                                                                NAME recFieldError,
                                                                                NAME L24_string,
                                                                                CONST 42,
                                                                                CONST 27)),
                                                                            LABEL L47_fieldvar_var_not_nil)))),
                                                                    BINOP(PLUS,
                                                                      TEMP t122,
                                                                      CONST 0)))),
                                                              MOVE(
                                                                MEM(
                                                                  BINOP(PLUS,
                                                                    TEMP t124,
                                                                    CONST 4)),
                                                                CALL(
                                                                  NAME L30_fun_merge,
                                                                  MEM(
                                                                    BINOP(PLUS,
                                                                      FP,
                                                                      CONST 8)),
                                                                  MEM(
                                                                    BINOP(PLUS,
                                                                      FP,
                                                                      CONST 12)),
                                                                  MEM(
                                                                    ESEQ(
                                                                      SEQ(
                                                                        MOVE(
                                                                          TEMP t123,
                                                                          MEM(
                                                                            BINOP(PLUS,
                                                                              FP,
                                                                              CONST 16))),
                                                                        SEQ(
                                                                          CJUMP(EQ,
                                                                            TEMP t123,
                                                                            CONST 0,
                                                                            L48_fieldvar_var_nil,L49_fieldvar_var_not_nil),
                                                                          SEQ(
                                                                            LABEL L48_fieldvar_var_nil,
                                                                            SEQ(
                                                                              EXP(
                                                                                CALL(
                                                                                  NAME recFieldError,
                                                                                  NAME L24_string,
                                                                                  CONST 42,
                                                                                  CONST 49)),
                                                                              LABEL L49_fieldvar_var_not_nil)))),
                                                                      BINOP(PLUS,
                                                                        TEMP t123,
                                                                        CONST 4))))))),
                                                          TEMP t124)),
                                                      LABEL L52_if_join)))))),
                                          TEMP t125)),
                                      LABEL L55_if_join)))))),
                          TEMP t126)),
                      LABEL L58_if_join)))))),
          TEMP t127)),
      EXP(
        CONST 0))))

PROC {name = L29_fun_readlist, formals = t, locals = 2}
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
              ESEQ(
                SEQ(
                  MOVE(
                    TEMP t113,
                    CALL(
                      NAME allocRecord,
                      CONST 1)),
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        TEMP t113,
                        CONST 0)),
                    CONST 0)),
                TEMP t113)),
            MOVE(
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST ~8)),
              CALL(
                NAME L1_fun_readint,
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 8)),
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST ~4))))),
          ESEQ(
            SEQ(
              CJUMP(NE,
                MEM(
                  ESEQ(
                    SEQ(
                      MOVE(
                        TEMP t114,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST ~4))),
                      SEQ(
                        CJUMP(EQ,
                          TEMP t114,
                          CONST 0,
                          L33_fieldvar_var_nil,L34_fieldvar_var_not_nil),
                        SEQ(
                          LABEL L33_fieldvar_var_nil,
                          SEQ(
                            EXP(
                              CALL(
                                NAME recFieldError,
                                NAME L24_string,
                                CONST 32,
                                CONST 20)),
                            LABEL L34_fieldvar_var_not_nil)))),
                    BINOP(PLUS,
                      TEMP t114,
                      CONST 0))),
                CONST 0,
                L35_if_then,L36_if_else),
              SEQ(
                LABEL L35_if_then,
                SEQ(
                  MOVE(
                    TEMP t116,
                    ESEQ(
                      SEQ(
                        MOVE(
                          TEMP t115,
                          CALL(
                            NAME allocRecord,
                            CONST 2)),
                        SEQ(
                          MOVE(
                            MEM(
                              BINOP(PLUS,
                                TEMP t115,
                                CONST 0)),
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST ~8))),
                          MOVE(
                            MEM(
                              BINOP(PLUS,
                                TEMP t115,
                                CONST 4)),
                            CALL(
                              NAME L29_fun_readlist,
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST 8)))))),
                      TEMP t115)),
                  SEQ(
                    JUMP(
                      NAME L37_if_join),
                    SEQ(
                      LABEL L36_if_else,
                      SEQ(
                        MOVE(
                          TEMP t116,
                          CONST 0),
                        LABEL L37_if_join)))))),
            TEMP t116))),
      EXP(
        CONST 0))))

PROC {name = L1_fun_readint, formals = tt, locals = 1}
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
          MOVE(
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4)),
            CONST 0),
          ESEQ(
            EXP(
              CALL(
                NAME L3_fun_skipto,
                FP)),
            ESEQ(
              MOVE(
                MEM(
                  ESEQ(
                    SEQ(
                      MOVE(
                        TEMP t112,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 12))),
                      SEQ(
                        CJUMP(EQ,
                          TEMP t112,
                          CONST 0,
                          L22_fieldvar_var_nil,L23_fieldvar_var_not_nil),
                        SEQ(
                          LABEL L22_fieldvar_var_nil,
                          SEQ(
                            EXP(
                              CALL(
                                NAME recFieldError,
                                NAME L24_string,
                                CONST 19,
                                CONST 17)),
                            LABEL L23_fieldvar_var_not_nil)))),
                    BINOP(PLUS,
                      TEMP t112,
                      CONST 0))),
                CALL(
                  NAME L2_fun_isdigit,
                  FP,
                  MEM(
                    BINOP(PLUS,
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST 8)),
                      CONST ~4)))),
              ESEQ(
                SEQ(
                  LABEL L27_while_test,
                  SEQ(
                    CJUMP(NE,
                      CALL(
                        NAME L2_fun_isdigit,
                        FP,
                        MEM(
                          BINOP(PLUS,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST 8)),
                            CONST ~4))),
                      CONST 0,
                      L28_while_body,L25_while),
                    SEQ(
                      LABEL L28_while_body,
                      SEQ(
                        SEQ(
                          MOVE(
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST ~4)),
                            BINOP(MINUS,
                              BINOP(PLUS,
                                BINOP(MUL,
                                  MEM(
                                    BINOP(PLUS,
                                      FP,
                                      CONST ~4)),
                                  CONST 10),
                                CALL(
                                  NAME ord,
                                  MEM(
                                    BINOP(PLUS,
                                      MEM(
                                        BINOP(PLUS,
                                          FP,
                                          CONST 8)),
                                      CONST 8)),
                                  MEM(
                                    BINOP(PLUS,
                                      MEM(
                                        BINOP(PLUS,
                                          FP,
                                          CONST 8)),
                                      CONST ~4)))),
                              CALL(
                                NAME ord,
                                MEM(
                                  BINOP(PLUS,
                                    MEM(
                                      BINOP(PLUS,
                                        FP,
                                        CONST 8)),
                                    CONST 8)),
                                NAME L26_string))),
                          MOVE(
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 8)),
                                CONST ~4)),
                            CALL(
                              NAME getChar,
                              MEM(
                                BINOP(PLUS,
                                  MEM(
                                    BINOP(PLUS,
                                      FP,
                                      CONST 8)),
                                  CONST 8))))),
                        SEQ(
                          JUMP(
                            NAME L27_while_test),
                          LABEL L25_while))))),
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST ~4))))))),
      EXP(
        CONST 0))))

STRING L26_string = "0"

STRING L24_string = "../testcases/merge.tig"

PROC {name = L3_fun_skipto, formals = t, locals = 0}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      SEQ(
        LABEL L20_while_test,
        SEQ(
          CJUMP(NE,
            ESEQ(
              SEQ(
                CJUMP(NE,
                  CALL(
                    NAME stringEqual,
                    MEM(
                      BINOP(PLUS,
                        MEM(
                          BINOP(PLUS,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST 8)),
                            CONST 8)),
                        CONST ~4)),
                    NAME L14_string),
                  CONST 0,
                  L16_if_then,L17_if_else),
                SEQ(
                  LABEL L16_if_then,
                  SEQ(
                    MOVE(
                      TEMP t111,
                      CONST 1),
                    SEQ(
                      JUMP(
                        NAME L18_if_join),
                      SEQ(
                        LABEL L17_if_else,
                        SEQ(
                          MOVE(
                            TEMP t111,
                            CALL(
                              NAME stringEqual,
                              MEM(
                                BINOP(PLUS,
                                  MEM(
                                    BINOP(PLUS,
                                      MEM(
                                        BINOP(PLUS,
                                          FP,
                                          CONST 8)),
                                      CONST 8)),
                                  CONST ~4)),
                              NAME L15_string)),
                          LABEL L18_if_join)))))),
              TEMP t111),
            CONST 0,
            L21_while_body,L19_while),
          SEQ(
            LABEL L21_while_body,
            SEQ(
              MOVE(
                MEM(
                  BINOP(PLUS,
                    MEM(
                      BINOP(PLUS,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 8)),
                        CONST 8)),
                    CONST ~4)),
                CALL(
                  NAME getChar,
                  MEM(
                    BINOP(PLUS,
                      MEM(
                        BINOP(PLUS,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST 8)),
                          CONST 8)),
                      CONST 8)))),
              SEQ(
                JUMP(
                  NAME L20_while_test),
                LABEL L19_while))))),
      EXP(
        CONST 0))))

STRING L15_string = "\012"

STRING L14_string = " "

PROC {name = L2_fun_isdigit, formals = tt, locals = 0}
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
            CJUMP(GE,
              CALL(
                NAME ord,
                MEM(
                  BINOP(PLUS,
                    MEM(
                      BINOP(PLUS,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 8)),
                        CONST 8)),
                    CONST 8)),
                MEM(
                  BINOP(PLUS,
                    MEM(
                      BINOP(PLUS,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 8)),
                        CONST 8)),
                    CONST ~4))),
              CALL(
                NAME ord,
                MEM(
                  BINOP(PLUS,
                    MEM(
                      BINOP(PLUS,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST 8)),
                        CONST 8)),
                    CONST 8)),
                NAME L4_string),
              L11_if_then,L12_if_else),
            SEQ(
              LABEL L11_if_then,
              SEQ(
                MOVE(
                  TEMP t110,
                  ESEQ(
                    SEQ(
                      MOVE(
                        TEMP t109,
                        CONST 1),
                      SEQ(
                        CJUMP(LE,
                          CALL(
                            NAME ord,
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    MEM(
                                      BINOP(PLUS,
                                        FP,
                                        CONST 8)),
                                    CONST 8)),
                                CONST 8)),
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    MEM(
                                      BINOP(PLUS,
                                        FP,
                                        CONST 8)),
                                    CONST 8)),
                                CONST ~4))),
                          CALL(
                            NAME ord,
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    MEM(
                                      BINOP(PLUS,
                                        FP,
                                        CONST 8)),
                                    CONST 8)),
                                CONST 8)),
                            NAME L5_string),
                          L9_unEx_t,L10_unEx_f),
                        SEQ(
                          LABEL L10_unEx_f,
                          SEQ(
                            MOVE(
                              TEMP t109,
                              CONST 0),
                            LABEL L9_unEx_t)))),
                    TEMP t109)),
                SEQ(
                  JUMP(
                    NAME L13_if_join),
                  SEQ(
                    LABEL L12_if_else,
                    SEQ(
                      MOVE(
                        TEMP t110,
                        CONST 0),
                      LABEL L13_if_join)))))),
          TEMP t110)),
      EXP(
        CONST 0))))

STRING L5_string = "9"

STRING L4_string = "0"

STRING L0_string = "DefaultString"

