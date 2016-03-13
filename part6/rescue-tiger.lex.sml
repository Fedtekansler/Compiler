functor TigerLexFun (structure Tokens: Tiger_TOKENS)  = struct

    val identification = ">>> This is rescue-tiger.lex.sml <<<"

    structure yyInput : sig

        type stream
	val mkStream : (int -> string) -> stream
	val fromStream : TextIO.StreamIO.instream -> stream
	val getc : stream -> (Char.char * stream) option
	val getpos : stream -> int
	val getlineNo : stream -> int
	val subtract : stream * stream -> string
	val eof : stream -> bool
	val lastWasNL : stream -> bool

      end = struct

        structure TIO = TextIO
        structure TSIO = TIO.StreamIO
	structure TPIO = TextPrimIO

        datatype stream = Stream of {
            strm : TSIO.instream,
	    id : int,  (* track which streams originated 
			* from the same stream *)
	    pos : int,
	    lineNo : int,
	    lastWasNL : bool
          }

	local
	  val next = ref 0
	in
	fun nextId() = !next before (next := !next + 1)
	end

	val initPos = 2 (* ml-lex bug compatibility *)

	fun mkStream inputN = let
              val strm = TSIO.mkInstream 
			   (TPIO.RD {
			        name = "lexgen",
				chunkSize = 4096,
				readVec = SOME inputN,
				readArr = NONE,
				readVecNB = NONE,
				readArrNB = NONE,
				block = NONE,
				canInput = NONE,
				avail = (fn () => NONE),
				getPos = NONE,
				setPos = NONE,
				endPos = NONE,
				verifyPos = NONE,
				close = (fn () => ()),
				ioDesc = NONE
			      }, "")
	      in 
		Stream {strm = strm, id = nextId(), pos = initPos, lineNo = 1,
			lastWasNL = true}
	      end

	fun fromStream strm = Stream {
		strm = strm, id = nextId(), pos = initPos, lineNo = 1, lastWasNL = true
	      }

	fun getc (Stream {strm, pos, id, lineNo, ...}) = (case TSIO.input1 strm
              of NONE => NONE
	       | SOME (c, strm') => 
		   SOME (c, Stream {
			        strm = strm', 
				pos = pos+1, 
				id = id,
				lineNo = lineNo + 
					 (if c = #"\n" then 1 else 0),
				lastWasNL = (c = #"\n")
			      })
	     (* end case*))

	fun getpos (Stream {pos, ...}) = pos

	fun getlineNo (Stream {lineNo, ...}) = lineNo

	fun subtract (new, old) = let
	      val Stream {strm = strm, pos = oldPos, id = oldId, ...} = old
	      val Stream {pos = newPos, id = newId, ...} = new
              val (diff, _) = if newId = oldId andalso newPos >= oldPos
			      then TSIO.inputN (strm, newPos - oldPos)
			      else raise Fail 
				"BUG: yyInput: attempted to subtract incompatible streams"
	      in 
		diff 
	      end

	fun eof s = not (isSome (getc s))

	fun lastWasNL (Stream {lastWasNL, ...}) = lastWasNL

      end

    datatype yystart_state = 
STRING | COMMENT | UNSTRING | INITIAL
    structure UserDeclarations = 
      struct

(* -*- mode:sml -*- *)

type svalue = Tokens.svalue
type pos = int
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue, pos) token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
val commentLevel = ref 0
val currentString = ref ""
val inString = ref false

fun err(p1,p2) = ErrorMsg.error p1

fun eofCleanup () =
    let
        val commentUnfinished = (!commentLevel) > 0
        val stringUnfinished = !inString
    in
        commentLevel := 0;
        inString := false;
        currentString := "";
        if commentUnfinished
        then ErrorMsg.error 0 "Unfinished comment at end of file"
        else ();
        if stringUnfinished
        then ErrorMsg.error 0 "Unfinished string at end of file"
        else ()
    end

fun eof () =
    let
        val pos = hd (!linePos)
    in
        eofCleanup ();
        Tokens.EOF(pos,pos)
    end

fun doNewline pos =
    ( lineNum := !lineNum+1
    ; linePos := pos :: !linePos)

fun s2i t pos =
    let
        val opti = (Int.fromString t) 
            handle Overflow => 
                   (ErrorMsg.error pos "Integer too large"; SOME 0)
        fun s2iAux NONE = (ErrorMsg.error pos "Ill-formed integer"; 0)
          | s2iAux (SOME n) = n
    in
        s2iAux opti
    end

fun escInterp s pos =
    let
        val isDigit = Char.isDigit

        fun isFormatting #" "  = true
          | isFormatting #"\t" = true
          | isFormatting #"\n" = true
          | isFormatting #"\f" = true
          | isFormatting _     = false

        fun fail msg =
            let
                val fullMsg = "Ill-formed string (" ^ msg ^ ")"
            in
                ErrorMsg.error pos msg; #"_"
            end

        (* ^c interpret *)
        fun hatci c =
            if #"@" <= c andalso c <= #"_" then chr(ord(c)-64) else
            if #"a" <= c andalso c <= #"z" then chr(ord(c)-96) else
            fail "\\^c"

        (* number interpret *)
        fun numi (c1::c2::c3::cs) =
            let
                fun cVal c = ord(c) - ord(#"0")
                val c1c2c3Val = 100*(cVal c1) + 10*(cVal c2) + 1*(cVal c3)
            in
                if not (List.all isDigit [c1,c2,c3]) then
                    (fail "\\ddd: expects 3 digits", cs)
                else if c1c2c3Val >= 256 then
                    (fail "\\ddd: number too large", cs)
                else (chr(c1c2c3Val), cs)
            end
          | numi cs = (fail "\\ddd: string too short", cs)

        (* backslash interpret *)
        fun bsi #"n" cs = (#"\n", cs)
          | bsi #"t" cs = (#"\t", cs)
          | bsi #"^" (c::cs) = (hatci c, cs)
          | bsi #"\"" cs = (#"\"",cs)
          | bsi #"\\" cs = (#"\\",cs)
          | bsi c cs =
            if isDigit c then numi (c::cs)
            else (fail "incorrect use of \\...", cs)

        (* escape interpret *)
        fun ei [] = []
          | ei (#"\\"::c::cs) =
            let
                val (c',cs') = bsi c cs
            in
                c' :: ei cs'
            end
          | ei (c::cs) = c :: (ei cs)
    in
        (implode o ei o explode) s
    end

fun dopos token yypos yylen = token (yypos, yypos + yylen)
fun dopos3 token value yypos yylen = token (value, yypos, yypos + yylen)



      end

    datatype yymatch 
      = yyNO_MATCH
      | yyMATCH of yyInput.stream * action * yymatch
    withtype action = yyInput.stream * yymatch -> UserDeclarations.lexresult

    local

    val yytable = 
Vector.fromList []
    fun mk yyins = let
        (* current start state *)
        val yyss = ref INITIAL
	fun YYBEGIN ss = (yyss := ss)
	(* current input stream *)
        val yystrm = ref yyins
	(* get one char of input *)
	val yygetc = yyInput.getc
	(* create yytext *)
	fun yymktext(strm) = yyInput.subtract (strm, !yystrm)
        open UserDeclarations
        fun lex 
(yyarg as ()) = let 
     fun continue() = let
            val yylastwasn = yyInput.lastWasNL (!yystrm)
            fun yystuck (yyNO_MATCH) = raise Fail "stuck state"
	      | yystuck (yyMATCH (strm, action, old)) = 
		  action (strm, old)
	    val yypos = yyInput.getpos (!yystrm)
	    val yygetlineNo = yyInput.getlineNo
	    fun yyactsToMatches (strm, [],	  oldMatches) = oldMatches
	      | yyactsToMatches (strm, act::acts, oldMatches) = 
		  yyMATCH (strm, act, yyactsToMatches (strm, acts, oldMatches))
	    fun yygo actTable = 
		(fn (~1, _, oldMatches) => yystuck oldMatches
		  | (curState, strm, oldMatches) => let
		      val (transitions, finals') = Vector.sub (yytable, curState)
		      val finals = map (fn i => Vector.sub (actTable, i)) finals'
		      fun tryfinal() = 
		            yystuck (yyactsToMatches (strm, finals, oldMatches))
		      fun find (c, []) = NONE
			| find (c, (c1, c2, s)::ts) = 
		            if c1 <= c andalso c <= c2 then SOME s
			    else find (c, ts)
		      in case yygetc strm
			  of SOME(c, strm') => 
			       (case find (c, transitions)
				 of NONE => tryfinal()
				  | SOME n => 
				      yygo actTable
					(n, strm', 
					 yyactsToMatches (strm, finals, oldMatches)))
			   | NONE => tryfinal()
		      end)
	    in 
let
fun yyAction0 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( doNewline yypos
                              ; continue ()))
fun yyAction1 (strm, lastMatch : yymatch) = (yystrm := strm; (continue ()))
fun yyAction2 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.TYPE yypos 4))
fun yyAction3 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.VAR yypos 3))
fun yyAction4 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.FUNCTION yypos 8))
fun yyAction5 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.BREAK yypos 5))
fun yyAction6 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.OF yypos 2))
fun yyAction7 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.END yypos 3))
fun yyAction8 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.IN yypos 2))
fun yyAction9 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.NIL yypos 3))
fun yyAction10 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.LET yypos 3))
fun yyAction11 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.DO yypos 2))
fun yyAction12 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.TO yypos 2))
fun yyAction13 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.FOR yypos 3))
fun yyAction14 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.WHILE yypos 5))
fun yyAction15 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.ELSE yypos 4))
fun yyAction16 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.THEN yypos 4))
fun yyAction17 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.IF yypos 2))
fun yyAction18 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.ARRAY yypos 5))
fun yyAction19 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.ASSIGN yypos 2))
fun yyAction20 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.OR yypos 1))
fun yyAction21 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.AND yypos 1))
fun yyAction22 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.GE yypos 2))
fun yyAction23 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.GT yypos 1))
fun yyAction24 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.LE yypos 2))
fun yyAction25 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.LT yypos 1))
fun yyAction26 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.NEQ yypos 2))
fun yyAction27 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.EQ yypos 1))
fun yyAction28 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.DIVIDE yypos 1))
fun yyAction29 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.TIMES yypos 1))
fun yyAction30 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.MINUS yypos 1))
fun yyAction31 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.PLUS yypos 1))
fun yyAction32 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.DOT yypos 1))
fun yyAction33 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.RBRACE yypos 1))
fun yyAction34 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.LBRACE yypos 1))
fun yyAction35 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.RBRACK yypos 1))
fun yyAction36 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.LBRACK yypos 1))
fun yyAction37 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.RPAREN yypos 1))
fun yyAction38 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.LPAREN yypos 1))
fun yyAction39 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.SEMICOLON yypos 1))
fun yyAction40 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.COLON yypos 1))
fun yyAction41 (strm, lastMatch : yymatch) = (yystrm := strm;
      (dopos Tokens.COMMA yypos 1))
fun yyAction42 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (dopos3 Tokens.INT (s2i yytext yypos) yypos
                                                 (size yytext))
      end
fun yyAction43 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (dopos3 Tokens.ID yytext yypos
                                                (size yytext))
      end
fun yyAction44 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( YYBEGIN STRING
                              ; inString := true
                              ; continue ()))
fun yyAction45 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( YYBEGIN INITIAL;
                                let 
                                    val str = escInterp (!currentString) yypos
                                    val sz = size str
                                    val pos = yypos - 1 - sz
                                in
                                    inString := false;
                                    currentString := "";
                                    dopos3 Tokens.STRING str pos sz
                                end))
fun yyAction46 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( currentString := !currentString ^ "\""
                              ; continue ()))
fun yyAction47 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( currentString := !currentString ^ "\\\\"
                              ; continue ()))
fun yyAction48 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( YYBEGIN UNSTRING
                              ; doNewline yypos
                              ; continue ()))
fun yyAction49 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( doNewline yypos
                              ; ErrorMsg.error yypos
                                               "string reaches end of line"
                              ; continue ()))
fun yyAction50 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        ( currentString := !currentString ^ yytext
                              ; continue ())
      end
fun yyAction51 (strm, lastMatch : yymatch) = (yystrm := strm; (continue ()))
fun yyAction52 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( YYBEGIN STRING
                              ; continue ()))
fun yyAction53 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        (ErrorMsg.error yypos ("illegal char in string"
                                                     ^ " escape \\f___f\\: "
                                                     ^ yytext);
                               continue ())
      end
fun yyAction54 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( YYBEGIN COMMENT
                              ; commentLevel := 1
                              ; continue ()))
fun yyAction55 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( commentLevel := !commentLevel + 1
                              ; continue ()))
fun yyAction56 (strm, lastMatch : yymatch) = (yystrm := strm;
      ( commentLevel := !commentLevel - 1
                              ; if !commentLevel=0 then YYBEGIN INITIAL else ()
                              ; continue ()))
fun yyAction57 (strm, lastMatch : yymatch) = (yystrm := strm; (continue ()))
fun yyAction58 (strm, lastMatch : yymatch) = let
      val yytext = yymktext(strm)
      in
        yystrm := strm;
        ( ErrorMsg.error yypos ("illegal char: " ^ yytext)
                              ; continue ())
      end
fun yyQ56 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction33(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction33(strm, yyNO_MATCH)
      (* end case *))
fun yyQ55 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction20(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction20(strm, yyNO_MATCH)
      (* end case *))
fun yyQ54 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction34(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction34(strm, yyNO_MATCH)
      (* end case *))
fun yyQ57 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction43(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp = #"`"
              then yyAction43(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ61 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction14(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction14(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction14(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction14(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction14, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction14(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction14, yyNO_MATCH))
            else if inp = #"`"
              then yyAction14(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction14, yyNO_MATCH))
                  else yyAction14(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction14, yyNO_MATCH))
              else yyAction14(strm, yyNO_MATCH)
      (* end case *))
fun yyQ60 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ61(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ59 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"l"
              then yyQ60(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"l"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ58 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"i"
              then yyQ59(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"i"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ53 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"h"
              then yyQ58(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"h"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ63 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction3(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction3(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction3(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction3(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction3, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction3(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction3, yyNO_MATCH))
            else if inp = #"`"
              then yyAction3(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction3, yyNO_MATCH))
                  else yyAction3(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction3, yyNO_MATCH))
              else yyAction3(strm, yyNO_MATCH)
      (* end case *))
fun yyQ62 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ63(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ52 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"b"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"b"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ62(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ68 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction2(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction2(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction2(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction2(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction2, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction2(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction2, yyNO_MATCH))
            else if inp = #"`"
              then yyAction2(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction2, yyNO_MATCH))
                  else yyAction2(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction2, yyNO_MATCH))
              else yyAction2(strm, yyNO_MATCH)
      (* end case *))
fun yyQ67 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ68(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ66 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"p"
              then yyQ67(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"p"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ65 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction12(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction12(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction12(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction12(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction12, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction12(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction12, yyNO_MATCH))
            else if inp = #"`"
              then yyAction12(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction12, yyNO_MATCH))
                  else yyAction12(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction12, yyNO_MATCH))
              else yyAction12(strm, yyNO_MATCH)
      (* end case *))
fun yyQ70 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction16(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction16(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction16(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction16(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction16, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction16(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction16, yyNO_MATCH))
            else if inp = #"`"
              then yyAction16(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction16, yyNO_MATCH))
                  else yyAction16(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction16, yyNO_MATCH))
              else yyAction16(strm, yyNO_MATCH)
      (* end case *))
fun yyQ69 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ70(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ64 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ69(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ51 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"a"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"a"
              then if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then if inp = #"0"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                    else if inp < #"0"
                      then yyAction43(strm, yyNO_MATCH)
                    else if inp <= #"9"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                      else yyAction43(strm, yyNO_MATCH)
                else if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"_"
                  then if inp <= #"Z"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                      else yyAction43(strm, yyNO_MATCH)
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"p"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"p"
              then if inp = #"i"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"i"
                  then if inp = #"h"
                      then yyQ64(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"o"
                  then yyQ65(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp = #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"z"
              then if inp = #"y"
                  then yyQ66(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ71 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction6(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction6(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction6(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction6(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction6, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction6(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction6, yyNO_MATCH))
            else if inp = #"`"
              then yyAction6(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction6, yyNO_MATCH))
                  else yyAction6(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction6, yyNO_MATCH))
              else yyAction6(strm, yyNO_MATCH)
      (* end case *))
fun yyQ50 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"f"
              then yyQ71(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"f"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ73 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction9(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction9(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction9(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction9(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction9, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction9(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction9, yyNO_MATCH))
            else if inp = #"`"
              then yyAction9(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction9, yyNO_MATCH))
                  else yyAction9(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction9, yyNO_MATCH))
              else yyAction9(strm, yyNO_MATCH)
      (* end case *))
fun yyQ72 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"l"
              then yyQ73(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"l"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ49 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"i"
              then yyQ72(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"i"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ75 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction10(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction10(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction10(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction10(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction10, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction10(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction10, yyNO_MATCH))
            else if inp = #"`"
              then yyAction10(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction10, yyNO_MATCH))
                  else yyAction10(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction10, yyNO_MATCH))
              else yyAction10(strm, yyNO_MATCH)
      (* end case *))
fun yyQ74 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"t"
              then yyQ75(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"t"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ48 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ74(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ77 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction8(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction8(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction8(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction8(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction8, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction8(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction8, yyNO_MATCH))
            else if inp = #"`"
              then yyAction8(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction8, yyNO_MATCH))
                  else yyAction8(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction8, yyNO_MATCH))
              else yyAction8(strm, yyNO_MATCH)
      (* end case *))
fun yyQ76 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction17(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction17(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction17(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction17(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction17, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction17(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction17, yyNO_MATCH))
            else if inp = #"`"
              then yyAction17(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction17, yyNO_MATCH))
                  else yyAction17(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction17, yyNO_MATCH))
              else yyAction17(strm, yyNO_MATCH)
      (* end case *))
fun yyQ47 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"`"
              then yyAction43(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then if inp = #"0"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                    else if inp < #"0"
                      then yyAction43(strm, yyNO_MATCH)
                    else if inp <= #"9"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                      else yyAction43(strm, yyNO_MATCH)
                else if inp = #"["
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #"["
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ77(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"f"
                  then yyQ76(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ85 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction4(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction4(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction4(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction4(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction4, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction4(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction4, yyNO_MATCH))
            else if inp = #"`"
              then yyAction4(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction4, yyNO_MATCH))
                  else yyAction4(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction4, yyNO_MATCH))
              else yyAction4(strm, yyNO_MATCH)
      (* end case *))
fun yyQ84 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ85(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ83 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"o"
              then yyQ84(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"o"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ82 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"i"
              then yyQ83(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"i"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ81 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"t"
              then yyQ82(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"t"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ80 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"c"
              then yyQ81(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"c"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ79 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ80(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ86 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction13(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction13(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction13(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction13(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction13, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction13(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction13, yyNO_MATCH))
            else if inp = #"`"
              then yyAction13(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction13, yyNO_MATCH))
                  else yyAction13(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction13, yyNO_MATCH))
              else yyAction13(strm, yyNO_MATCH)
      (* end case *))
fun yyQ78 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ86(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ46 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"`"
              then yyAction43(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then if inp = #"0"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                    else if inp < #"0"
                      then yyAction43(strm, yyNO_MATCH)
                    else if inp <= #"9"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                      else yyAction43(strm, yyNO_MATCH)
                else if inp = #"["
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #"["
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"u"
              then yyQ79(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"u"
              then if inp = #"o"
                  then yyQ78(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ89 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction7(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction7(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction7(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction7(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction7, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction7(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction7, yyNO_MATCH))
            else if inp = #"`"
              then yyAction7(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction7, yyNO_MATCH))
                  else yyAction7(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction7, yyNO_MATCH))
              else yyAction7(strm, yyNO_MATCH)
      (* end case *))
fun yyQ88 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"d"
              then yyQ89(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"d"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ91 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction15(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction15(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction15(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction15(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction15, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction15(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction15, yyNO_MATCH))
            else if inp = #"`"
              then yyAction15(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction15, yyNO_MATCH))
                  else yyAction15(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction15, yyNO_MATCH))
              else yyAction15(strm, yyNO_MATCH)
      (* end case *))
fun yyQ90 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ91(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ87 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"s"
              then yyQ90(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"s"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ45 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"`"
              then yyAction43(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then if inp = #"0"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                    else if inp < #"0"
                      then yyAction43(strm, yyNO_MATCH)
                    else if inp <= #"9"
                      then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                      else yyAction43(strm, yyNO_MATCH)
                else if inp = #"["
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #"["
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"n"
              then yyQ88(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"n"
              then if inp = #"l"
                  then yyQ87(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ92 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction11(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction11(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction11(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction11(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction11, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction11(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction11, yyNO_MATCH))
            else if inp = #"`"
              then yyAction11(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction11, yyNO_MATCH))
                  else yyAction11(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction11, yyNO_MATCH))
              else yyAction11(strm, yyNO_MATCH)
      (* end case *))
fun yyQ44 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"o"
              then yyQ92(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"o"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ96 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction5(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction5(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction5(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction5(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction5, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction5(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction5, yyNO_MATCH))
            else if inp = #"`"
              then yyAction5(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction5, yyNO_MATCH))
                  else yyAction5(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction5, yyNO_MATCH))
              else yyAction5(strm, yyNO_MATCH)
      (* end case *))
fun yyQ95 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"k"
              then yyQ96(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"k"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ94 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"b"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"b"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ95(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ93 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"e"
              then yyQ94(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"e"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ43 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ93(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ100 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction18(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction18(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction18(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction18(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction18, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction18(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction18, yyNO_MATCH))
            else if inp = #"`"
              then yyAction18(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction18, yyNO_MATCH))
                  else yyAction18(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction18, yyNO_MATCH))
              else yyAction18(strm, yyNO_MATCH)
      (* end case *))
fun yyQ99 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"y"
              then yyQ100(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"y"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp = #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ98 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"b"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"b"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ99(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ97 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ98(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ42 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"_"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"_"
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp = #"A"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp < #"A"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp <= #"Z"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp = #"r"
              then yyQ97(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp < #"r"
              then if inp = #"`"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ41 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction35(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction35(strm, yyNO_MATCH)
      (* end case *))
fun yyQ40 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction36(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction36(strm, yyNO_MATCH)
      (* end case *))
fun yyQ39 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction43(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyAction43(strm, yyNO_MATCH)
            else if inp < #"["
              then if inp = #":"
                  then yyAction43(strm, yyNO_MATCH)
                else if inp < #":"
                  then if inp <= #"/"
                      then yyAction43(strm, yyNO_MATCH)
                      else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                else if inp <= #"@"
                  then yyAction43(strm, yyNO_MATCH)
                  else yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
            else if inp = #"`"
              then yyAction43(strm, yyNO_MATCH)
            else if inp < #"`"
              then if inp = #"_"
                  then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
                  else yyAction43(strm, yyNO_MATCH)
            else if inp <= #"z"
              then yyQ57(strm', yyMATCH(strm, yyAction43, yyNO_MATCH))
              else yyAction43(strm, yyNO_MATCH)
      (* end case *))
fun yyQ101 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction22(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction22(strm, yyNO_MATCH)
      (* end case *))
fun yyQ38 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction23(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"="
              then yyQ101(strm', yyMATCH(strm, yyAction23, yyNO_MATCH))
              else yyAction23(strm, yyNO_MATCH)
      (* end case *))
fun yyQ37 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction27(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction27(strm, yyNO_MATCH)
      (* end case *))
fun yyQ103 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction26(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction26(strm, yyNO_MATCH)
      (* end case *))
fun yyQ102 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction24(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction24(strm, yyNO_MATCH)
      (* end case *))
fun yyQ36 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction25(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #">"
              then yyQ103(strm', yyMATCH(strm, yyAction25, yyNO_MATCH))
            else if inp < #">"
              then if inp = #"="
                  then yyQ102(strm', yyMATCH(strm, yyAction25, yyNO_MATCH))
                  else yyAction25(strm, yyNO_MATCH)
              else yyAction25(strm, yyNO_MATCH)
      (* end case *))
fun yyQ35 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction39(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction39(strm, yyNO_MATCH)
      (* end case *))
fun yyQ104 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction19(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction19(strm, yyNO_MATCH)
      (* end case *))
fun yyQ34 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction40(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"="
              then yyQ104(strm', yyMATCH(strm, yyAction40, yyNO_MATCH))
              else yyAction40(strm, yyNO_MATCH)
      (* end case *))
fun yyQ105 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction42(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ105(strm', yyMATCH(strm, yyAction42, yyNO_MATCH))
            else if inp < #"0"
              then yyAction42(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ105(strm', yyMATCH(strm, yyAction42, yyNO_MATCH))
              else yyAction42(strm, yyNO_MATCH)
      (* end case *))
fun yyQ33 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction42(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"0"
              then yyQ105(strm', yyMATCH(strm, yyAction42, yyNO_MATCH))
            else if inp < #"0"
              then yyAction42(strm, yyNO_MATCH)
            else if inp <= #"9"
              then yyQ105(strm', yyMATCH(strm, yyAction42, yyNO_MATCH))
              else yyAction42(strm, yyNO_MATCH)
      (* end case *))
fun yyQ106 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction54(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction54(strm, yyNO_MATCH)
      (* end case *))
fun yyQ32 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction28(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"*"
              then yyQ106(strm', yyMATCH(strm, yyAction28, yyNO_MATCH))
              else yyAction28(strm, yyNO_MATCH)
      (* end case *))
fun yyQ31 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction32(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction32(strm, yyNO_MATCH)
      (* end case *))
fun yyQ30 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction30(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction30(strm, yyNO_MATCH)
      (* end case *))
fun yyQ29 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction41(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction41(strm, yyNO_MATCH)
      (* end case *))
fun yyQ28 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction31(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction31(strm, yyNO_MATCH)
      (* end case *))
fun yyQ27 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction29(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction29(strm, yyNO_MATCH)
      (* end case *))
fun yyQ26 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction37(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction37(strm, yyNO_MATCH)
      (* end case *))
fun yyQ25 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction38(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction38(strm, yyNO_MATCH)
      (* end case *))
fun yyQ24 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction21(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction21(strm, yyNO_MATCH)
      (* end case *))
fun yyQ23 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction44(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction44(strm, yyNO_MATCH)
      (* end case *))
fun yyQ12 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction0(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction0(strm, yyNO_MATCH)
      (* end case *))
fun yyQ22 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction1(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction1(strm, yyNO_MATCH)
      (* end case *))
fun yyQ21 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction58(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction58(strm, yyNO_MATCH)
      (* end case *))
fun yyQ3 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #"["
              then yyQ40(strm', lastMatch)
            else if inp < #"["
              then if inp = #"+"
                  then yyQ28(strm', lastMatch)
                else if inp < #"+"
                  then if inp = #"\""
                      then yyQ23(strm', lastMatch)
                    else if inp < #"\""
                      then if inp = #"\v"
                          then yyQ21(strm', lastMatch)
                        else if inp < #"\v"
                          then if inp = #"\t"
                              then yyQ22(strm', lastMatch)
                            else if inp = #"\n"
                              then yyQ12(strm', lastMatch)
                              else yyQ21(strm', lastMatch)
                        else if inp = #" "
                          then yyQ22(strm', lastMatch)
                          else yyQ21(strm', lastMatch)
                    else if inp = #"("
                      then yyQ25(strm', lastMatch)
                    else if inp < #"("
                      then if inp = #"&"
                          then yyQ24(strm', lastMatch)
                          else yyQ21(strm', lastMatch)
                    else if inp = #")"
                      then yyQ26(strm', lastMatch)
                      else yyQ27(strm', lastMatch)
                else if inp = #";"
                  then yyQ35(strm', lastMatch)
                else if inp < #";"
                  then if inp = #"/"
                      then yyQ32(strm', lastMatch)
                    else if inp < #"/"
                      then if inp = #"-"
                          then yyQ30(strm', lastMatch)
                        else if inp = #","
                          then yyQ29(strm', lastMatch)
                          else yyQ31(strm', lastMatch)
                    else if inp = #":"
                      then yyQ34(strm', lastMatch)
                      else yyQ33(strm', lastMatch)
                else if inp = #">"
                  then yyQ38(strm', lastMatch)
                else if inp < #">"
                  then if inp = #"<"
                      then yyQ36(strm', lastMatch)
                      else yyQ37(strm', lastMatch)
                else if inp <= #"@"
                  then yyQ21(strm', lastMatch)
                  else yyQ39(strm', lastMatch)
            else if inp = #"m"
              then yyQ39(strm', lastMatch)
            else if inp < #"m"
              then if inp = #"d"
                  then yyQ44(strm', lastMatch)
                else if inp < #"d"
                  then if inp = #"a"
                      then yyQ42(strm', lastMatch)
                    else if inp < #"a"
                      then if inp = #"]"
                          then yyQ41(strm', lastMatch)
                          else yyQ21(strm', lastMatch)
                    else if inp = #"b"
                      then yyQ43(strm', lastMatch)
                      else yyQ39(strm', lastMatch)
                else if inp = #"i"
                  then yyQ47(strm', lastMatch)
                else if inp < #"i"
                  then if inp = #"f"
                      then yyQ46(strm', lastMatch)
                    else if inp = #"e"
                      then yyQ45(strm', lastMatch)
                      else yyQ39(strm', lastMatch)
                else if inp = #"l"
                  then yyQ48(strm', lastMatch)
                  else yyQ39(strm', lastMatch)
            else if inp = #"w"
              then yyQ53(strm', lastMatch)
            else if inp < #"w"
              then if inp = #"t"
                  then yyQ51(strm', lastMatch)
                else if inp < #"t"
                  then if inp = #"o"
                      then yyQ50(strm', lastMatch)
                    else if inp = #"n"
                      then yyQ49(strm', lastMatch)
                      else yyQ39(strm', lastMatch)
                else if inp = #"u"
                  then yyQ39(strm', lastMatch)
                  else yyQ52(strm', lastMatch)
            else if inp = #"|"
              then yyQ55(strm', lastMatch)
            else if inp < #"|"
              then if inp = #"{"
                  then yyQ54(strm', lastMatch)
                  else yyQ39(strm', lastMatch)
            else if inp = #"}"
              then yyQ56(strm', lastMatch)
              else yyQ21(strm', lastMatch)
      (* end case *))
fun yyQ20 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction52(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction52(strm, yyNO_MATCH)
      (* end case *))
fun yyQ19 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction51(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction51(strm, yyNO_MATCH)
      (* end case *))
fun yyQ18 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction51(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction51(strm, yyNO_MATCH)
      (* end case *))
fun yyQ17 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction53(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction53(strm, yyNO_MATCH)
      (* end case *))
fun yyQ2 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #" "
              then yyQ18(strm', lastMatch)
            else if inp < #" "
              then if inp = #"\n"
                  then yyQ19(strm', lastMatch)
                else if inp < #"\n"
                  then if inp = #"\t"
                      then yyQ18(strm', lastMatch)
                      else yyQ17(strm', lastMatch)
                  else yyQ17(strm', lastMatch)
            else if inp = #"\\"
              then yyQ20(strm', lastMatch)
              else yyQ17(strm', lastMatch)
      (* end case *))
fun yyQ15 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction55(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction55(strm, yyNO_MATCH)
      (* end case *))
fun yyQ14 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction57(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"*"
              then yyQ15(strm', yyMATCH(strm, yyAction57, yyNO_MATCH))
              else yyAction57(strm, yyNO_MATCH)
      (* end case *))
fun yyQ16 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction56(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction56(strm, yyNO_MATCH)
      (* end case *))
fun yyQ13 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction57(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"/"
              then yyQ16(strm', yyMATCH(strm, yyAction57, yyNO_MATCH))
              else yyAction57(strm, yyNO_MATCH)
      (* end case *))
fun yyQ11 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction57(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction57(strm, yyNO_MATCH)
      (* end case *))
fun yyQ1 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #"*"
              then yyQ13(strm', lastMatch)
            else if inp < #"*"
              then if inp = #"\n"
                  then yyQ12(strm', lastMatch)
                  else yyQ11(strm', lastMatch)
            else if inp = #"/"
              then yyQ14(strm', lastMatch)
              else yyQ11(strm', lastMatch)
      (* end case *))
fun yyQ10 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction47(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction47(strm, yyNO_MATCH)
      (* end case *))
fun yyQ9 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction46(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction46(strm, yyNO_MATCH)
      (* end case *))
fun yyQ8 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction48(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction48(strm, yyNO_MATCH)
      (* end case *))
fun yyQ7 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction50(strm, yyNO_MATCH)
        | SOME(inp, strm') =>
            if inp = #"!"
              then yyAction50(strm, yyNO_MATCH)
            else if inp < #"!"
              then if inp = #"\v"
                  then yyAction50(strm, yyNO_MATCH)
                else if inp < #"\v"
                  then if inp <= #"\b"
                      then yyAction50(strm, yyNO_MATCH)
                      else yyQ8(strm', yyMATCH(strm, yyAction50, yyNO_MATCH))
                else if inp = #" "
                  then yyQ8(strm', yyMATCH(strm, yyAction50, yyNO_MATCH))
                  else yyAction50(strm, yyNO_MATCH)
            else if inp = #"\\"
              then yyQ10(strm', yyMATCH(strm, yyAction50, yyNO_MATCH))
            else if inp < #"\\"
              then if inp = #"\""
                  then yyQ9(strm', yyMATCH(strm, yyAction50, yyNO_MATCH))
                  else yyAction50(strm, yyNO_MATCH)
              else yyAction50(strm, yyNO_MATCH)
      (* end case *))
fun yyQ6 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction45(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction45(strm, yyNO_MATCH)
      (* end case *))
fun yyQ5 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction49(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction49(strm, yyNO_MATCH)
      (* end case *))
fun yyQ4 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE => yyAction50(strm, yyNO_MATCH)
        | SOME(inp, strm') => yyAction50(strm, yyNO_MATCH)
      (* end case *))
fun yyQ0 (strm, lastMatch : yymatch) = (case (yygetc(strm))
       of NONE =>
            if yyInput.eof(!(yystrm))
              then UserDeclarations.eof(yyarg)
              else yystuck(lastMatch)
        | SOME(inp, strm') =>
            if inp = #"\""
              then yyQ6(strm', lastMatch)
            else if inp < #"\""
              then if inp = #"\n"
                  then yyQ5(strm', lastMatch)
                  else yyQ4(strm', lastMatch)
            else if inp = #"\\"
              then yyQ7(strm', lastMatch)
              else yyQ4(strm', lastMatch)
      (* end case *))
in
  (case (!(yyss))
   of STRING => yyQ0(!(yystrm), yyNO_MATCH)
    | COMMENT => yyQ1(!(yystrm), yyNO_MATCH)
    | UNSTRING => yyQ2(!(yystrm), yyNO_MATCH)
    | INITIAL => yyQ3(!(yystrm), yyNO_MATCH)
  (* end case *))
end
            end
	  in 
            continue() 	  
	    handle IO.Io{cause, ...} => raise cause
          end
        in 
          lex 
        end
    in
    fun makeLexer yyinputN = mk (yyInput.mkStream yyinputN)
    fun makeLexer' ins = mk (yyInput.mkStream ins)
    end

  end
