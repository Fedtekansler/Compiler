(* -*- mode:sml -*- *)

type svalue = Tokens.svalue
type pos = int
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue, pos) token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos

val commentLevel = ref 0
val currentString = ref ""
val currentStringPos = ref 0

fun err (p1,p2) = ErrorMsg.error p1

fun eof () =
    let
        val pos = hd (!linePos)
    in
        Tokens.EOF (pos,pos)
    end

fun s2i t pos =
    let
        val opti = (Int.fromString t) 
            handle Overflow => 
                   (ErrorMsg.error pos "Integer too large"; SOME 0)
        fun s2i_aux NONE = (ErrorMsg.error pos "Ill-formed integer"; 0)
          | s2i_aux (SOME n) = n
    in
        s2i_aux opti
    end

fun dopos token yypos yylen = token (yypos, yypos + yylen)
fun dopos3 token value yypos yylen = token (value, yypos, yypos + yylen)

%%
%header (functor TigerLexFun (structure Tokens: Tiger_TOKENS));
%s STRING COMMENT;
letter=[a-zA-Z];
digits=[0-9]+;
idchars=[a-zA-Z0-9_]*;
stringchars=[a-zA-Z0-9_]*;
whitespace=(" " | "\t")*;
%%

<INITIAL, COMMENT>"\n"			=> (lineNum := !lineNum+1;
						    linePos := yypos :: !linePos;
						    continue());
<INITIAL>","					=> (dopos Tokens.COMMA yypos 1);
<INITIAL>":"					=> (dopos Tokens.COLON yypos 1);
<INITIAL>";"					=> (dopos Tokens.SEMICOLON yypos 1);
<INITIAL>"("					=> (dopos Tokens.LPAREN yypos 1);
<INITIAL>")"					=> (dopos Tokens.RPAREN yypos 1);
<INITIAL>"["					=> (dopos Tokens.LBRACK yypos 1);
<INITIAL>"]"					=> (dopos Tokens.RBRACK yypos 1);
<INITIAL>"{"					=> (dopos Tokens.LBRACE yypos 1);
<INITIAL>"}"					=> (dopos Tokens.RBRACE yypos 1);
<INITIAL>"."					=> (dopos Tokens.DOT yypos 1);
<INITIAL>"+"					=> (dopos Tokens.PLUS yypos 1);
<INITIAL>"-"					=> (dopos Tokens.MINUS yypos 1);
<INITIAL>"*"					=> (dopos Tokens.TIMES yypos 1);
<INITIAL>"/" 					=> (dopos Tokens.DIVIDE yypos 1);
<INITIAL>"="					=> (dopos Tokens.EQ yypos 1);
<INITIAL>"<>"					=> (dopos Tokens.NEQ yypos 2);
<INITIAL>"<"					=> (dopos Tokens.LT yypos 1);
<INITIAL>"<="					=> (dopos Tokens.LE yypos 2);
<INITIAL>">"					=> (dopos Tokens.GT yypos 1);
<INITIAL>">="					=> (dopos Tokens.GE yypos 2);
<INITIAL>"&"					=> (dopos Tokens.AND yypos 1);
<INITIAL>"|"					=> (dopos Tokens.OR yypos 1);
<INITIAL>":="					=> (dopos Tokens.ASSIGN yypos 2);
<INITIAL>"while"				=> (dopos Tokens.WHILE yypos 5);
<INITIAL>"for"					=> (dopos Tokens.FOR yypos 3);
<INITIAL>"to"					=> (dopos Tokens.TO yypos 2);
<INITIAL>"break"				=> (dopos Tokens.BREAK yypos 5);
<INITIAL>"let"					=> (dopos Tokens.LET yypos 3);
<INITIAL>"in"					=> (dopos Tokens.IN yypos 2);
<INITIAL>"end"					=> (dopos Tokens.END yypos 3);
<INITIAL>"function"				=> (dopos Tokens.FUNCTION yypos 8);
<INITIAL>"var"					=> (dopos Tokens.VAR yypos 3);
<INITIAL>"type"					=> (dopos Tokens.TYPE yypos 4);
<INITIAL>"array"				=> (dopos Tokens.ARRAY yypos 5);
<INITIAL>"if"					=> (dopos Tokens.IF yypos 2);
<INITIAL>"then"					=> (dopos Tokens.THEN yypos 4);
<INITIAL>"else"					=> (dopos Tokens.ELSE yypos 4);
<INITIAL>"do"					=> (dopos Tokens.DO yypos 2);
<INITIAL>"of"					=> (dopos Tokens.OF yypos 2);
<INITIAL>"nil"					=> (dopos Tokens.NIL yypos 3);

<INITIAL>"\""					=> (YYBEGIN STRING; currentStringPos := yypos; currentString := ""; continue());
<STRING>"\""					=> (YYBEGIN INITIAL; dopos3 Tokens.STRING (!currentString) (!currentStringPos) (size (!currentString)));
<STRING>"\\n"					=> (lineNum := !lineNum+1;
								linePos := yypos :: !linePos;
								currentString := !currentString ^ "\n"; continue());
<STRING>"\n"					=> (ErrorMsg.error yypos ("illegal enter " ^ yytext);
                                continue());
<STRING>.						=> (currentString := !currentString ^ yytext; continue());

<INITIAL>{digits}				=> (dopos3 Tokens.INT (s2i yytext yypos) yypos
							   (size yytext));
<INITIAL>{letter}{idchars}		=> (dopos3 Tokens.ID yytext yypos (size yytext));
<INITIAL>"/*"					=> (YYBEGIN COMMENT; continue());
<COMMENT>"*/"					=> ((if (!commentLevel) = 0 
						    then YYBEGIN INITIAL
						    else commentLevel := !commentLevel - 1); continue());
<COMMENT>"/*"					=> (commentLevel := !commentLevel + 1; continue());
<COMMENT>.						=> (continue());

<INITIAL>{whitespace}			=> (continue());
<INITIAL>.						=> (ErrorMsg.error yypos ("illegal char " ^ yytext);
                               continue());


