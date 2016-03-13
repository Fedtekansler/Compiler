signature CODEGEN =
sig
    structure Frame: FRAME
    val codegen: Frame.frame -> Tree.stm -> Assem.instr list
end

structure X86Gen: CODEGEN =
struct

structure Frame: FRAME = X86Frame
structure S = Symbol
structure T = Tree
structure Tm = Temp
structure A = Assem
structure F = Frame
structure PT = PrintTree(F)

exception TODO

fun int i =
    if i >= 0
    then Int.toString i
    else "-" ^ Int.toString (~i)

fun intNeg i =
    if i >= 0
    then "-" ^ Int.toString i
    else Int.toString (~i)

fun codegen frame stm =
    let
        val ilist = ref (nil: A.instr list)

        fun emit x = (ilist := x :: (!ilist))

        fun result gen =
            let val t = Tm.newtemp ()
            in  gen t; t
            end

        fun operator2jump oper =
            case oper of
                T.EQ => "je"
              | T.NE => "jne"
              | T.LT => "jl"
              | T.GT => "jg"
              | T.LE => "jle"
              | T.GE => "jge"
              | _ => "bad branch operator!"

        fun moveInstr s d doc = A.MOVE { assem = "\tmovl `s0, `d0"
                                       , src = s
                                       , dst = d
                                       , doc = "x86gen:" ^ doc}

        fun adjustSP count = A.OPER { assem = "\taddl $" ^ int count ^ ", `d0"
                                    , src = [F.SP] (* old-SP used *)
                                    , dst = [F.SP]
                                    , jump = NONE
                                    , doc = "x86gen:60"}

        fun allocArgs count = adjustSP (~F.wordSize*count)
        fun freeArgs count = adjustSP (F.wordSize*count)

        fun munchStm (T.SEQ (a, b)) = (munchStm a; munchStm b)

          (* MOVE *)
          | munchStm (T.MOVE (T.TEMP t, T.CALL (T.NAME l, args))) =
            ( emit (A.OPER { assem = "\tcall " ^ S.name l
                           , src = munchArgs args
                           , dst = F.calldefs
                           , jump = NONE
                           , doc = "x86gen:73"})
            ; emit (freeArgs (length args))
            ; emit (moveInstr F.EAX t "75"))

          | munchStm (T.MOVE (T.MEM e1, T.CALL (T.NAME l, args))) =
            let 
                val t = Tm.newtemp()
            in  
                emit (A.OPER { assem = "\tcall " ^ S.name l
                             , src = munchArgs args
                             , dst = F.calldefs
                             , jump = NONE
                             , doc = "x86gen:85"})
              ; emit (freeArgs (length args))
	      ; emit (moveInstr F.EAX t "87")
	      ; emit (moveInstr t (munchExp e1) "88")
            end

          | munchStm (T.MOVE (T.MEM (T.BINOP (T.PLUS, e1, T.CONST i)), e2)) =
	    let
		val t1 = (munchExp e1)
		val t2 = (munchExp e2)
	    in
		( emit (moveInstr t1 F.EBX "96")
		; emit (moveInstr t2 F.ECX "97")
		; emit (A.OPER { assem = "\tmovl `s0, " ^ int i ^ " (`d0)"
			       , src = [F.ECX]
			       , dst = [F.EBX]
			       , jump = NONE
			       , doc = "x86gen:102"}))
	    end

          | munchStm (T.MOVE (T.MEM (T.BINOP (T.PLUS, T.CONST i, e1)), e2)) =
	    let
		val t1 = (munchExp e1)
		val t2 = (munchExp e2)
	    in
		( emit (moveInstr t1 F.EBX "110")
		; emit (moveInstr t2 F.ECX "111")
		; emit (A.OPER { assem = "\tmovl `s0, " ^ int i ^ " (`d0)"
			       , src = [F.ECX]
			       , dst = [F.EBX]
			       , jump = NONE
			       , doc = "x86gen:116"}))
	    end

          | munchStm (T.MOVE (T.MEM (T.CONST i), e2)) =
		emit (A.OPER {assem = "\tmovl `s0, (" ^ int i ^ ")"
			     , src = [(munchExp e2)]
			     , dst = []
			     , jump = NONE
			     , doc = "x86gen:124"})

          | munchStm (T.MOVE (T.MEM e1, e2)) =
		(  emit (moveInstr (munchExp e1) F.EBX "127")
		 ; emit (moveInstr (munchExp e2) F.ECX "128")
		 ; emit (A.OPER {assem = "\tmovl `s0, (`d0)"
				, src = [F.ECX]
				, dst = [F.EBX]
				, jump = NONE
				, doc = "x86gen:133"}))


          | munchStm (T.MOVE (T.TEMP i, e2)) =
	    emit (moveInstr (munchExp e2) i "137")

          | munchStm (T.LABEL lab) =
	    emit (A.LABEL { assem = S.name lab ^ ":"
			  , lab = lab
			  , doc = "x86gen:142"})

          (* JUMP *)
          | munchStm (T.CJUMP (oper, T.CONST i, e2, lab1, lab2)) =
	    let
		  val t1 = Tm.newtemp()
		  val t2 = Tm.newtemp()
	    in
		  ( emit (A.OPER { assem = "\tmovl $" ^ int i ^ ", `d0"  
				 , src = []
				 , dst = [t2]
				 , jump = NONE
				 , doc = "x86gen:143"})
		  ; emit (moveInstr (munchExp e2) t1 "144")
		  ; emit (A.OPER { assem = "\tcmpl `s0, `s1"  
				 , src = [t1, t2]
				 , dst = [F.EAX]
				 , jump = NONE
				 , doc = "x86gen:149"})
		  ; emit (A.OPER { assem = "\t" ^ operator2jump oper ^ " `j0 \n" ^
					   "\tjmp `j1"
				 , src = []
				 , dst = []
				 , jump = SOME [lab1, lab2]
				 , doc = "x86gen:155"}))
	    end

          | munchStm (T.CJUMP (oper, e1, T.CONST i, lab1, lab2)) =
	    let
		  val t1 = Tm.newtemp()
	    in
		  (emit (moveInstr (munchExp e1) t1 "158")
		  ; emit (A.OPER { assem = "\tcmpl $" ^ int i ^ ", `s0"  
				 , src = [t1]
				 , dst = [F.EAX]
				 , jump = NONE
				 , doc = "x86gen:163"})
		  ; emit (A.OPER { assem = "\t" ^ operator2jump oper ^ " `j0 \n" ^
					   "\tjmp `j1"
				 , src = []
				 , dst = []
				 , jump = SOME [lab1, lab2]
				 , doc = "x86gen:166"}))
	    end


          | munchStm (T.CJUMP (oper, e1, e2, lab1, lab2)) =
	    let
		  val t1 = Tm.newtemp()
		  val t2 = Tm.newtemp()
	    in
		  (emit (moveInstr (munchExp e1) t1 "169")
		  ; emit (moveInstr (munchExp e2) t2 "170")
		  ; emit (A.OPER { assem = "\tcmpl `s0, `s1"  
				 , src = [t2, t1]
				 , dst = [F.EAX]
				 , jump = NONE
				 , doc = "x86gen:175"})
		  ; emit (A.OPER { assem = "\t" ^ (operator2jump oper) ^ " `j0 \n" ^
					   "\tjmp `j1"
				 , src = []
				 , dst = []
				 , jump = SOME [lab1, lab2]
				 , doc = "x86gen:181"}))
	    end

          | munchStm (T.JUMP (T.NAME lab, llst)) =
	    emit (A.OPER { assem = "\tjmp " ^ S.name lab
			 , src = []
                         , dst = []
                         , jump = SOME llst
                         , doc = "x86gen:188"})

          (* EXP *)
          | munchStm (T.EXP (T.CALL (T.NAME lab, args))) =
            (emit (A.OPER { assem= "\tcall " ^ S.name lab
			  , src = munchArgs args
			  , dst = F.calldefs
			  , jump = NONE
			  , doc = "x86gen:208" })
	    ; emit (freeArgs (length args)))
  
          | munchStm (T.EXP exp) =
            ((munchExp exp); ())

          (* If no match so far, complain *)
          | munchStm (T.JUMP a) =
            emit (A.OPER { assem = "\t# JUMP: bad JUMP in munchStm!"
                         , src = []
                         , dst = []
                         , jump = NONE
                         , doc = "x86gen:220"})

          | munchStm (T.MOVE a) =
            emit (A.MOVE { assem = "\t# MOVE: bad MOVE in munchStm!"
                         , src = Tm.newtemp ()
                         , dst = Tm.newtemp ()
                         , doc = "x86gen:226"})

        and munchArgs args =
            (* in the simple approach used here, we pass all args in memory *)
            let 
		  val rargs = rev args (* push args right-to-left *)
                  fun munchArgs1 [] = []
                    | munchArgs1 (ah::at) = 
		      (emit (moveInstr (munchExp ah) F.EAX "234")
		      ; (emit (A.OPER { assem = "\tpushl `s0"
				     , src = [F.EAX]
				     , dst = []
				     , jump = NONE
				     , doc = "x86gen:239"}))
		      ; munchArgs1 at)
            in  
		  munchArgs1 rargs
            end

        (* Memory access *)
        and munchExp (T.MEM (T.BINOP (T.PLUS, e, T.CONST n))) =
            result (fn r => emit (A.OPER { assem = "\tmovl " ^ int n ^
                                                   "(`s0), `d0"
                                         , src = [(munchExp e)]
                                         , dst = [r]
                                         , jump = NONE
                                         , doc = "x86gen:253"}))

          | munchExp (T.MEM (T.BINOP (T.PLUS, T.CONST n, e))) =
            result (fn r => emit (A.OPER { assem = "\tmovl " ^ int n ^
                                                   "(`s0), `d0"
                                         , src = [(munchExp e)]
                                         , dst = [r]
                                         , jump = NONE
                                         , doc = "x86gen:261"}))

          | munchExp (T.MEM (T.BINOP (T.MINUS, e, T.CONST n))) =
            result (fn r => emit (A.OPER { assem = "\tmovl " ^ intNeg n ^
						   "(`s0), `d0"
					 , src = [munchExp e]
					 , dst = [r]
					 , jump = NONE
					 , doc = "x86gen:269"}))

          | munchExp (T.MEM e) =
            result (fn r => emit (A.OPER { assem = "\tmovl (`s0), `d0"
					 , src = [munchExp e]
					 , dst = [r]
					 , jump = NONE
					 , doc = "x86gen:276"}))

          (* PLUS *)
          | munchExp (T.BINOP (T.PLUS, e1, T.CONST i)) =
            result (fn r => (emit (moveInstr (munchExp e1) r "280")
			    ; emit (A.OPER { assem = "\taddl $" ^ int i ^ ", `d0"
					   , src = [r]
					   , dst = [r]
					   , jump = NONE
					   , doc = "x86gen:285"})))

          | munchExp (T.BINOP (T.PLUS, T.CONST i, e1)) =
            result (fn r => (emit (moveInstr (munchExp e1) r "288")
			    ; emit (A.OPER { assem = "\taddl $" ^ int i ^ ", `d0"
					   , src = [r]
					   , dst = [r]
					   , jump = NONE
					   , doc = "x86gen:293"})))

          | munchExp (T.BINOP (T.PLUS, e1, e2)) =
            (* Hint, p203: use src=[r,_] and do not use `s0,
             * which specifies that r is used *)
            result (fn r => (emit(moveInstr (munchExp e1) r "298")
			    ; emit (A.OPER { assem = "\taddl `s1, `d0"
					 , src = [r, (munchExp e2)]
					 , dst = [r]
					 , jump = NONE
					 , doc = "x86gen:303"})))

          (* MINUS *)
          | munchExp (T.BINOP (T.MINUS, e1, T.CONST i)) =
            result (fn r => (emit(moveInstr (munchExp e1) r "307")
			    ; emit (A.OPER { assem = "\tsubl $" ^ int i ^ ", `d0"
					 , src = [r]
					 , dst = [r]
					 , jump = NONE
					 , doc = "x86gen:312"})))

          | munchExp (T.BINOP (T.MINUS, T.CONST 0, e1)) = 
             result (fn r => (emit(moveInstr (munchExp e1) r "315")
			    ; emit (A.OPER { assem = "\tnegl `d0"
					 , src = [r]
					 , dst = [r]
					 , jump = NONE
					 , doc = "x86gen:320"})))

          | munchExp (T.BINOP (T.MINUS, T.CONST i, e1)) =
           result (fn r => (emit(moveInstr i r "323")
			    ; emit (A.OPER { assem = "\tsubl `s1, `d0"
					 , src = [r, (munchExp e1)]
					 , dst = [r]
					 , jump = NONE
					 , doc = "x86gen:328"})))

          | munchExp (T.BINOP (T.MINUS, e1, e2)) =
            result (fn r => (emit(moveInstr (munchExp e1) r "331")
			    ; emit (A.OPER { assem = "\tsubl `s1, `d0"
					 , src = [r, (munchExp e2)]
					 , dst = [r]
					 , jump = NONE
					 , doc = "x86gen:336"})))

          (* MULTIPLY *)
          | munchExp (T.BINOP (T.MUL, e1, e2)) =
            result (fn r => 
		       let
			   val t = (munchExp e2)
		       in
			   (emit(moveInstr (munchExp e1) F.EAX "340")
			   ; emit (A.OPER { assem = "\timull `s0"
					  , src = [t]
					  , dst = [F.EDX, F.EAX]
					  , jump = NONE
					  , doc = "x86gen:345"})
			   ; emit (moveInstr F.EAX r "346"))
		       end)

          (* DIVIDE *)
          | munchExp (T.BINOP (T.DIV, e1, e2)) =
            (* Hint from
             * http://www.cs.mun.ca/~rod/winter2004/cs3724/notes/asm.html:
             *
             * "To divide x by y, we first convert it into 64-bits, and
             * them use idivl.
             *
             *  movl  x, %eax
             *  cltd
             *  idivl y
             *
             * The quotient is in %eax, and the remainder is in %edx."
             *)
            result (fn r => (emit (moveInstr (munchExp e1) F.EAX "362")
			    ; emit (A.OPER { assem = "\tcltd"
					   , src = [F.EAX]
					   , dst = [F.EDX, F.EAX]
					   , jump = NONE
					   , doc = "x86gen:367"})
			    ; emit (A.OPER { assem = "\tidivl `s0"
					   , src = [(munchExp e2), F.EDX, F.EAX]
					   , dst = [F.EDX, F.EAX]
					   , jump = NONE
					   , doc = "x86gen:372"})
			    ; emit (moveInstr F.EAX r "373")))

          (* AND *)
          | munchExp (T.BINOP (T.AND, e1, T.CONST i)) = 
            result (fn r => 
		       (emit (moveInstr (munchExp e1) r "378")
		       ; emit (A.OPER { assem = "\tandl $" ^ int i ^ ", `d0"
				      , src = [r]
				      , dst = [r]
				      , jump = NONE
				      , doc = "x86gen:383"})))
		   
          | munchExp (T.BINOP (T.AND, T.CONST i, e1)) =
            result (fn r => 
		       (emit (moveInstr (munchExp e1) r "387")
		       ; emit (A.OPER { assem = "\tandl $" ^ int i ^ ", `d0"
				      , src = [r]
				      , dst = [r]
				      , jump = NONE
				      , doc = "x86gen:392"})))
		   
          | munchExp (T.BINOP (T.AND, e1, e2)) =
            result (fn r => 
		       (emit (moveInstr (munchExp e2) r "396")
		       ; emit (A.OPER { assem = "\tandl `s0, `d0"
				      , src = [(munchExp e1)]
				      , dst = [r]
				      , jump = NONE
				      , doc = "x86gen:401"})))

          (* OR *)
          | munchExp (T.BINOP (T.OR, e1, T.CONST i)) =
            result (fn r => 
		       (emit (moveInstr (munchExp e1) r "346")
		       ; emit (A.OPER { assem = "\torl $" ^ int i ^ ", `d0"
				      , src = [r]
				      , dst = [r]
				      , jump = NONE
				      , doc = "x86gen:411"})))

          | munchExp (T.BINOP (T.OR, T.CONST i, e1)) =
            result (fn r => 
		       (emit (moveInstr (munchExp e1) r "415")
		       ; emit (A.OPER { assem = "\torl $" ^ int i ^ ", `d0"
				      , src = [r]
				      , dst = [r]
				      , jump = NONE
				      , doc = "x86gen:420"})))

          | munchExp (T.BINOP (T.OR, e1, e2)) =
            result (fn r => 
		       (emit (moveInstr (munchExp e2) r "424")
		       ; emit (A.OPER { assem = "\torl `s0, `d0"
				      , src = [(munchExp e1)]
				      , dst = [r]
				      , jump = NONE
				      , doc = "x86gen:429"})))

          (* Other constructs *)
          | munchExp (T.TEMP t) = t

          | munchExp (T.ESEQ (s, e)) = 
	    ((munchStm s)
	    ; (munchExp e))

          | munchExp (T.NAME label) =
            result (fn r => emit (A.OPER { assem = "\tmovl $" ^ (S.name label) ^ ", `d0"
					  , src = []
					  , dst = [r]
					  , jump = NONE
					  , doc = "x86gen:431"}))

          | munchExp (T.CONST n) =
            result (fn r => emit (A.OPER { assem = "\tmovl $" ^ int n ^ ", `d0"
					 , src = []
					 , dst = [r]
					 , jump = NONE
					 , doc = "x86gen:438"}))

          (* If no match so far, complain *)
          | munchExp (tr as T.CALL (_, _)) =
            ( TextIO.output (TextIO.stdErr, "\nBUG: bad CALL in munchExp:\n")
            ; PT.printExp (TextIO.stdErr, tr)
            ; TextIO.flushOut TextIO.stdErr
            ; result (fn _ => emit (A.OPER { assem = "\t# bad CALL!"
                                           , src = []
                                           , dst = []
                                           , jump = NONE
                                           , doc = "x86gen:459"})))

          | munchExp (tr as T.BINOP (_, _, _)) =
            ( TextIO.output (TextIO.stdErr, "\nBUG: bad BINOP in munchExp:\n")
            ; PT.printExp (TextIO.stdErr, tr)
            ; TextIO.flushOut TextIO.stdErr
            ; result (fn _ => emit (A.OPER { assem = "\t# bad BINOP!"
                                           , src = []
                                           , dst = []
                                           , jump = NONE
                                           , doc = "x86gen:469"})))
    in
        munchStm stm;
        rev (!ilist)
    end

end (* X86Gen *)

