structure Main =
struct

structure Tr = Translate
structure Te = Temp
structure F = X86Frame
structure S = Symbol
structure PT = PrintTree(F)

fun emitproc out frag = TextIO.output (out, PT.asStringFrag frag ^ "\n")

fun withOpenFile fname f =
    let
        val out = TextIO.openOut fname
    in
        (f out before TextIO.closeOut out)
    end

fun compile (infile, outfile) =
    let
        val absyn = Parse.parse infile
        val frags = Semant.transProg absyn
        fun emitprocs out = app (emitproc out) frags
    in
        if !ErrorMsg.anyErrors then OS.Process.exit 1
        else withOpenFile outfile emitprocs
    end

fun exportedFn (self, [infile,outfile]) = (compile (infile,outfile); 0)
  | exportedFn (self, _) = (print "Expects arguments <infile> <outfile>"; ~1)

end (* Main *)
