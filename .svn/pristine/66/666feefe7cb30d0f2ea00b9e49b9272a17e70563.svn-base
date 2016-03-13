signature PARSETREE =
sig
    val fromStringFrags: string -> X86Frame.frag list
end

structure ParseTree : PARSETREE =
struct

structure S = Symbol
structure T = Tree
structure F = X86Frame

type stm = Tree.stm
type exp = Tree.exp
type binop = Tree.binop
type relop = Tree.relop
type frag = X86Frame.frag

fun doNewline pos =
    ( ErrorMsg.lineNum := !ErrorMsg.lineNum+1
    ; ErrorMsg.linePos := pos :: !ErrorMsg.linePos)

fun err pos msg =
    ErrorMsg.error pos ("IR Parse Error! - " ^ msg)

fun irStringDecode s pos =
    let
        fun isoctal c = ((#"0")<=c andalso c<=(#"7"))
        fun isd [] = []
          | isd ((#"\\")::(#"\\")::rest) = (#"\\") :: (isd rest)
          | isd ((#"\\")::(#"\"")::rest) = (#"\"") :: (isd rest)
          | isd ((#"\\")::c1::c2::c3::rest) =
            if isoctal c1 andalso isoctal c2 andalso isoctal c3 then
                let
                    val ord0 = 48
                    fun odig c = ord(c) - ord0
                in
                    chr (64*(odig c1) + 8*(odig c2) + odig c3) :: (isd rest)
                end
            else ( err pos "bad octal encoded character"
                 ; (#"\\") :: c1 :: c2 :: c3 :: (isd rest))
          | isd (c::rest) = c :: (isd rest)
    in
        (implode o isd o explode) s
    end

val NoSym = S.symbol "NoSymbol"
val NoExp = T.NAME (S.symbol "NoExpression")
val NoStm = T.LABEL (S.symbol "NoStatement")

fun addPayload f (payload,x,y) =
    let
        val (x',y') = f (x,y)
    in
        (payload, x', y')
    end

fun skipComment ((#"*")::(#"/")::rest, pos) = (rest, pos+2)
  | skipComment (_::rest, pos) = skipComment (rest, pos+1)
  | skipComment ([], pos) = (err pos "comment never closed"; ([],pos))

fun skipWS ([], pos) = ([], pos)
  | skipWS ((#" ")::rest, pos) = skipWS (rest, pos+1)
  | skipWS ((#"\n")::rest, pos) = (doNewline pos; skipWS (rest, pos+1))
  | skipWS ((#"\r")::rest, pos) = skipWS (rest, pos+1)
  | skipWS ((#"\t")::rest, pos) = skipWS (rest, pos+1)
  | skipWS ((#"\f")::rest, pos) = skipWS (rest, pos+1)
  | skipWS ((#"/")::(#"*")::rest, pos) =
    let
        val (rest1,pos1) = skipComment (rest, pos+2)
    in
        skipWS (rest1, pos1)
    end
  | skipWS rp = rp

(* NB: 'val skipWS3 = addPayload skipWS' does not work: value restriction *)
fun skipWS3 rp = addPayload skipWS rp

fun acceptToken1 tok =
    let
        fun skipToken1 (pgm as ch::rest, pos) =
            if tok=ch then (rest, pos+1)
            else ( err pos ("expected \"" ^ (implode [tok]) ^
                            "\" got \"" ^ (implode [ch]) ^ "\"")
                 ; (rest,pos+1))
          | skipToken1 ([], pos) =
            ( err pos ("at end, expecting \"" ^ (implode [tok]) ^ "\"")
            ; ([],pos))
    in
        skipWS o skipToken1 o skipWS
    end

val acceptCOMMA = acceptToken1 #","
val acceptLBRACE = acceptToken1 #"{"
val acceptEQUALS = acceptToken1 #"="

fun acceptRPAREN3 rp = addPayload (acceptToken1 #")") rp
fun acceptRBRACE3 rp = addPayload (acceptToken1 #"}") rp
fun acceptEQUALS3 rp = addPayload acceptEQUALS rp

local
    fun err' pos kw expected = err pos ("'" ^ kw ^ "' expected, " ^ expected)
    fun fail kw (ch::rest,pos) =
        ( err' pos kw ("seeing '" ^ (implode [ch]) ^ "'")
        ; (rest, pos+1))
      | fail kw ([],pos) =
        ( err' pos kw "no more input"
        ; ([], pos))
in
    fun acceptKW_name ((#"n")::(#"a")::(#"m")::(#"e")::rest, pos) =
        (rest,pos+4)
      | acceptKW_name rp = fail "name" rp

    fun acceptKW_formals ((#"f")::(#"o")::(#"r")::(#"m")
                          ::(#"a")::(#"l")::(#"s")
                          ::rest, pos) = (rest,pos+7)
      | acceptKW_formals rp = fail "formals" rp

    fun acceptKW_locals ((#"l")::(#"o")::(#"c")::(#"a")::(#"l")::(#"s")
                         ::rest, pos) =
        (rest,pos+6)
      | acceptKW_locals rp = fail "locals" rp
end

fun acceptID (pgm, pos) =
    let
        val finish = implode o rev
        fun getID (acc, ch::rest, pos) =
            if (Char.isAlphaNum ch) orelse (ch = #"_")
            then getID (ch::acc, rest, pos+1)
            else (finish acc, ch::rest, pos)
          | getID (acc, [], pos) = (finish acc, [], pos)
    in
        (skipWS3 o getID o skipWS3) ([], pgm, pos)
    end

fun acceptInt (pgm, pos) =
    let
        fun fixInt nString =
            let
                val nopt = Int.fromString nString
            in
                case nopt
                 of SOME n => n
                  | NONE => (err pos ("bad int: \"" ^ nString ^ "\""); 0)
            end
        val finish = fixInt o implode o rev
        fun getInt (acc, ch::rest, pos) =
            if (Char.isDigit ch) orelse (ch = #"~")
            then getInt (ch::acc, rest, pos+1)
            else (finish acc, ch::rest, pos)
          | getInt (acc, [], pos) = (finish acc, [], pos)
    in
        (skipWS3 o getInt o skipWS3) ([], pgm, pos)
    end

fun acceptString (pgm, pos) =
    let
        fun acceptDQ ((#"\"")::rest,pos) =
            (rest, pos+1)
          | acceptDQ (ch::rest,pos) =
            ( err pos ("Double quote expected, seeing '" ^
                       (implode [ch]) ^ "'")
            ; (rest, pos+1))
          | acceptDQ ([],pos) =
            ( err pos "Double quote expected, no more input"
            ; ([], pos+1))
        fun acceptChars acc ((#"\\")::(#"\"")::rest,pos) =
            acceptChars ((#"\"")::(#"\\")::acc) (rest, pos+2)
          | acceptChars acc ((#"\\")::(#"\\")::rest,pos) =
            acceptChars ((#"\\")::(#"\\")::acc) (rest, pos+2)
          | acceptChars acc ((#"\"")::rest,pos) =
            (acc, rest, pos+1)
          | acceptChars acc (ch::rest,pos) =
            acceptChars (ch::acc) (rest, pos+1)
          | acceptChars acc ([],pos) =
            ( err pos "unfinished string"
            ; (acc,[],pos))
        val (chars,rest2,pos2) =
            ((acceptChars []) o acceptDQ o skipWS) (pgm, pos)
    in
        ((implode o rev) chars, rest2, pos2)
    end

fun fsStm rp =
    let
        fun fss ((#"S")::(#"E")::(#"Q")::(#"(")::rest, pos) =
            let
                val (stm1,rest1,pos1) = (fss o skipWS) (rest, pos+4)
                val (stm2,rest2,pos2) = (fss o acceptCOMMA) (rest1, pos1)
            in
                acceptRPAREN3 (T.SEQ (stm1, stm2), rest2, pos2)
            end

          | fss ((#"L")::(#"A")::(#"B")::(#"E")::(#"L")::rest, pos) =
            let
                val (id,rest1,pos1) = acceptID (rest, pos+5)
            in
                (T.LABEL (S.symbol id), rest1, pos1)
            end

          | fss ((#"J")::(#"U")::(#"M")::(#"P")::(#"(")::rest, pos) =
            let
                val (exp,rest1,pos1) = fsExp (rest, pos+5)
                fun getName (T.NAME sym) = sym
                  | getName _ =
                    ( err pos "JUMP(exp) only supported when exp is a NAME"
                    ; NoSym)
                val sym = getName exp
            in
                acceptRPAREN3 (T.JUMP (T.NAME sym, [sym]), rest1, pos1)
            end

          | fss ((#"C")::(#"J")::(#"U")::(#"M")::(#"P")::(#"(")::rest, pos) =
            let
                val (relop,rest1,pos1) = fsRelop (rest, pos+6)
                val (exp1,rest2,pos2) = (fsExp o acceptCOMMA) (rest1, pos1)
                val (exp2,rest3,pos3) = (fsExp o acceptCOMMA) (rest2, pos2)
                val (tID,rest4,pos4) = (acceptID o acceptCOMMA) (rest3, pos3)
                val (fID,rest5,pos5) = (acceptID o acceptCOMMA) (rest4, pos4)
            in
                acceptRPAREN3
                    ( T.CJUMP (relop, exp1, exp2, S.symbol tID, S.symbol fID)
                    , rest5
                    , pos5)
            end

          | fss ((#"M")::(#"O")::(#"V")::(#"E")::(#"(")::rest, pos) =
            let
                val (exp1,rest1,pos1) = fsExp (rest, pos+5)
                val (exp2,rest2,pos2) = (fsExp o acceptCOMMA) (rest1, pos1)
            in
                acceptRPAREN3 (T.MOVE (exp1, exp2), rest2, pos2)
            end

          | fss ((#"E")::(#"X")::(#"P")::(#"(")::rest, pos) =
            let
                val (exp,rest1,pos1) = fsExp (rest, pos)
            in
                acceptRPAREN3 (T.EXP exp, rest1, pos1)
            end

          | fss (ch::rest, pos) =
            ( err pos ("bad stm: '" ^ (implode (ch::rest)) ^ "'\n")
            ; skipWS3 (NoStm, rest, pos+1))

          | fss ([], pos) =
            ( err pos ("unfinished stm\n")
            ; skipWS3 (NoStm, [], pos))
    in
        (skipWS3 o fss o skipWS) rp
    end

and fsExp rp =
    let
        fun fse ((#"B")::(#"I")::(#"N")::(#"O")::(#"P")::(#"(")::rest, pos) =
            let
                val (binop,rest1,pos1) = fsBinop (rest, pos)
                val (exp1,rest2,pos2) = (fse o acceptCOMMA) (rest1, pos1)
                val (exp2,rest3,pos3) = (fse o acceptCOMMA) (rest2, pos2)
            in
                acceptRPAREN3 (T.BINOP (binop, exp1, exp2), rest3, pos3)
            end

          | fse ((#"M")::(#"E")::(#"M")::(#"(")::rest, pos) =
            let
                val (exp,rest1,pos1) = fsExp (rest, pos)
            in
                acceptRPAREN3 (T.MEM exp, rest1, pos1)
            end

          | fse ((#"T")::(#"E")::(#"M")::(#"P")::rest, pos) =
            let
                val (id,rest1,pos1) = acceptID (rest, pos)
                val nstr = String.substring (id, 1, size id - 1)
                val nvalopt = Int.fromString nstr
                val nval = case nvalopt
                            of NONE => (err 0 "Ill-formed TEMP"; 100)
                             | SOME n => n
            in
                skipWS3 (T.TEMP (Temp.forcetemp nval), rest1, pos1)
            end

          | fse ((#"F")::(#"P")::rest, pos) =
            skipWS3 (T.TEMP (Temp.forcetemp 100), rest, pos+2)

          | fse ((#"R")::(#"V")::rest, pos) =
            skipWS3 (T.TEMP (Temp.forcetemp 102), rest, pos+2)

          | fse ((#"E")::(#"S")::(#"E")::(#"Q")::(#"(")::rest, pos) =
            let
                val (stm,rest1,pos1) = fsStm (rest, pos)
                val (exp,rest2,pos2) = (fse o acceptCOMMA) (rest1, pos1)
            in
                acceptRPAREN3 (T.ESEQ (stm, exp), rest2, pos2)
            end

          | fse ((#"N")::(#"A")::(#"M")::(#"E")::rest, pos) =
            let
                val (id,rest1,pos1) = acceptID (rest, pos)
            in
                (T.NAME (S.symbol id), rest1, pos1)
            end

          | fse ((#"C")::(#"O")::(#"N")::(#"S")::(#"T")::rest, pos) =
            let
                val (n,rest1,pos1) = acceptInt (rest, pos+5)
            in
                (T.CONST n, rest1, pos1)
            end

          | fse ((#"C")::(#"A")::(#"L")::(#"L")::(#"(")::rest, pos) =
            let
                val (exp,rest1,pos1) = fsExp (rest, pos+5)
                fun acceptExps (acc, rest, pos) =
                    let
                        val (rest1,pos1) = skipWS (rest, pos)
                    in
                        case rest1
                         of ((#",")::rest2) =>
                            let
                                val (exp,rest3,pos3) = fsExp (rest2, pos1+1)
                            in
                                acceptExps (exp::acc, rest3, pos3)
                            end
                          | ((#")")::rest2) => (rev acc, rest2, pos1+1)
                          | ch::rest2 =>
                            ( err pos1 "bad CALL"
                            ; (rev acc, rest2, pos1+1))
                          | [] =>
                            ( err pos1 "unfinished CALL"
                            ; (rev acc, [], pos1))
                    end
                val (exps,rest2,pos2) = acceptExps ([], rest1, pos1)
            in
                skipWS3 (T.CALL (exp, exps), rest2, pos2)
            end

          | fse (ch::rest, pos) =
            ( err pos "bad exp"
            ; skipWS3 (NoExp, rest, pos+1))

          | fse ([], pos) =
            ( err pos "unfinished exp"
            ; skipWS3 (NoExp, [], pos))

    in
        (skipWS3 o fse o skipWS) rp
    end

and fsBinop rp =
    let
        fun fsb ((#"P")::(#"L")::(#"U")::(#"S")::rest, pos) =
            (T.PLUS, rest, pos+4)
          | fsb ((#"M")::(#"I")::(#"N")::(#"U")::(#"S")::rest, pos) =
            (T.MINUS, rest, pos+5)
          | fsb ((#"M")::(#"U")::(#"L")::rest, pos) =
            (T.MUL, rest, pos+3)
          | fsb ((#"D")::(#"I")::(#"V")::rest, pos) =
            (T.DIV, rest, pos+3)
          | fsb ((#"A")::(#"N")::(#"D")::rest, pos) =
            (T.AND, rest, pos+3)
          | fsb ((#"O")::(#"R")::rest, pos) =
            (T.OR, rest, pos+2)
          | fsb ((#"L")::(#"S")::(#"H")::(#"I")::(#"F")::(#"T")::rest, pos) =
            (T.LSHIFT, rest, pos+6)
          | fsb ((#"R")::(#"S")::(#"H")::(#"I")::(#"F")::(#"T")::rest, pos) =
            (T.RSHIFT, rest, pos+6)
          | fsb ((#"A")::(#"R")::(#"S")::(#"H")::
                 (#"I")::(#"F")::(#"T")::rest, pos) =
            (T.ARSHIFT, rest, pos+7)
          | fsb ((#"X")::(#"O")::(#"R")::rest, pos) =
            (T.XOR, rest, pos+3)
          | fsb (ch::rest, pos) =
            ( err pos ("binop expected, seeing '" ^ (implode [ch]) ^ "'")
            ; (T.PLUS, rest, pos+1))
          | fsb ([], pos) =
            ( err pos "binop expected, no more input"
            ; (T.PLUS, [], pos))
    in
        (skipWS3 o fsb o skipWS) rp
    end

and fsRelop rp =
    let
        fun fsr ((#"E")::(#"Q")::rest, pos) =  (T.EQ, rest, pos+2)
          | fsr ((#"N")::(#"E")::rest, pos) =  (T.NE, rest, pos+2)
          | fsr ((#"L")::(#"T")::rest, pos) =  (T.LT, rest, pos+2)
          | fsr ((#"G")::(#"T")::rest, pos) =  (T.GT, rest, pos+2)
          | fsr ((#"L")::(#"E")::rest, pos) =  (T.LE, rest, pos+2)
          | fsr ((#"G")::(#"E")::rest, pos) =  (T.GE, rest, pos+2)
          | fsr ((#"U")::(#"L")::(#"T")::rest, pos) =  (T.ULT, rest, pos+3)
          | fsr ((#"U")::(#"L")::(#"E")::rest, pos) =  (T.ULE, rest, pos+3)
          | fsr ((#"U")::(#"G")::(#"T")::rest, pos) =  (T.UGT, rest, pos+3)
          | fsr ((#"U")::(#"G")::(#"E")::rest, pos) =  (T.UGE, rest, pos+3)
          | fsr (ch::rest, pos) =
            ( err pos ("relop expected, seeing '" ^ (implode [ch]) ^ "'")
            ; (T.EQ, rest, pos+1))
          | fsr ([], pos) =
            ( err pos "relop expected, at end"
            ; (T.EQ, [], pos))
    in
        (skipWS3 o fsr o skipWS) rp
    end

fun fromStringStm s =
    let
        val (stm,rest,_) = (fsStm o skipWS) (explode s, 0)
    in
        (stm, implode rest)
    end

fun fromStringExp s =
    let
        val (exp,rest,_) = (fsExp o skipWS) (explode s, 0)
    in
        (exp, implode rest)
    end

fun fsFrag (rest,pos) =
    let
        fun fsBools [] = []
          | fsBools ((#"f")::rest) = false :: fsBools rest
          | fsBools (_::rest) = true :: fsBools rest

        fun fsFrag ((#"P")::(#"R")::(#"O")::(#"C")::rest,pos) =
            let
                val (name,rest1,pos1) =
                    (acceptID o
                     acceptEQUALS o
                     acceptKW_name o
                     acceptLBRACE) (rest, pos+4)
                val (formals,rest2,pos2) =
                    (acceptID o
                     acceptEQUALS o
                     acceptKW_formals o
                     acceptCOMMA) (rest1, pos1)
                val (locals,rest3,pos3) =
                    (acceptRBRACE3 o
                     acceptInt o
                     acceptEQUALS o
                     acceptKW_locals o
                     acceptCOMMA) (rest2, pos2)
                val (stm,rest4,pos4) =
                    fsStm (rest3, pos3)
                val frame = F.forceFrame { name = S.symbol name
                                         , formals = fsBools (explode formals)
                                         , locals = locals}
            in
                ( F.PROC {body = stm, frame = frame}
                , rest4
                , pos4)
            end
          | fsFrag ((#"S")::(#"T")::(#"R")::(#"I")::(#"N")::(#"G")::rest,pos) =
            let
                val (label,rest1,pos1) =
                    (acceptEQUALS3 o acceptID) (rest,pos+6)
                val (str,rest2,pos2) =
                    acceptString (rest1, pos1)
            in
                ( F.STRING (S.symbol label, irStringDecode str pos)
                , rest2
                , pos2)
            end
          | fsFrag (ch::rest,pos) =
            ( err pos ("PROC or STRING expected, seeing '" ^
                       (implode [ch]) ^ "'")
            ; (F.STRING (S.symbol "ERROR", "ERROR"), rest, pos+1))
          | fsFrag ([],pos) =
            ( err pos "PROC or STRING expected, no more input"
            ; (F.STRING (S.symbol "ERROR", "ERROR"), [], pos))
    in
        (fsFrag o skipWS) (rest, pos)
    end

fun fromStringFrags s =
    let
        val (rest,pos) = skipWS (explode s, 0)
        fun getFrags (acc,[],pos) =
            rev acc
          | getFrags (acc,rest,pos) =
            let
                val (frag,rest1,pos1) = (skipWS3 o fsFrag) (rest, pos)
            in
                getFrags (frag::acc, rest1, pos1)
            end
    in
        getFrags ([], rest, pos)
    end

end (* ParseTree *)
