structure PrintAbsyn:
          sig
              val asString: Absyn.exp -> string
              val print: TextIO.outstream * Absyn.exp -> unit
          end = 
struct

structure A = Absyn
structure S = Symbol

val i2s = Int.toString

fun printEncode s =
    let
        fun bs1 cs = #"\\" :: cs
        val bs2 = bs1 o bs1
        val bs3 = bs2 o bs1
        val bs4 = bs3 o bs1
                  
        fun pe [] = []
          | pe (#"\\"::cs) = (bs2 o pe) cs
          | pe (#"\""::cs) = bs1 (#"\"" :: pe cs)
          | pe (#"\a"::cs) = bs1 (#"a" :: pe cs)
          | pe (#"\b"::cs) = bs1 (#"b" :: pe cs)
          | pe (#"\f"::cs) = bs1 (#"f" :: pe cs)
          | pe (#"\n"::cs) = bs1 (#"n" :: pe cs)
          | pe (#"\r"::cs) = bs1 (#"r" :: pe cs)
          | pe (#"\t"::cs) = bs1 (#"t" :: pe cs)
          | pe (#"\v"::cs) = bs1 (#"v" :: pe cs)
          | pe (c::cs) =
            let
                val ordc = ord (c)
                val charsc = Int.toString ordc
                val charsc' = 
                    case size charsc
                     of 1 => "00" ^ charsc
                      | 2 => "0" ^ charsc
                      | _ => charsc
            in
                if 32 <= ordc andalso ordc < 128 then c :: pe cs
                else (bs1 (explode charsc')) @ (pe cs)
            end
    in
        (implode o pe o explode) s
    end

fun asString e0 =
    let
        fun indent 0 = ""
          | indent i = indent (i-1) ^ (if i mod 2 = 0 then "| " else "  ")

        fun opname A.PlusOp = "PlusOp"
          | opname A.MinusOp = "MinusOp"
          | opname A.TimesOp = "TimesOp"
          | opname A.DivideOp = "DivideOp"
          | opname A.EqOp = "EqOp"
          | opname A.NeqOp = "NeqOp"
          | opname A.LtOp = "LtOp"
          | opname A.LeOp = "LeOp"
          | opname A.GtOp = "GtOp"
          | opname A.GeOp = "GeOp"

        fun dolist d f [a] = "\n" ^ f (a, d+1)
          | dolist d f (a::r) = "\n" ^ f (a, d+1) ^ 
                                "," ^ dolist d f r
          | dolist d f nil = ""

        fun var (A.SimpleVar (s, p), d) =
            indent d ^
            "SimpleVar(" ^
	    S.name s ^
            ")"
          | var (A.FieldVar (v, s, p), d) =
            indent d ^
            "FieldVar(\n" ^
	    var (v, d+1) ^
            ",\n" ^
	    indent (d+1) ^
            S.name s ^
            ")"
          | var (A.SubscriptVar (v, e, p), d) =
            indent d ^
            "SubscriptVar(\n" ^
	    var (v, d+1) ^
            ",\n" ^
	    exp (e, d+1) ^
            ")"
        and exp (A.VarExp v, d) =
            indent d ^
            "VarExp(\n" ^
            var (v, d+1) ^
            ")"
          | exp (A.NilExp, d) =
            indent d ^
            "NilExp"
          | exp (A.IntExp i, d) =
            indent d ^
            "IntExp(" ^
            i2s i ^
	    ")"
          | exp (A.StringExp (s, p), d) =
            indent d ^
            "StringExp(\"" ^
	    printEncode s ^
            "\")"
          | exp (A.CallExp {func, args, pos}, d) =
            indent d ^
            "CallExp(" ^
            S.name func ^
	    ",[" ^
            dolist d exp (map #1 args) ^
            "])"
          | exp (A.OpExp {left, oper, right, pos}, d) =
            indent d ^
            "OpExp(" ^
            opname oper ^
            ",\n" ^
	    exp (left, d+1) ^
            ",\n" ^
            exp (right, d+1) ^
            ")"
          | exp (A.RecordExp {fields, typ, pos}, d) =
	    let fun f ((name, e, pos), d) =
		    indent d ^
                    "(" ^
                    S.name name ^
		    ",\n" ^
                    exp (e, d+1) ^
		    ")"
	    in indent d ^
               "RecordExp(" ^
               S.name typ ^
               ",[" ^
               dolist d f fields ^
               "])"
	    end
          | exp (A.SeqExp l, d) =
            indent d ^
            "SeqExp[" ^
            dolist d exp (map #1 l) ^
	    "]"
          | exp (A.AssignExp {var = v, exp = e, pos}, d) =
	    indent d ^
            "AssignExp(\n" ^
            var (v, d+1) ^
            ",\n" ^
	    exp (e, d+1) ^
            ")"
          | exp (A.IfExp {test, thn, els, pos}, d) =
	    indent d ^
            "IfExp(\n" ^
            exp (test, d+1) ^
            ",\n" ^
	    exp (thn, d+1) ^
	    (case els of NONE => ""
		       | SOME e => ",\n" ^ exp (e, d+1)) ^
	    ")"
          | exp (A.WhileExp {test, body, pos}, d) =
	    indent d ^
            "WhileExp(\n" ^
            exp (test, d+1) ^
            ",\n" ^
	    exp (body, d+1) ^
            ")"
          | exp (A.ForExp {var = v, escape = b, lo, hi, body, pos}, d) =
	    indent d ^
            "ForExp(" ^
	    S.name v ^
            "," ^
            Bool.toString (!b) ^
            ",\n" ^
	    exp (lo, d+1) ^
            ",\n" ^
            exp (hi, d+1) ^
            ",\n" ^
	    exp (body, d+1) ^
            ")"
          | exp (A.BreakExp p, d) =
            indent d ^
            "BreakExp"
          | exp (A.LetExp {decls, body, pos}, d) =
	    indent d ^
            "LetExp([" ^
	    dolist d dec decls ^
            "],\n" ^
            exp (body, d+1) ^
            ")"
          | exp (A.ArrayExp {typ, size, init, pos}, d) =
	    indent d ^
            "ArrayExp(" ^
            S.name typ ^
            ",\n" ^
	    exp (size, d+1) ^
            ",\n" ^
            exp (init, d+1) ^
            ")"

        and dec (A.FunctionDec l, d) =
	    let fun field ({ name: S.symbol
                           , escape: bool ref
                           , typ: (S.symbol * A.pos)
                           , pos: A.pos}, d) =
		    indent d ^
                    "(" ^
                    S.name name ^
		    "," ^
                    Bool.toString (!escape) ^
		    "," ^
                    S.name (#1 typ) ^
                    ")"
		fun f ({ name: S.symbol
                       , params: A.fielddata list
                       , result: (S.symbol * A.pos) option
                       , body: A.exp
                       , pos: A.pos}, d) =
		    indent d ^
                    "(" ^
                    S.name name ^
                    ",[" ^
		    dolist d field params ^
                    "],\n" ^
                    indent (d+1) ^
                    (case result of
                         NONE => "NONE"
		       | SOME (s, _) => "SOME(" ^ S.name s ^ ")") ^
                    ",\n" ^
                    exp (body, d+1) ^
                    ")"
	    in indent d ^
               "FunctionDec[" ^
               dolist d f l ^
               "]"
	    end
          | dec (A.VarDec {name, escape, typ, init, pos}, d) =
	    indent d ^
            "VarDec(" ^
            S.name name ^
            "," ^
	    Bool.toString (!escape) ^
            "," ^
            (case typ of 
                 NONE => "NONE" 
	       | SOME (s, p) => "SOME(" ^ S.name s ^ ")") ^
            ",\n" ^
            exp (init, d+1) ^
            ")"
          | dec (A.TypeDec l, d) =
	    let fun tdec ({name, ty = t, pos}, d) =
                    indent d ^
                    "(" ^
		    S.name name ^
                    ",\n" ^
		    ty (t, d+1) ^
                    ")"
	    in indent d ^
               "TypeDec[" ^
               dolist d tdec l ^
               "]"
            end
            
        and ty (A.NameTy (s, p), d) =
            indent d ^
            "NameTy(" ^
            S.name s ^
	    ")"
          | ty (A.RecordTy l, d) =
	    let fun f ({ name: S.symbol
                       , escape: bool ref
                       , typ: (S.symbol * A.pos)
                       , pos: A.pos}, d) =
		    indent d ^
                    "(" ^
                    S.name name ^
		    "," ^
                    Bool.toString (!escape) ^
                    "," ^
		    S.name (# 1 typ) ^
                    ")"
	    in indent d ^
               "RecordTy[" ^
               dolist d f l ^
               "]"
	    end
          | ty (A.ArrayTy (s, p), d) =
            indent d ^
            "ArrayTy(" ^
            S.name s ^
	    ")"

    in  exp (e0, 0) ^
        "\n"
    end

fun print (outstream, e0) =
    ( TextIO.output (outstream, asString e0)
    ; TextIO.flushOut outstream)

end (* PrintAbsyn *)

