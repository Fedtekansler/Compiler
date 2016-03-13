structure Main =
struct

structure Tr = Translate
structure Te = Temp
structure F = X86Frame
structure G = X86Gen
structure C = Canon
structure S = Symbol
structure A = Assem
structure PT = PrintTree(F)

fun emitproc out (F.PROC {body, frame}) =
    let
        val fname = S.name (F.name frame)
	val stms = C.linearize body
        val stms' = C.traceSchedule (C.basicBlocks stms)
	val instrs = List.concat (map (G.codegen frame) stms')
        val instrs' = F.procEntryExit2 (frame, instrs)
        val {prolog, epilog, body=instrs''} = F.procEntryExit3 (frame, instrs')
        val format = A.format F.asStringReg
    in
        TextIO.output (out, "\n" ^ prolog);
        app (fn i => TextIO.output (out, format i)) instrs'';
        TextIO.output (out, epilog ^ "\n")
    end

  | emitproc out (F.STRING (lab, s)) =
    TextIO.output (out, F.string (Te.namedLabel (Symbol.name lab), s))

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

