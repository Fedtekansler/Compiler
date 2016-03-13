structure Main =
struct

structure S = Symbol

fun parse infile =
    let
        val absyn = Parse.parse infile
    in
        if !ErrorMsg.anyErrors
        then OS.Process.exit 1
        else absyn
    end

fun exportedFn (self, [infile]) =
    (print (PrintAbsyn.asString (parse infile) ^ "\n"); 0)
  | exportedFn (self, _) =
    (print "Expects arguments <infile>"; ~1)

end (* Main *)