structure Main =
struct

structure PT = PrintTypes

fun compile infile =
    let
        val absyn = Parse.parse infile
        val ty = Semant.transProg absyn
    in
        if !ErrorMsg.anyErrors then OS.Process.exit 1
        else ty
    end

fun printExpTy ty = print (PT.asString ty ^ "\n")

fun exportedFn (self, [infile]) = (printExpTy (compile infile); 0)
  | exportedFn (self, _) = 
    (print "Expects argument <infile>"; ~1)

end (* Main *)

