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
              CALL(
                NAME initArray,
                CONST 10,
                CONST 0,
                NAME L1_string,
                CONST 9,
                CONST 17)),
            SEQ(
              MOVE(
                MEM(
                  BINOP(PLUS,
                    FP,
                    CONST ~8)),
                CALL(
                  NAME initArray,
                  CONST 5,
                  ESEQ(
                    SEQ(
                      MOVE(
                        TEMP t109,
                        CALL(
                          NAME allocRecord,
                          CONST 4)),
                      SEQ(
                        MOVE(
                          MEM(
                            BINOP(PLUS,
                              TEMP t109,
                              CONST 0)),
                          NAME L2_string),
                        SEQ(
                          MOVE(
                            MEM(
                              BINOP(PLUS,
                                TEMP t109,
                                CONST 4)),
                            NAME L3_string),
                          SEQ(
                            MOVE(
                              MEM(
                                BINOP(PLUS,
                                  TEMP t109,
                                  CONST 8)),
                              CONST 0),
                            MOVE(
                              MEM(
                                BINOP(PLUS,
                                  TEMP t109,
                                  CONST 12)),
                              CONST 0))))),
                    TEMP t109),
                  NAME L1_string,
                  CONST 10,
                  CONST 17)),
              SEQ(
                MOVE(
                  MEM(
                    BINOP(PLUS,
                      FP,
                      CONST ~12)),
                  CALL(
                    NAME initArray,
                    CONST 100,
                    NAME L4_string,
                    NAME L1_string,
                    CONST 12,
                    CONST 27)),
                SEQ(
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST ~16)),
                    ESEQ(
                      SEQ(
                        MOVE(
                          TEMP t110,
                          CALL(
                            NAME allocRecord,
                            CONST 4)),
                        SEQ(
                          MOVE(
                            MEM(
                              BINOP(PLUS,
                                TEMP t110,
                                CONST 0)),
                            NAME L5_string),
                          SEQ(
                            MOVE(
                              MEM(
                                BINOP(PLUS,
                                  TEMP t110,
                                  CONST 4)),
                              NAME L6_string),
                            SEQ(
                              MOVE(
                                MEM(
                                  BINOP(PLUS,
                                    TEMP t110,
                                    CONST 8)),
                                CONST 2432),
                              MOVE(
                                MEM(
                                  BINOP(PLUS,
                                    TEMP t110,
                                    CONST 12)),
                                CONST 44))))),
                      TEMP t110)),
                  MOVE(
                    MEM(
                      BINOP(PLUS,
                        FP,
                        CONST ~20)),
                    ESEQ(
                      SEQ(
                        MOVE(
                          TEMP t111,
                          CALL(
                            NAME allocRecord,
                            CONST 2)),
                        SEQ(
                          MOVE(
                            MEM(
                              BINOP(PLUS,
                                TEMP t111,
                                CONST 0)),
                            NAME L7_string),
                          MOVE(
                            MEM(
                              BINOP(PLUS,
                                TEMP t111,
                                CONST 4)),
                            CALL(
                              NAME initArray,
                              CONST 3,
                              CONST 1900,
                              NAME L1_string,
                              CONST 15,
                              CONST 48)))),
                      TEMP t111)))))),
          ESEQ(
            SEQ(
              MOVE(
                ESEQ(
                  SEQ(
                    MOVE(
                      TEMP t113,
                      MEM(
                        BINOP(PLUS,
                          FP,
                          CONST ~4))),
                    SEQ(
                      CJUMP(EQ,
                        TEMP t113,
                        CONST 0,
                        L10_subs_nilerror,L12_subs_nnil),
                      SEQ(
                        LABEL L10_subs_nilerror,
                        SEQ(
                          EXP(
                            CALL(
                              NAME arrNilError,
                              NAME L1_string,
                              CONST 17,
                              CONST 9)),
                          SEQ(
                            LABEL L12_subs_nnil,
                            SEQ(
                              MOVE(
                                TEMP t112,
                                CONST 0),
                              SEQ(
                                MOVE(
                                  TEMP t115,
                                  MEM(
                                    BINOP(MINUS,
                                      TEMP t113,
                                      CONST 4))),
                                SEQ(
                                  CJUMP(GE,
                                    TEMP t112,
                                    CONST 0,
                                    L8_subs_nneg,L9_subs_idxerror),
                                  SEQ(
                                    LABEL L8_subs_nneg,
                                    SEQ(
                                      CJUMP(LT,
                                        TEMP t112,
                                        TEMP t115,
                                        L11_subs_noerror,L9_subs_idxerror),
                                      SEQ(
                                        LABEL L9_subs_idxerror,
                                        SEQ(
                                          EXP(
                                            CALL(
                                              NAME arrInxError,
                                              CONST 0,
                                              NAME L1_string,
                                              CONST 17,
                                              CONST 9)),
                                          SEQ(
                                            LABEL L11_subs_noerror,
                                            MOVE(
                                              TEMP t114,
                                              BINOP(PLUS,
                                                TEMP t113,
                                                BINOP(MUL,
                                                  TEMP t112,
                                                  CONST 4)))))))))))))))),
                  MEM(
                    TEMP t114)),
                CONST 1),
              SEQ(
                MOVE(
                  ESEQ(
                    SEQ(
                      MOVE(
                        TEMP t117,
                        MEM(
                          BINOP(PLUS,
                            FP,
                            CONST ~4))),
                      SEQ(
                        CJUMP(EQ,
                          TEMP t117,
                          CONST 0,
                          L15_subs_nilerror,L17_subs_nnil),
                        SEQ(
                          LABEL L15_subs_nilerror,
                          SEQ(
                            EXP(
                              CALL(
                                NAME arrNilError,
                                NAME L1_string,
                                CONST 18,
                                CONST 9)),
                            SEQ(
                              LABEL L17_subs_nnil,
                              SEQ(
                                MOVE(
                                  TEMP t116,
                                  CONST 9),
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
                                      L13_subs_nneg,L14_subs_idxerror),
                                    SEQ(
                                      LABEL L13_subs_nneg,
                                      SEQ(
                                        CJUMP(LT,
                                          TEMP t116,
                                          TEMP t119,
                                          L16_subs_noerror,L14_subs_idxerror),
                                        SEQ(
                                          LABEL L14_subs_idxerror,
                                          SEQ(
                                            EXP(
                                              CALL(
                                                NAME arrInxError,
                                                CONST 9,
                                                NAME L1_string,
                                                CONST 18,
                                                CONST 9)),
                                            SEQ(
                                              LABEL L16_subs_noerror,
                                              MOVE(
                                                TEMP t118,
                                                BINOP(PLUS,
                                                  TEMP t117,
                                                  BINOP(MUL,
                                                    TEMP t116,
                                                    CONST 4)))))))))))))))),
                    MEM(
                      TEMP t118)),
                  CONST 3),
                SEQ(
                  MOVE(
                    MEM(
                      ESEQ(
                        SEQ(
                          MOVE(
                            TEMP t124,
                            ESEQ(
                              SEQ(
                                MOVE(
                                  TEMP t121,
                                  MEM(
                                    BINOP(PLUS,
                                      FP,
                                      CONST ~8))),
                                SEQ(
                                  CJUMP(EQ,
                                    TEMP t121,
                                    CONST 0,
                                    L20_subs_nilerror,L22_subs_nnil),
                                  SEQ(
                                    LABEL L20_subs_nilerror,
                                    SEQ(
                                      EXP(
                                        CALL(
                                          NAME arrNilError,
                                          NAME L1_string,
                                          CONST 19,
                                          CONST 9)),
                                      SEQ(
                                        LABEL L22_subs_nnil,
                                        SEQ(
                                          MOVE(
                                            TEMP t120,
                                            CONST 3),
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
                                                L18_subs_nneg,L19_subs_idxerror),
                                              SEQ(
                                                LABEL L18_subs_nneg,
                                                SEQ(
                                                  CJUMP(LT,
                                                    TEMP t120,
                                                    TEMP t123,
                                                    L21_subs_noerror,L19_subs_idxerror),
                                                  SEQ(
                                                    LABEL L19_subs_idxerror,
                                                    SEQ(
                                                      EXP(
                                                        CALL(
                                                          NAME arrInxError,
                                                          CONST 3,
                                                          NAME L1_string,
                                                          CONST 19,
                                                          CONST 9)),
                                                      SEQ(
                                                        LABEL L21_subs_noerror,
                                                        MOVE(
                                                          TEMP t122,
                                                          BINOP(PLUS,
                                                            TEMP t121,
                                                            BINOP(MUL,
                                                              TEMP t120,
                                                              CONST 4)))))))))))))))),
                              MEM(
                                TEMP t122))),
                          SEQ(
                            CJUMP(EQ,
                              TEMP t124,
                              CONST 0,
                              L23_fieldvar_var_nil,L24_fieldvar_var_not_nil),
                            SEQ(
                              LABEL L23_fieldvar_var_nil,
                              SEQ(
                                EXP(
                                  CALL(
                                    NAME recFieldError,
                                    NAME L1_string,
                                    CONST 19,
                                    CONST 13)),
                                LABEL L24_fieldvar_var_not_nil)))),
                        BINOP(PLUS,
                          TEMP t124,
                          CONST 0))),
                    NAME L25_string),
                  SEQ(
                    MOVE(
                      MEM(
                        ESEQ(
                          SEQ(
                            MOVE(
                              TEMP t129,
                              ESEQ(
                                SEQ(
                                  MOVE(
                                    TEMP t126,
                                    MEM(
                                      BINOP(PLUS,
                                        FP,
                                        CONST ~8))),
                                  SEQ(
                                    CJUMP(EQ,
                                      TEMP t126,
                                      CONST 0,
                                      L28_subs_nilerror,L30_subs_nnil),
                                    SEQ(
                                      LABEL L28_subs_nilerror,
                                      SEQ(
                                        EXP(
                                          CALL(
                                            NAME arrNilError,
                                            NAME L1_string,
                                            CONST 20,
                                            CONST 9)),
                                        SEQ(
                                          LABEL L30_subs_nnil,
                                          SEQ(
                                            MOVE(
                                              TEMP t125,
                                              CONST 1),
                                            SEQ(
                                              MOVE(
                                                TEMP t128,
                                                MEM(
                                                  BINOP(MINUS,
                                                    TEMP t126,
                                                    CONST 4))),
                                              SEQ(
                                                CJUMP(GE,
                                                  TEMP t125,
                                                  CONST 0,
                                                  L26_subs_nneg,L27_subs_idxerror),
                                                SEQ(
                                                  LABEL L26_subs_nneg,
                                                  SEQ(
                                                    CJUMP(LT,
                                                      TEMP t125,
                                                      TEMP t128,
                                                      L29_subs_noerror,L27_subs_idxerror),
                                                    SEQ(
                                                      LABEL L27_subs_idxerror,
                                                      SEQ(
                                                        EXP(
                                                          CALL(
                                                            NAME arrInxError,
                                                            CONST 1,
                                                            NAME L1_string,
                                                            CONST 20,
                                                            CONST 9)),
                                                        SEQ(
                                                          LABEL L29_subs_noerror,
                                                          MOVE(
                                                            TEMP t127,
                                                            BINOP(PLUS,
                                                              TEMP t126,
                                                              BINOP(MUL,
                                                                TEMP t125,
                                                                CONST 4)))))))))))))))),
                                MEM(
                                  TEMP t127))),
                            SEQ(
                              CJUMP(EQ,
                                TEMP t129,
                                CONST 0,
                                L31_fieldvar_var_nil,L32_fieldvar_var_not_nil),
                              SEQ(
                                LABEL L31_fieldvar_var_nil,
                                SEQ(
                                  EXP(
                                    CALL(
                                      NAME recFieldError,
                                      NAME L1_string,
                                      CONST 20,
                                      CONST 13)),
                                  LABEL L32_fieldvar_var_not_nil)))),
                          BINOP(PLUS,
                            TEMP t129,
                            CONST 12))),
                      CONST 23),
                    SEQ(
                      MOVE(
                        ESEQ(
                          SEQ(
                            MOVE(
                              TEMP t131,
                              MEM(
                                BINOP(PLUS,
                                  FP,
                                  CONST ~12))),
                            SEQ(
                              CJUMP(EQ,
                                TEMP t131,
                                CONST 0,
                                L35_subs_nilerror,L37_subs_nnil),
                              SEQ(
                                LABEL L35_subs_nilerror,
                                SEQ(
                                  EXP(
                                    CALL(
                                      NAME arrNilError,
                                      NAME L1_string,
                                      CONST 21,
                                      CONST 9)),
                                  SEQ(
                                    LABEL L37_subs_nnil,
                                    SEQ(
                                      MOVE(
                                        TEMP t130,
                                        CONST 34),
                                      SEQ(
                                        MOVE(
                                          TEMP t133,
                                          MEM(
                                            BINOP(MINUS,
                                              TEMP t131,
                                              CONST 4))),
                                        SEQ(
                                          CJUMP(GE,
                                            TEMP t130,
                                            CONST 0,
                                            L33_subs_nneg,L34_subs_idxerror),
                                          SEQ(
                                            LABEL L33_subs_nneg,
                                            SEQ(
                                              CJUMP(LT,
                                                TEMP t130,
                                                TEMP t133,
                                                L36_subs_noerror,L34_subs_idxerror),
                                              SEQ(
                                                LABEL L34_subs_idxerror,
                                                SEQ(
                                                  EXP(
                                                    CALL(
                                                      NAME arrInxError,
                                                      CONST 34,
                                                      NAME L1_string,
                                                      CONST 21,
                                                      CONST 9)),
                                                  SEQ(
                                                    LABEL L36_subs_noerror,
                                                    MOVE(
                                                      TEMP t132,
                                                      BINOP(PLUS,
                                                        TEMP t131,
                                                        BINOP(MUL,
                                                          TEMP t130,
                                                          CONST 4)))))))))))))))),
                          MEM(
                            TEMP t132)),
                        NAME L38_string),
                      SEQ(
                        MOVE(
                          MEM(
                            ESEQ(
                              SEQ(
                                MOVE(
                                  TEMP t134,
                                  MEM(
                                    BINOP(PLUS,
                                      FP,
                                      CONST ~16))),
                                SEQ(
                                  CJUMP(EQ,
                                    TEMP t134,
                                    CONST 0,
                                    L39_fieldvar_var_nil,L40_fieldvar_var_not_nil),
                                  SEQ(
                                    LABEL L39_fieldvar_var_nil,
                                    SEQ(
                                      EXP(
                                        CALL(
                                          NAME recFieldError,
                                          NAME L1_string,
                                          CONST 23,
                                          CONST 10)),
                                      LABEL L40_fieldvar_var_not_nil)))),
                              BINOP(PLUS,
                                TEMP t134,
                                CONST 0))),
                          NAME L41_string),
                        SEQ(
                          MOVE(
                            ESEQ(
                              SEQ(
                                MOVE(
                                  TEMP t137,
                                  MEM(
                                    ESEQ(
                                      SEQ(
                                        MOVE(
                                          TEMP t135,
                                          MEM(
                                            BINOP(PLUS,
                                              FP,
                                              CONST ~20))),
                                        SEQ(
                                          CJUMP(EQ,
                                            TEMP t135,
                                            CONST 0,
                                            L42_fieldvar_var_nil,L43_fieldvar_var_not_nil),
                                          SEQ(
                                            LABEL L42_fieldvar_var_nil,
                                            SEQ(
                                              EXP(
                                                CALL(
                                                  NAME recFieldError,
                                                  NAME L1_string,
                                                  CONST 24,
                                                  CONST 10)),
                                              LABEL L43_fieldvar_var_not_nil)))),
                                      BINOP(PLUS,
                                        TEMP t135,
                                        CONST 4)))),
                                SEQ(
                                  CJUMP(EQ,
                                    TEMP t137,
                                    CONST 0,
                                    L46_subs_nilerror,L48_subs_nnil),
                                  SEQ(
                                    LABEL L46_subs_nilerror,
                                    SEQ(
                                      EXP(
                                        CALL(
                                          NAME arrNilError,
                                          NAME L1_string,
                                          CONST 24,
                                          CONST 15)),
                                      SEQ(
                                        LABEL L48_subs_nnil,
                                        SEQ(
                                          MOVE(
                                            TEMP t136,
                                            CONST 0),
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
                                                L44_subs_nneg,L45_subs_idxerror),
                                              SEQ(
                                                LABEL L44_subs_nneg,
                                                SEQ(
                                                  CJUMP(LT,
                                                    TEMP t136,
                                                    TEMP t139,
                                                    L47_subs_noerror,L45_subs_idxerror),
                                                  SEQ(
                                                    LABEL L45_subs_idxerror,
                                                    SEQ(
                                                      EXP(
                                                        CALL(
                                                          NAME arrInxError,
                                                          CONST 0,
                                                          NAME L1_string,
                                                          CONST 24,
                                                          CONST 15)),
                                                      SEQ(
                                                        LABEL L47_subs_noerror,
                                                        MOVE(
                                                          TEMP t138,
                                                          BINOP(PLUS,
                                                            TEMP t137,
                                                            BINOP(MUL,
                                                              TEMP t136,
                                                              CONST 4)))))))))))))))),
                              MEM(
                                TEMP t138)),
                            CONST 2323),
                          MOVE(
                            ESEQ(
                              SEQ(
                                MOVE(
                                  TEMP t142,
                                  MEM(
                                    ESEQ(
                                      SEQ(
                                        MOVE(
                                          TEMP t140,
                                          MEM(
                                            BINOP(PLUS,
                                              FP,
                                              CONST ~20))),
                                        SEQ(
                                          CJUMP(EQ,
                                            TEMP t140,
                                            CONST 0,
                                            L49_fieldvar_var_nil,L50_fieldvar_var_not_nil),
                                          SEQ(
                                            LABEL L49_fieldvar_var_nil,
                                            SEQ(
                                              EXP(
                                                CALL(
                                                  NAME recFieldError,
                                                  NAME L1_string,
                                                  CONST 25,
                                                  CONST 10)),
                                              LABEL L50_fieldvar_var_not_nil)))),
                                      BINOP(PLUS,
                                        TEMP t140,
                                        CONST 4)))),
                                SEQ(
                                  CJUMP(EQ,
                                    TEMP t142,
                                    CONST 0,
                                    L53_subs_nilerror,L55_subs_nnil),
                                  SEQ(
                                    LABEL L53_subs_nilerror,
                                    SEQ(
                                      EXP(
                                        CALL(
                                          NAME arrNilError,
                                          NAME L1_string,
                                          CONST 25,
                                          CONST 15)),
                                      SEQ(
                                        LABEL L55_subs_nnil,
                                        SEQ(
                                          MOVE(
                                            TEMP t141,
                                            CONST 2),
                                          SEQ(
                                            MOVE(
                                              TEMP t144,
                                              MEM(
                                                BINOP(MINUS,
                                                  TEMP t142,
                                                  CONST 4))),
                                            SEQ(
                                              CJUMP(GE,
                                                TEMP t141,
                                                CONST 0,
                                                L51_subs_nneg,L52_subs_idxerror),
                                              SEQ(
                                                LABEL L51_subs_nneg,
                                                SEQ(
                                                  CJUMP(LT,
                                                    TEMP t141,
                                                    TEMP t144,
                                                    L54_subs_noerror,L52_subs_idxerror),
                                                  SEQ(
                                                    LABEL L52_subs_idxerror,
                                                    SEQ(
                                                      EXP(
                                                        CALL(
                                                          NAME arrInxError,
                                                          CONST 2,
                                                          NAME L1_string,
                                                          CONST 25,
                                                          CONST 15)),
                                                      SEQ(
                                                        LABEL L54_subs_noerror,
                                                        MOVE(
                                                          TEMP t143,
                                                          BINOP(PLUS,
                                                            TEMP t142,
                                                            BINOP(MUL,
                                                              TEMP t141,
                                                              CONST 4)))))))))))))))),
                              MEM(
                                TEMP t143)),
                            CONST 2323)))))))),
            CONST 0))),
      EXP(
        CONST 0))))

STRING L41_string = "sdf"

STRING L38_string = "sfd"

STRING L25_string = "kati"

STRING L7_string = "Allos"

STRING L6_string = "Kapou"

STRING L5_string = "Kapoios"

STRING L4_string = ""

STRING L3_string = "somewhere"

STRING L2_string = "aname"

STRING L1_string = "../testcases/test42.tig"

STRING L0_string = "DefaultString"

