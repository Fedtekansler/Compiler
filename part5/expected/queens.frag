PROC {name = tigermain, formals = t, locals = 5}
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
              CONST 8),
            SEQ(
              MOVE(
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST ~8)),
                CALL(
                  NAME initArray,
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST ~4)),
                  CONST 0,
                  NAME L1_string,
                  CONST 7,
                  CONST 16)),
              SEQ(
                MOVE(
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST ~12)),
                  CALL(
                    NAME initArray,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST ~4)),
                    CONST 0,
                    NAME L1_string,
                    CONST 8,
                    CONST 16)),
                SEQ(
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST ~16)),
                    CALL(
                      NAME initArray,
                      BINOP(MINUS,
                        BINOP(PLUS,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST ~4)),
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST ~4))),
                        CONST 1),
                      CONST 0,
                      NAME L1_string,
                      CONST 9,
                      CONST 18)),
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST ~20)),
                    CALL(
                      NAME initArray,
                      BINOP(MINUS,
                        BINOP(PLUS,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST ~4)),
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST ~4))),
                        CONST 1),
                      CONST 0,
                      NAME L1_string,
                      CONST 10,
                      CONST 18)))))),
          ESEQ(
            EXP(
              CALL(
                NAME L3_fun_try,
                FP,
                CONST 0)),
            CONST 0))),
      EXP(
        CONST 0))))

PROC {name = L3_fun_try, formals = tt, locals = 1}
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
              MEM(
                BINOP(PLUS,
                  FP,
                  CONST 8)),
              CONST ~4)),
          L93_if_then,L94_if_else),
        SEQ(
          LABEL L93_if_then,
          SEQ(
            EXP(
              CALL(
                NAME L2_fun_printboard,
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST 8)))),
            SEQ(
              JUMP(
                NAME L95_if_join),
              SEQ(
                LABEL L94_if_else,
                SEQ(
                  SEQ(
                    MOVE(
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST ~4)),
                      CONST 0),
                    SEQ(
                      MOVE(
                        TEMP t160,
                        BINOP(MINUS,
                          MEM(
                            BINOP(PLUS,
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST 8)),
                              CONST ~4)),
                          CONST 1)),
                      SEQ(
                        CJUMP(LE,
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST ~4)),
                          TEMP t160,
                          L91_for_body,L22_for),
                        SEQ(
                          LABEL L91_for_body,
                          SEQ(
                            SEQ(
                              CJUMP(NE,
                                ESEQ(
                                  SEQ(
                                    CJUMP(NE,
                                      ESEQ(
                                        SEQ(
                                          CJUMP(EQ,
                                            ESEQ(
                                              SEQ(
                                                MOVE(
                                                  TEMP t117,
                                                  MEM(
                                                    BINOP(PLUS,
                                                      MEM(
                                                        BINOP(PLUS,
                                                          FP,
                                                          CONST 8)),
                                                      CONST ~8))),
                                                SEQ(
                                                  CJUMP(EQ,
                                                    TEMP t117,
                                                    CONST 0,
                                                    L25_subs_nilerror,L27_subs_nnil),
                                                  SEQ(
                                                    LABEL L25_subs_nilerror,
                                                    SEQ(
                                                      EXP(
                                                        CALL(
                                                          NAME arrNilError,
                                                          NAME L1_string,
                                                          CONST 23,
                                                          CONST 24)),
                                                      SEQ(
                                                        LABEL L27_subs_nnil,
                                                        SEQ(
                                                          MOVE(
                                                            TEMP t116,
                                                            MEM(
                                                              BINOP(PLUS,
                                                                FP,
                                                                CONST ~4))),
                                                          SEQ(
                                                            MOVE(
                                                              TEMP t119,
                                                              MEM(
                                                                BINOP(MINUS,
                                                                  TEMP t117,
                                                                  CONST 4))),
                                                            SEQ(
                                                              CJUMP(GE,
                                                                TEMP t116,
                                                                CONST 0,
                                                                L23_subs_nneg,L24_subs_idxerror),
                                                              SEQ(
                                                                LABEL L23_subs_nneg,
                                                                SEQ(
                                                                  CJUMP(LT,
                                                                    TEMP t116,
                                                                    TEMP t119,
                                                                    L26_subs_noerror,L24_subs_idxerror),
                                                                  SEQ(
                                                                    LABEL L24_subs_idxerror,
                                                                    SEQ(
                                                                      EXP(
                                                                        CALL(
                                                                          NAME arrInxError,
                                                                          MEM(
                                                                            BINOP(PLUS,
                                                                              FP,
                                                                              CONST ~4)),
                                                                          NAME L1_string,
                                                                          CONST 23,
                                                                          CONST 24)),
                                                                      SEQ(
                                                                        LABEL L26_subs_noerror,
                                                                        MOVE(
                                                                          TEMP t118,
                                                                          BINOP(PLUS,
                                                                            TEMP t117,
                                                                            BINOP(MUL,
                                                                              TEMP t116,
                                                                              CONST 4)))))))))))))))),
                                              MEM(
                                                TEMP t118)),
                                            CONST 0,
                                            L38_if_then,L39_if_else),
                                          SEQ(
                                            LABEL L38_if_then,
                                            SEQ(
                                              MOVE(
                                                TEMP t125,
                                                ESEQ(
                                                  SEQ(
                                                    MOVE(
                                                      TEMP t124,
                                                      CONST 1),
                                                    SEQ(
                                                      CJUMP(EQ,
                                                        ESEQ(
                                                          SEQ(
                                                            MOVE(
                                                              TEMP t121,
                                                              MEM(
                                                                BINOP(PLUS,
                                                                  MEM(
                                                                    BINOP(PLUS,
                                                                      FP,
                                                                      CONST 8)),
                                                                  CONST ~16))),
                                                            SEQ(
                                                              CJUMP(EQ,
                                                                TEMP t121,
                                                                CONST 0,
                                                                L30_subs_nilerror,L32_subs_nnil),
                                                              SEQ(
                                                                LABEL L30_subs_nilerror,
                                                                SEQ(
                                                                  EXP(
                                                                    CALL(
                                                                      NAME arrNilError,
                                                                      NAME L1_string,
                                                                      CONST 23,
                                                                      CONST 37)),
                                                                  SEQ(
                                                                    LABEL L32_subs_nnil,
                                                                    SEQ(
                                                                      MOVE(
                                                                        TEMP t120,
                                                                        BINOP(PLUS,
                                                                          MEM(
                                                                            BINOP(PLUS,
                                                                              FP,
                                                                              CONST ~4)),
                                                                          MEM(
                                                                            BINOP(PLUS,
                                                                              FP,
                                                                              CONST 12)))),
                                                                      SEQ(
                                                                        MOVE(
                                                                          TEMP t123,
                                                                          MEM(
                                                                            BINOP(MINUS,
                                                                              TEMP t121,
                                                                              CONST 4))),
                                                                        SEQ(
                                                                          CJUMP(GE,
                                                                            TEMP t120,
                                                                            CONST 0,
                                                                            L28_subs_nneg,L29_subs_idxerror),
                                                                          SEQ(
                                                                            LABEL L28_subs_nneg,
                                                                            SEQ(
                                                                              CJUMP(LT,
                                                                                TEMP t120,
                                                                                TEMP t123,
                                                                                L31_subs_noerror,L29_subs_idxerror),
                                                                              SEQ(
                                                                                LABEL L29_subs_idxerror,
                                                                                SEQ(
                                                                                  EXP(
                                                                                    CALL(
                                                                                      NAME arrInxError,
                                                                                      BINOP(PLUS,
                                                                                        MEM(
                                                                                          BINOP(PLUS,
                                                                                            FP,
                                                                                            CONST ~4)),
                                                                                        MEM(
                                                                                          BINOP(PLUS,
                                                                                            FP,
                                                                                            CONST 12))),
                                                                                      NAME L1_string,
                                                                                      CONST 23,
                                                                                      CONST 37)),
                                                                                  SEQ(
                                                                                    LABEL L31_subs_noerror,
                                                                                    MOVE(
                                                                                      TEMP t122,
                                                                                      BINOP(PLUS,
                                                                                        TEMP t121,
                                                                                        BINOP(MUL,
                                                                                          TEMP t120,
                                                                                          CONST 4)))))))))))))))),
                                                          MEM(
                                                            TEMP t122)),
                                                        CONST 0,
                                                        L36_unEx_t,L37_unEx_f),
                                                      SEQ(
                                                        LABEL L37_unEx_f,
                                                        SEQ(
                                                          MOVE(
                                                            TEMP t124,
                                                            CONST 0),
                                                          LABEL L36_unEx_t)))),
                                                  TEMP t124)),
                                              SEQ(
                                                JUMP(
                                                  NAME L40_if_join),
                                                SEQ(
                                                  LABEL L39_if_else,
                                                  SEQ(
                                                    MOVE(
                                                      TEMP t125,
                                                      CONST 0),
                                                    LABEL L40_if_join)))))),
                                        TEMP t125),
                                      CONST 0,
                                      L51_if_then,L52_if_else),
                                    SEQ(
                                      LABEL L51_if_then,
                                      SEQ(
                                        MOVE(
                                          TEMP t131,
                                          ESEQ(
                                            SEQ(
                                              MOVE(
                                                TEMP t130,
                                                CONST 1),
                                              SEQ(
                                                CJUMP(EQ,
                                                  ESEQ(
                                                    SEQ(
                                                      MOVE(
                                                        TEMP t127,
                                                        MEM(
                                                          BINOP(PLUS,
                                                            MEM(
                                                              BINOP(PLUS,
                                                                FP,
                                                                CONST 8)),
                                                            CONST ~20))),
                                                      SEQ(
                                                        CJUMP(EQ,
                                                          TEMP t127,
                                                          CONST 0,
                                                          L43_subs_nilerror,L45_subs_nnil),
                                                        SEQ(
                                                          LABEL L43_subs_nilerror,
                                                          SEQ(
                                                            EXP(
                                                              CALL(
                                                                NAME arrNilError,
                                                                NAME L1_string,
                                                                CONST 23,
                                                                CONST 52)),
                                                            SEQ(
                                                              LABEL L45_subs_nnil,
                                                              SEQ(
                                                                MOVE(
                                                                  TEMP t126,
                                                                  BINOP(MINUS,
                                                                    BINOP(PLUS,
                                                                      MEM(
                                                                        BINOP(PLUS,
                                                                          FP,
                                                                          CONST ~4)),
                                                                      CONST 7),
                                                                    MEM(
                                                                      BINOP(PLUS,
                                                                        FP,
                                                                        CONST 12)))),
                                                                SEQ(
                                                                  MOVE(
                                                                    TEMP t129,
                                                                    MEM(
                                                                      BINOP(MINUS,
                                                                        TEMP t127,
                                                                        CONST 4))),
                                                                  SEQ(
                                                                    CJUMP(GE,
                                                                      TEMP t126,
                                                                      CONST 0,
                                                                      L41_subs_nneg,L42_subs_idxerror),
                                                                    SEQ(
                                                                      LABEL L41_subs_nneg,
                                                                      SEQ(
                                                                        CJUMP(LT,
                                                                          TEMP t126,
                                                                          TEMP t129,
                                                                          L44_subs_noerror,L42_subs_idxerror),
                                                                        SEQ(
                                                                          LABEL L42_subs_idxerror,
                                                                          SEQ(
                                                                            EXP(
                                                                              CALL(
                                                                                NAME arrInxError,
                                                                                BINOP(MINUS,
                                                                                  BINOP(PLUS,
                                                                                    MEM(
                                                                                      BINOP(PLUS,
                                                                                        FP,
                                                                                        CONST ~4)),
                                                                                    CONST 7),
                                                                                  MEM(
                                                                                    BINOP(PLUS,
                                                                                      FP,
                                                                                      CONST 12))),
                                                                                NAME L1_string,
                                                                                CONST 23,
                                                                                CONST 52)),
                                                                            SEQ(
                                                                              LABEL L44_subs_noerror,
                                                                              MOVE(
                                                                                TEMP t128,
                                                                                BINOP(PLUS,
                                                                                  TEMP t127,
                                                                                  BINOP(MUL,
                                                                                    TEMP t126,
                                                                                    CONST 4)))))))))))))))),
                                                    MEM(
                                                      TEMP t128)),
                                                  CONST 0,
                                                  L49_unEx_t,L50_unEx_f),
                                                SEQ(
                                                  LABEL L50_unEx_f,
                                                  SEQ(
                                                    MOVE(
                                                      TEMP t130,
                                                      CONST 0),
                                                    LABEL L49_unEx_t)))),
                                            TEMP t130)),
                                        SEQ(
                                          JUMP(
                                            NAME L53_if_join),
                                          SEQ(
                                            LABEL L52_if_else,
                                            SEQ(
                                              MOVE(
                                                TEMP t131,
                                                CONST 0),
                                              LABEL L53_if_join)))))),
                                  TEMP t131),
                                CONST 0,
                                L89_if_then,L90_if_end),
                              SEQ(
                                LABEL L89_if_then,
                                SEQ(
                                  SEQ(
                                    MOVE(
                                      ESEQ(
                                        SEQ(
                                          MOVE(
                                            TEMP t133,
                                            MEM(
                                              BINOP(PLUS,
                                                MEM(
                                                  BINOP(PLUS,
                                                    FP,
                                                    CONST 8)),
                                                CONST ~8))),
                                          SEQ(
                                            CJUMP(EQ,
                                              TEMP t133,
                                              CONST 0,
                                              L56_subs_nilerror,L58_subs_nnil),
                                            SEQ(
                                              LABEL L56_subs_nilerror,
                                              SEQ(
                                                EXP(
                                                  CALL(
                                                    NAME arrNilError,
                                                    NAME L1_string,
                                                    CONST 24,
                                                    CONST 27)),
                                                SEQ(
                                                  LABEL L58_subs_nnil,
                                                  SEQ(
                                                    MOVE(
                                                      TEMP t132,
                                                      MEM(
                                                        BINOP(PLUS,
                                                          FP,
                                                          CONST ~4))),
                                                    SEQ(
                                                      MOVE(
                                                        TEMP t135,
                                                        MEM(
                                                          BINOP(MINUS,
                                                            TEMP t133,
                                                            CONST 4))),
                                                      SEQ(
                                                        CJUMP(GE,
                                                          TEMP t132,
                                                          CONST 0,
                                                          L54_subs_nneg,L55_subs_idxerror),
                                                        SEQ(
                                                          LABEL L54_subs_nneg,
                                                          SEQ(
                                                            CJUMP(LT,
                                                              TEMP t132,
                                                              TEMP t135,
                                                              L57_subs_noerror,L55_subs_idxerror),
                                                            SEQ(
                                                              LABEL L55_subs_idxerror,
                                                              SEQ(
                                                                EXP(
                                                                  CALL(
                                                                    NAME arrInxError,
                                                                    MEM(
                                                                      BINOP(PLUS,
                                                                        FP,
                                                                        CONST ~4)),
                                                                    NAME L1_string,
                                                                    CONST 24,
                                                                    CONST 27)),
                                                                SEQ(
                                                                  LABEL L57_subs_noerror,
                                                                  MOVE(
                                                                    TEMP t134,
                                                                    BINOP(PLUS,
                                                                      TEMP t133,
                                                                      BINOP(MUL,
                                                                        TEMP t132,
                                                                        CONST 4)))))))))))))))),
                                        MEM(
                                          TEMP t134)),
                                      CONST 1),
                                    SEQ(
                                      MOVE(
                                        ESEQ(
                                          SEQ(
                                            MOVE(
                                              TEMP t137,
                                              MEM(
                                                BINOP(PLUS,
                                                  MEM(
                                                    BINOP(PLUS,
                                                      FP,
                                                      CONST 8)),
                                                  CONST ~16))),
                                            SEQ(
                                              CJUMP(EQ,
                                                TEMP t137,
                                                CONST 0,
                                                L61_subs_nilerror,L63_subs_nnil),
                                              SEQ(
                                                LABEL L61_subs_nilerror,
                                                SEQ(
                                                  EXP(
                                                    CALL(
                                                      NAME arrNilError,
                                                      NAME L1_string,
                                                      CONST 24,
                                                      CONST 40)),
                                                  SEQ(
                                                    LABEL L63_subs_nnil,
                                                    SEQ(
                                                      MOVE(
                                                        TEMP t136,
                                                        BINOP(PLUS,
                                                          MEM(
                                                            BINOP(PLUS,
                                                              FP,
                                                              CONST ~4)),
                                                          MEM(
                                                            BINOP(PLUS,
                                                              FP,
                                                              CONST 12)))),
                                                      SEQ(
                                                        MOVE(
                                                          TEMP t139,
                                                          MEM(
                                                            BINOP(MINUS,
                                                              TEMP t137,
                                                              CONST 4))),
                                                        SEQ(
                                                          CJUMP(GE,
                                                            TEMP t136,
                                                            CONST 0,
                                                            L59_subs_nneg,L60_subs_idxerror),
                                                          SEQ(
                                                            LABEL L59_subs_nneg,
                                                            SEQ(
                                                              CJUMP(LT,
                                                                TEMP t136,
                                                                TEMP t139,
                                                                L62_subs_noerror,L60_subs_idxerror),
                                                              SEQ(
                                                                LABEL L60_subs_idxerror,
                                                                SEQ(
                                                                  EXP(
                                                                    CALL(
                                                                      NAME arrInxError,
                                                                      BINOP(PLUS,
                                                                        MEM(
                                                                          BINOP(PLUS,
                                                                            FP,
                                                                            CONST ~4)),
                                                                        MEM(
                                                                          BINOP(PLUS,
                                                                            FP,
                                                                            CONST 12))),
                                                                      NAME L1_string,
                                                                      CONST 24,
                                                                      CONST 40)),
                                                                  SEQ(
                                                                    LABEL L62_subs_noerror,
                                                                    MOVE(
                                                                      TEMP t138,
                                                                      BINOP(PLUS,
                                                                        TEMP t137,
                                                                        BINOP(MUL,
                                                                          TEMP t136,
                                                                          CONST 4)))))))))))))))),
                                          MEM(
                                            TEMP t138)),
                                        CONST 1),
                                      SEQ(
                                        MOVE(
                                          ESEQ(
                                            SEQ(
                                              MOVE(
                                                TEMP t141,
                                                MEM(
                                                  BINOP(PLUS,
                                                    MEM(
                                                      BINOP(PLUS,
                                                        FP,
                                                        CONST 8)),
                                                    CONST ~20))),
                                              SEQ(
                                                CJUMP(EQ,
                                                  TEMP t141,
                                                  CONST 0,
                                                  L66_subs_nilerror,L68_subs_nnil),
                                                SEQ(
                                                  LABEL L66_subs_nilerror,
                                                  SEQ(
                                                    EXP(
                                                      CALL(
                                                        NAME arrNilError,
                                                        NAME L1_string,
                                                        CONST 24,
                                                        CONST 55)),
                                                    SEQ(
                                                      LABEL L68_subs_nnil,
                                                      SEQ(
                                                        MOVE(
                                                          TEMP t140,
                                                          BINOP(MINUS,
                                                            BINOP(PLUS,
                                                              MEM(
                                                                BINOP(PLUS,
                                                                  FP,
                                                                  CONST ~4)),
                                                              CONST 7),
                                                            MEM(
                                                              BINOP(PLUS,
                                                                FP,
                                                                CONST 12)))),
                                                        SEQ(
                                                          MOVE(
                                                            TEMP t143,
                                                            MEM(
                                                              BINOP(MINUS,
                                                                TEMP t141,
                                                                CONST 4))),
                                                          SEQ(
                                                            CJUMP(GE,
                                                              TEMP t140,
                                                              CONST 0,
                                                              L64_subs_nneg,L65_subs_idxerror),
                                                            SEQ(
                                                              LABEL L64_subs_nneg,
                                                              SEQ(
                                                                CJUMP(LT,
                                                                  TEMP t140,
                                                                  TEMP t143,
                                                                  L67_subs_noerror,L65_subs_idxerror),
                                                                SEQ(
                                                                  LABEL L65_subs_idxerror,
                                                                  SEQ(
                                                                    EXP(
                                                                      CALL(
                                                                        NAME arrInxError,
                                                                        BINOP(MINUS,
                                                                          BINOP(PLUS,
                                                                            MEM(
                                                                              BINOP(PLUS,
                                                                                FP,
                                                                                CONST ~4)),
                                                                            CONST 7),
                                                                          MEM(
                                                                            BINOP(PLUS,
                                                                              FP,
                                                                              CONST 12))),
                                                                        NAME L1_string,
                                                                        CONST 24,
                                                                        CONST 55)),
                                                                    SEQ(
                                                                      LABEL L67_subs_noerror,
                                                                      MOVE(
                                                                        TEMP t142,
                                                                        BINOP(PLUS,
                                                                          TEMP t141,
                                                                          BINOP(MUL,
                                                                            TEMP t140,
                                                                            CONST 4)))))))))))))))),
                                            MEM(
                                              TEMP t142)),
                                          CONST 1),
                                        SEQ(
                                          MOVE(
                                            ESEQ(
                                              SEQ(
                                                MOVE(
                                                  TEMP t145,
                                                  MEM(
                                                    BINOP(PLUS,
                                                      MEM(
                                                        BINOP(PLUS,
                                                          FP,
                                                          CONST 8)),
                                                      CONST ~12))),
                                                SEQ(
                                                  CJUMP(EQ,
                                                    TEMP t145,
                                                    CONST 0,
                                                    L71_subs_nilerror,L73_subs_nnil),
                                                  SEQ(
                                                    LABEL L71_subs_nilerror,
                                                    SEQ(
                                                      EXP(
                                                        CALL(
                                                          NAME arrNilError,
                                                          NAME L1_string,
                                                          CONST 25,
                                                          CONST 27)),
                                                      SEQ(
                                                        LABEL L73_subs_nnil,
                                                        SEQ(
                                                          MOVE(
                                                            TEMP t144,
                                                            MEM(
                                                              BINOP(PLUS,
                                                                FP,
                                                                CONST 12))),
                                                          SEQ(
                                                            MOVE(
                                                              TEMP t147,
                                                              MEM(
                                                                BINOP(MINUS,
                                                                  TEMP t145,
                                                                  CONST 4))),
                                                            SEQ(
                                                              CJUMP(GE,
                                                                TEMP t144,
                                                                CONST 0,
                                                                L69_subs_nneg,L70_subs_idxerror),
                                                              SEQ(
                                                                LABEL L69_subs_nneg,
                                                                SEQ(
                                                                  CJUMP(LT,
                                                                    TEMP t144,
                                                                    TEMP t147,
                                                                    L72_subs_noerror,L70_subs_idxerror),
                                                                  SEQ(
                                                                    LABEL L70_subs_idxerror,
                                                                    SEQ(
                                                                      EXP(
                                                                        CALL(
                                                                          NAME arrInxError,
                                                                          MEM(
                                                                            BINOP(PLUS,
                                                                              FP,
                                                                              CONST 12)),
                                                                          NAME L1_string,
                                                                          CONST 25,
                                                                          CONST 27)),
                                                                      SEQ(
                                                                        LABEL L72_subs_noerror,
                                                                        MOVE(
                                                                          TEMP t146,
                                                                          BINOP(PLUS,
                                                                            TEMP t145,
                                                                            BINOP(MUL,
                                                                              TEMP t144,
                                                                              CONST 4)))))))))))))))),
                                              MEM(
                                                TEMP t146)),
                                            MEM(
                                              BINOP(PLUS,
                                                FP,
                                                CONST ~4))),
                                          SEQ(
                                            EXP(
                                              CALL(
                                                NAME L3_fun_try,
                                                MEM(
                                                  BINOP(PLUS,
                                                    FP,
                                                    CONST 8)),
                                                BINOP(PLUS,
                                                  MEM(
                                                    BINOP(PLUS,
                                                      FP,
                                                      CONST 12)),
                                                  CONST 1))),
                                            SEQ(
                                              MOVE(
                                                ESEQ(
                                                  SEQ(
                                                    MOVE(
                                                      TEMP t149,
                                                      MEM(
                                                        BINOP(PLUS,
                                                          MEM(
                                                            BINOP(PLUS,
                                                              FP,
                                                              CONST 8)),
                                                          CONST ~8))),
                                                    SEQ(
                                                      CJUMP(EQ,
                                                        TEMP t149,
                                                        CONST 0,
                                                        L76_subs_nilerror,L78_subs_nnil),
                                                      SEQ(
                                                        LABEL L76_subs_nilerror,
                                                        SEQ(
                                                          EXP(
                                                            CALL(
                                                              NAME arrNilError,
                                                              NAME L1_string,
                                                              CONST 27,
                                                              CONST 27)),
                                                          SEQ(
                                                            LABEL L78_subs_nnil,
                                                            SEQ(
                                                              MOVE(
                                                                TEMP t148,
                                                                MEM(
                                                                  BINOP(PLUS,
                                                                    FP,
                                                                    CONST ~4))),
                                                              SEQ(
                                                                MOVE(
                                                                  TEMP t151,
                                                                  MEM(
                                                                    BINOP(MINUS,
                                                                      TEMP t149,
                                                                      CONST 4))),
                                                                SEQ(
                                                                  CJUMP(GE,
                                                                    TEMP t148,
                                                                    CONST 0,
                                                                    L74_subs_nneg,L75_subs_idxerror),
                                                                  SEQ(
                                                                    LABEL L74_subs_nneg,
                                                                    SEQ(
                                                                      CJUMP(LT,
                                                                        TEMP t148,
                                                                        TEMP t151,
                                                                        L77_subs_noerror,L75_subs_idxerror),
                                                                      SEQ(
                                                                        LABEL L75_subs_idxerror,
                                                                        SEQ(
                                                                          EXP(
                                                                            CALL(
                                                                              NAME arrInxError,
                                                                              MEM(
                                                                                BINOP(PLUS,
                                                                                  FP,
                                                                                  CONST ~4)),
                                                                              NAME L1_string,
                                                                              CONST 27,
                                                                              CONST 27)),
                                                                          SEQ(
                                                                            LABEL L77_subs_noerror,
                                                                            MOVE(
                                                                              TEMP t150,
                                                                              BINOP(PLUS,
                                                                                TEMP t149,
                                                                                BINOP(MUL,
                                                                                  TEMP t148,
                                                                                  CONST 4)))))))))))))))),
                                                  MEM(
                                                    TEMP t150)),
                                                CONST 0),
                                              SEQ(
                                                MOVE(
                                                  ESEQ(
                                                    SEQ(
                                                      MOVE(
                                                        TEMP t153,
                                                        MEM(
                                                          BINOP(PLUS,
                                                            MEM(
                                                              BINOP(PLUS,
                                                                FP,
                                                                CONST 8)),
                                                            CONST ~16))),
                                                      SEQ(
                                                        CJUMP(EQ,
                                                          TEMP t153,
                                                          CONST 0,
                                                          L81_subs_nilerror,L83_subs_nnil),
                                                        SEQ(
                                                          LABEL L81_subs_nilerror,
                                                          SEQ(
                                                            EXP(
                                                              CALL(
                                                                NAME arrNilError,
                                                                NAME L1_string,
                                                                CONST 27,
                                                                CONST 40)),
                                                            SEQ(
                                                              LABEL L83_subs_nnil,
                                                              SEQ(
                                                                MOVE(
                                                                  TEMP t152,
                                                                  BINOP(PLUS,
                                                                    MEM(
                                                                      BINOP(PLUS,
                                                                        FP,
                                                                        CONST ~4)),
                                                                    MEM(
                                                                      BINOP(PLUS,
                                                                        FP,
                                                                        CONST 12)))),
                                                                SEQ(
                                                                  MOVE(
                                                                    TEMP t155,
                                                                    MEM(
                                                                      BINOP(MINUS,
                                                                        TEMP t153,
                                                                        CONST 4))),
                                                                  SEQ(
                                                                    CJUMP(GE,
                                                                      TEMP t152,
                                                                      CONST 0,
                                                                      L79_subs_nneg,L80_subs_idxerror),
                                                                    SEQ(
                                                                      LABEL L79_subs_nneg,
                                                                      SEQ(
                                                                        CJUMP(LT,
                                                                          TEMP t152,
                                                                          TEMP t155,
                                                                          L82_subs_noerror,L80_subs_idxerror),
                                                                        SEQ(
                                                                          LABEL L80_subs_idxerror,
                                                                          SEQ(
                                                                            EXP(
                                                                              CALL(
                                                                                NAME arrInxError,
                                                                                BINOP(PLUS,
                                                                                  MEM(
                                                                                    BINOP(PLUS,
                                                                                      FP,
                                                                                      CONST ~4)),
                                                                                  MEM(
                                                                                    BINOP(PLUS,
                                                                                      FP,
                                                                                      CONST 12))),
                                                                                NAME L1_string,
                                                                                CONST 27,
                                                                                CONST 40)),
                                                                            SEQ(
                                                                              LABEL L82_subs_noerror,
                                                                              MOVE(
                                                                                TEMP t154,
                                                                                BINOP(PLUS,
                                                                                  TEMP t153,
                                                                                  BINOP(MUL,
                                                                                    TEMP t152,
                                                                                    CONST 4)))))))))))))))),
                                                    MEM(
                                                      TEMP t154)),
                                                  CONST 0),
                                                MOVE(
                                                  ESEQ(
                                                    SEQ(
                                                      MOVE(
                                                        TEMP t157,
                                                        MEM(
                                                          BINOP(PLUS,
                                                            MEM(
                                                              BINOP(PLUS,
                                                                FP,
                                                                CONST 8)),
                                                            CONST ~20))),
                                                      SEQ(
                                                        CJUMP(EQ,
                                                          TEMP t157,
                                                          CONST 0,
                                                          L86_subs_nilerror,L88_subs_nnil),
                                                        SEQ(
                                                          LABEL L86_subs_nilerror,
                                                          SEQ(
                                                            EXP(
                                                              CALL(
                                                                NAME arrNilError,
                                                                NAME L1_string,
                                                                CONST 27,
                                                                CONST 55)),
                                                            SEQ(
                                                              LABEL L88_subs_nnil,
                                                              SEQ(
                                                                MOVE(
                                                                  TEMP t156,
                                                                  BINOP(MINUS,
                                                                    BINOP(PLUS,
                                                                      MEM(
                                                                        BINOP(PLUS,
                                                                          FP,
                                                                          CONST ~4)),
                                                                      CONST 7),
                                                                    MEM(
                                                                      BINOP(PLUS,
                                                                        FP,
                                                                        CONST 12)))),
                                                                SEQ(
                                                                  MOVE(
                                                                    TEMP t159,
                                                                    MEM(
                                                                      BINOP(MINUS,
                                                                        TEMP t157,
                                                                        CONST 4))),
                                                                  SEQ(
                                                                    CJUMP(GE,
                                                                      TEMP t156,
                                                                      CONST 0,
                                                                      L84_subs_nneg,L85_subs_idxerror),
                                                                    SEQ(
                                                                      LABEL L84_subs_nneg,
                                                                      SEQ(
                                                                        CJUMP(LT,
                                                                          TEMP t156,
                                                                          TEMP t159,
                                                                          L87_subs_noerror,L85_subs_idxerror),
                                                                        SEQ(
                                                                          LABEL L85_subs_idxerror,
                                                                          SEQ(
                                                                            EXP(
                                                                              CALL(
                                                                                NAME arrInxError,
                                                                                BINOP(MINUS,
                                                                                  BINOP(PLUS,
                                                                                    MEM(
                                                                                      BINOP(PLUS,
                                                                                        FP,
                                                                                        CONST ~4)),
                                                                                    CONST 7),
                                                                                  MEM(
                                                                                    BINOP(PLUS,
                                                                                      FP,
                                                                                      CONST 12))),
                                                                                NAME L1_string,
                                                                                CONST 27,
                                                                                CONST 55)),
                                                                            SEQ(
                                                                              LABEL L87_subs_noerror,
                                                                              MOVE(
                                                                                TEMP t158,
                                                                                BINOP(PLUS,
                                                                                  TEMP t157,
                                                                                  BINOP(MUL,
                                                                                    TEMP t156,
                                                                                    CONST 4)))))))))))))))),
                                                    MEM(
                                                      TEMP t158)),
                                                  CONST 0)))))))),
                                  LABEL L90_if_end))),
                            SEQ(
                              CJUMP(LT,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST ~4)),
                                TEMP t160,
                                L92_for_next,L22_for),
                              SEQ(
                                LABEL L92_for_next,
                                SEQ(
                                  MOVE(
                                    MEM(
                                      BINOP(PLUS,
                                        FP,
                                        CONST ~4)),
                                    BINOP(PLUS,
                                      CONST 1,
                                      MEM(
                                        BINOP(PLUS,
                                          FP,
                                          CONST ~4)))),
                                  SEQ(
                                    JUMP(
                                      NAME L91_for_body),
                                    LABEL L22_for))))))))),
                  LABEL L95_if_join)))))),
      EXP(
        CONST 0))))

PROC {name = L2_fun_printboard, formals = t, locals = 2}
SEQ(
  EXP(
    CONST 0),
  SEQ(
    EXP(
      CONST 0),
    SEQ(
      SEQ(
        SEQ(
          MOVE(
            MEM(
              BINOP(PLUS,
                FP,
                CONST ~4)),
            CONST 0),
          SEQ(
            MOVE(
              TEMP t115,
              BINOP(MINUS,
                MEM(
                  BINOP(PLUS,
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST 8)),
                    CONST ~4)),
                CONST 1)),
            SEQ(
              CJUMP(LE,
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST ~4)),
                TEMP t115,
                L19_for_body,L4_for),
              SEQ(
                LABEL L19_for_body,
                SEQ(
                  SEQ(
                    SEQ(
                      MOVE(
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST ~8)),
                        CONST 0),
                      SEQ(
                        MOVE(
                          TEMP t114,
                          BINOP(MINUS,
                            MEM(
                              BINOP(PLUS,
                                MEM(
                                  BINOP(PLUS,
                                    FP,
                                    CONST 8)),
                                CONST ~4)),
                            CONST 1)),
                        SEQ(
                          CJUMP(LE,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST ~8)),
                            TEMP t114,
                            L16_for_body,L5_for),
                          SEQ(
                            LABEL L16_for_body,
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
                                  ESEQ(
                                    SEQ(
                                      CJUMP(EQ,
                                        ESEQ(
                                          SEQ(
                                            MOVE(
                                              TEMP t110,
                                              MEM(
                                                BINOP(PLUS,
                                                  MEM(
                                                    BINOP(PLUS,
                                                      FP,
                                                      CONST 8)),
                                                  CONST ~12))),
                                            SEQ(
                                              CJUMP(EQ,
                                                TEMP t110,
                                                CONST 0,
                                                L8_subs_nilerror,L10_subs_nnil),
                                              SEQ(
                                                LABEL L8_subs_nilerror,
                                                SEQ(
                                                  EXP(
                                                    CALL(
                                                      NAME arrNilError,
                                                      NAME L1_string,
                                                      CONST 15,
                                                      CONST 29)),
                                                  SEQ(
                                                    LABEL L10_subs_nnil,
                                                    SEQ(
                                                      MOVE(
                                                        TEMP t109,
                                                        MEM(
                                                          BINOP(PLUS,
                                                            FP,
                                                            CONST ~4))),
                                                      SEQ(
                                                        MOVE(
                                                          TEMP t112,
                                                          MEM(
                                                            BINOP(MINUS,
                                                              TEMP t110,
                                                              CONST 4))),
                                                        SEQ(
                                                          CJUMP(GE,
                                                            TEMP t109,
                                                            CONST 0,
                                                            L6_subs_nneg,L7_subs_idxerror),
                                                          SEQ(
                                                            LABEL L6_subs_nneg,
                                                            SEQ(
                                                              CJUMP(LT,
                                                                TEMP t109,
                                                                TEMP t112,
                                                                L9_subs_noerror,L7_subs_idxerror),
                                                              SEQ(
                                                                LABEL L7_subs_idxerror,
                                                                SEQ(
                                                                  EXP(
                                                                    CALL(
                                                                      NAME arrInxError,
                                                                      MEM(
                                                                        BINOP(PLUS,
                                                                          FP,
                                                                          CONST ~4)),
                                                                      NAME L1_string,
                                                                      CONST 15,
                                                                      CONST 29)),
                                                                  SEQ(
                                                                    LABEL L9_subs_noerror,
                                                                    MOVE(
                                                                      TEMP t111,
                                                                      BINOP(PLUS,
                                                                        TEMP t110,
                                                                        BINOP(MUL,
                                                                          TEMP t109,
                                                                          CONST 4)))))))))))))))),
                                          MEM(
                                            TEMP t111)),
                                        MEM(
                                          BINOP(PLUS,
                                            FP,
                                            CONST ~8)),
                                        L13_if_then,L14_if_else),
                                      SEQ(
                                        LABEL L13_if_then,
                                        SEQ(
                                          MOVE(
                                            TEMP t113,
                                            NAME L11_string),
                                          SEQ(
                                            JUMP(
                                              NAME L15_if_join),
                                            SEQ(
                                              LABEL L14_if_else,
                                              SEQ(
                                                MOVE(
                                                  TEMP t113,
                                                  NAME L12_string),
                                                LABEL L15_if_join)))))),
                                    TEMP t113))),
                              SEQ(
                                CJUMP(LT,
                                  MEM(
                                    BINOP(PLUS,
                                      FP,
                                      CONST ~8)),
                                  TEMP t114,
                                  L17_for_next,L5_for),
                                SEQ(
                                  LABEL L17_for_next,
                                  SEQ(
                                    MOVE(
                                      MEM(
                                        BINOP(PLUS,
                                          FP,
                                          CONST ~8)),
                                      BINOP(PLUS,
                                        CONST 1,
                                        MEM(
                                          BINOP(PLUS,
                                            FP,
                                            CONST ~8)))),
                                    SEQ(
                                      JUMP(
                                        NAME L16_for_body),
                                      LABEL L5_for))))))))),
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
                        NAME L18_string))),
                  SEQ(
                    CJUMP(LT,
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST ~4)),
                      TEMP t115,
                      L20_for_next,L4_for),
                    SEQ(
                      LABEL L20_for_next,
                      SEQ(
                        MOVE(
                          MEM(
                            BINOP(PLUS,
                              FP,
                              CONST ~4)),
                          BINOP(PLUS,
                            CONST 1,
                            MEM(
                              BINOP(PLUS,
                                FP,
                                CONST ~4)))),
                        SEQ(
                          JUMP(
                            NAME L19_for_body),
                          LABEL L4_for))))))))),
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
            NAME L21_string))),
      EXP(
        CONST 0))))

STRING L21_string = "\012"

STRING L18_string = "\012"

STRING L12_string = " ."

STRING L11_string = " O"

STRING L1_string = "../testcases/queens.tig"

STRING L0_string = "DefaultString"

