signature SEMANT =
sig
  val transProg: Absyn.exp -> Translate.frag list
end

structure Semant :> SEMANT =
struct

structure S = Symbol
structure A = Absyn
structure E = Env
structure Ty = Types
structure Tr = Translate
structure PT = PrintTypes

exception TODO (* TODO: replace 'raise TODO' with suitable code *)

val err = ErrorMsg.error
val breakLevel = ref 0
val breakable = ref false

fun lookupTy (tenv, sym, pos) =
    let
        val tyOpt = S.look (tenv, sym)
    in
        (case tyOpt of 
	     SOME (typ) => typ
	   | NONE => ((err pos ("Declared type doesn't exist in type environment: " ^
				(S.name(sym)))); Ty.ERROR))  
    end

(* NB: Some function names adjusted to use CamelCase more consistently.
 * For example: 'actual_ty' was renamed to 'actualTy' *)

fun actualTy (Ty.NAME (s, ty)) pos =
    (case !ty of 
	 SOME (Ty.NAME (s2, ty2)) => actualTy (Ty.NAME (s2, ty2)) pos
       | SOME (t) => t
       | NONE => ((err pos ("no type defined in Ty.NAME: " ^ S.name(s)));
		  Ty.NAME(s, ty))) 
  | actualTy t _ = t

fun isRecordType (Ty.RECORD _) = true
  | isRecordType _ = false

fun checkInt (ty, pos, msg) =
    case ty of
        Ty.INT => ()
      | _ => err pos ("INT required" ^ msg ^ ", " ^
                      PT.asString ty ^ " provided")

fun checkUnit (ty, pos, msg) =
    case ty of
	Ty.UNIT => ()
      | _  => err pos ("UNIT required " ^ msg ^ ", " ^
                       PT.asString ty ^ " provided")

(*fun checkAssignable (declared: Ty.ty, assigned: Ty.ty, pos, msg) =
    let
        val aDeclared = actualTy declared pos
        val aAssigned = actualTy assigned pos
    in
        raise DOTO
    end
*)

fun toggleBreakable boolean =
    breakable := boolean

fun recordTy (tenv, []) = []
  | recordTy (tenv, ({name, escape, typ = (s, p), pos} :: records)) = 
    ((name, lookupTy(tenv, s, p)) :: recordTy (tenv, records))

fun transTy (tenv, t) = 
    (case t of
	 A.RecordTy (fd) => Ty.RECORD (recordTy (tenv, fd), ref ())
       | A.ArrayTy (sym, pos) => Ty.ARRAY (lookupTy(tenv, sym, pos), ref ())
       | A.NameTy (sym, pos) => lookupTy(tenv, sym, pos)
    ) 

fun transExp (venv, tenv, level) =
    let
        fun trexp (A.NilExp) _ =
            {exp = Tr.nil2IR (), ty = Ty.NIL}
		
          | trexp (A.VarExp var) break =
            trvar var false break
		  
          | trexp (A.IntExp i) _ =
            {exp = Tr.int2IR i, ty = Ty.INT}
		
          | trexp (A.StringExp (str, pos)) _ =
            {exp = Tr.string2IR str, ty = Ty.STRING}
		
          | trexp (A.OpExp {left, oper, right, pos}) break =
 	    let 
		val {exp=leftExp, ty=leftty} = trexp left break
		val {exp=rightExp, ty=rightty} = trexp right break
	    in
		(case (leftty, oper, rightty) of 
		     (Ty.INT, _, Ty.INT) => 
		     {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.STRING, A.EqOp, Ty.STRING) => 
		     {exp=(Tr.stringOp2IR(oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.STRING, A.NeqOp, Ty.STRING) => 
		     {exp=(Tr.stringOp2IR(oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.STRING, A.LtOp, Ty.STRING) => 
		     {exp=(Tr.stringOp2IR(oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.STRING, A.LeOp, Ty.STRING) => 
		     {exp=(Tr.stringOp2IR(oper, leftExp, rightExp)), ty=Ty.INT} 
		   | (Ty.STRING, A.GtOp, Ty.STRING) => 
		     {exp=(Tr.stringOp2IR(oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.STRING, A.GeOp, Ty.STRING) => 
		     {exp=(Tr.stringOp2IR(oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.NIL, A.EqOp, Ty.NIL)  => 
		     {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.NIL, A.NeqOp, Ty.NIL)  => 
		     {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.RECORD (_, _), A.EqOp, Ty.NIL)  => 
		     {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.RECORD (_, _), A.NeqOp, Ty.NIL)  => 
		     {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.NIL, A.EqOp, Ty.RECORD(_,_))  => 
		     {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.NIL, A.NeqOp, Ty.RECORD(_,_))  => 
		     {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		   | (Ty.ARRAY (ty1, _), A.EqOp, Ty.ARRAY (ty2, _)) => 
		     if ty1 = ty2
		     then {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		     else ((err pos ("Comparison of incompatible array types: " ^ 
				     PT.asString ty1 ^ ", " ^ PT.asString ty2)); 
			   {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT})

		   | (Ty.ARRAY (ty1, _), A.NeqOp, Ty.ARRAY (ty2, _)) =>		   
		     if ty1 = ty2
		     then {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT}
		     else ((err pos ("Comparison of incompatible array types: " ^ 
				     PT.asString ty1 ^ ", " ^ PT.asString ty2)); 
			   {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT})

		   | (Ty.RECORD (sytys1, _), A.EqOp, Ty.RECORD (sytys2, _)) =>		
		     let
			 fun symSort ((sym1, ty1) , (sym2, ty2)) =
			     S.name(sym1) > S.name(sym2)
			 val sorted1 = ListMergeSort.sort symSort sytys1
			 val sorted2 = ListMergeSort.sort symSort sytys2
		     in
			 if sorted1 = sorted2
			 then {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty = Ty.INT}
			 else ((err pos ("Comparison of incompatible record types: " ^ 
					 PT.asString leftty ^ ", " ^ PT.asString rightty)); 
			       {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT})
		     end

		   | (Ty.RECORD (sytys1, _), A.NeqOp, Ty.RECORD (sytys2, _)) =>		
		     let
			 fun symSort ((sym1, ty1) , (sym2, ty2)) =
			     S.name(sym1) > S.name(sym2)
			 val sorted1 = ListMergeSort.sort symSort sytys1
			 val sorted2 = ListMergeSort.sort symSort sytys2
		     in
			 if sorted1 = sorted2
			 then {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty = Ty.INT}
			 else ((err pos ("Comparison of incompatible record types: " ^ 
					 PT.asString leftty ^ ", " ^ PT.asString rightty)); 
			       {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT})
		     end

		   |  (_, _, _) => ((err pos ("Operator used on incompatible types: " ^ 
					      PT.asString leftty ^ ", " ^ PT.asString rightty)); 
				    {exp=(Tr.intOp2IR (oper, leftExp, rightExp)), ty=Ty.INT})
		)
	    end
	  (* NB: many cases here! *)
		
          | trexp (A.CallExp {func, args, pos}) break =
	    let
		val funct = S.look(venv, func)
		fun transargs (exp, pos) =
		    let val {exp, ty} = (trexp exp break)
		    in actualTy ty pos
		    end
		fun transexps (exp, pos) =
		    let val {exp, ty} = (trexp exp break)
		    in exp
		    end
		val args' = map transargs args
		val exps = map transexps args
		fun compareArgs ([], []) = ()
		  | compareArgs ((arg :: args),(formal :: formals)) = 
		    ((if arg = formal
		      then ()
		      else (err pos ("Actual parameter type differs from formal parameter type, expected: " 
				     ^ PT.asString arg ^ ", received: " ^ PT.asString formal)));
		     compareArgs (args, formals))

		  | compareArgs ([], (formal :: formals)) =
		    (err pos ("Argument lists are of different lengths")) 

		  | compareArgs ((arg :: args), []) =
		    (err pos ("Argument lists are of different lengths")) 
		val fromLevel = level
	    in
		(case funct of
		     SOME (E.FunEntry ({formals, result, label, level = toLevel})) => 
		     let
			 fun typSort (ty1, ty2) =
			     PT.asString(ty1) > PT.asString(ty2)
			 fun actualTys [] = []
			   | actualTys (ty :: tys) =
			     ((actualTy ty pos) :: (actualTys tys))
			 val args'' = actualTys args'
			 val formals' = actualTys formals
			 val sortedArgs' = ListMergeSort.sort typSort args''
			 val sortedFormals = ListMergeSort.sort typSort formals'
		     in
			 compareArgs (sortedArgs', sortedFormals); 
			 {exp=(Tr.funCall2IR (toLevel, fromLevel, label, exps)), ty = result}
		     end
		  |  _ => 
		     ((err pos ("Function doesn't exist: " ^ S.name(func))); 
		      {exp=(Tr.nil2IR()), ty=Ty.ERROR}) 
		)
	    end

          | trexp (A.IfExp {test, thn, els, pos}) break =
	    let
		val {exp=testExp, ty=testTy} = (trexp test break)		
		val {exp=thnExp, ty=thnTy} = (trexp thn break)
	    in
		checkInt(testTy, pos, "when checking 'test' in if expression");
		(case els of
		     SOME(elsExp) =>
		     let
			 val {exp=elseExp, ty=elsTy} = (trexp elsExp break)
		     in
			 if thnTy = elsTy
			 then {exp=(Tr.ifThenElse2IR(testExp, thnExp, elseExp)), ty=thnTy}
			 else  (case (thnTy, elsTy) of
				    (Ty.NIL, Ty.RECORD(_,_)) => 
				    {exp=(Tr.ifThenElse2IR(testExp, thnExp, elseExp)), ty=elsTy}
				  | (Ty.RECORD(_,_), Ty.NIL) => 
				    {exp=(Tr.ifThenElse2IR(testExp, thnExp, elseExp)), ty=thnTy}
				  | _ => 
				    ((err pos ("'thnTy' and 'elsTy' has different types. thnTy: " ^
					       PT.asString thnTy ^ ", elsTy: " ^ PT.asString elsTy));
				     {exp=(Tr.ifThenElse2IR(testExp, thnExp, elseExp)), ty=Ty.ERROR})
			       )
		     end
		   | NONE => 
		     ((checkUnit(thnTy, pos, "when checking 'thnTy' in if expression"));		   
		      {exp=(Tr.ifThen2IR (testExp, thnExp)), ty=Ty.UNIT}))	
	    end
	  | trexp (A.WhileExp {test, body, pos}) break =
	    let 
		val {exp = testExp, ty = testTy} = (trexp test break)
		val _ = (toggleBreakable(true))
		val _ = (breakLevel := !breakLevel + 1)
		val {exp = bodyExp, ty = bodyTy} = (trexp body break)
		val _ = (if !breakLevel > 0 then ((breakLevel := !breakLevel - 1); toggleBreakable(false)) else ())
		val breakingPoint = Tr.newBreakPoint("")
	    in 
		checkInt(testTy, pos, "in 'test' in while expression");
		checkUnit(bodyTy, pos, "in 'body' in while expression");
		{exp=(Tr.while2IR(testExp, bodyExp, breakingPoint)), ty=Ty.UNIT}
	    end

	  (* using Tr.newBreakPoint, Tr.while2IR *)

          | trexp (aexp as A.RecordExp {fields, typ, pos}) break =
	    let
		val typId = actualTy (lookupTy(tenv, typ, pos)) pos
		fun transfields (sym, exp, pos) = 
		    let  val {exp, ty} = (trexp exp break)
		    in (sym, (actualTy ty pos))
		    end
		fun transexps (sym, exp, pos) = 
		    let val {exp, ty} = (trexp exp break)
		    in exp
		    end
		val fields' = map transfields fields
		val expList = map transexps fields
		fun symSort ((sym1, ty1) , (sym2, ty2)) =
		    S.name(sym1) > S.name(sym2)
		fun actualSymTyp [] = []
		  | actualSymTyp ((sym, typ) :: symtyps) =
		    ((sym, actualTy typ pos) :: actualSymTyp (symtyps))
		fun nilEqualizer ([], []) = true
		  | nilEqualizer (symtyps1, []) = 
		    ((err pos ("Amount of parameters in record larger than in record type: " 
			       ^ PT.asString(typId))); 
		     false)
		  | nilEqualizer ([], symtyps2) = 
		    ((err pos ("Amount of parameters in record less than in record type: " 
			       ^ PT.asString(typId))); 
		     false)
		  | nilEqualizer (((sym1, typ1) :: symtyps1), ((sym2, typ2) :: symtyps2)) =
		    (case (typ1, typ2) of
			 (_, Ty.NIL) => nilEqualizer(symtyps1, symtyps2)
		       | (Ty.NIL, _) => nilEqualizer(symtyps1, symtyps2)
		       | (Ty.ARRAY(arrTy1, _), Ty.ARRAY(arrTy2, _)) => 
			 if arrTy1 = arrTy2
			 then nilEqualizer(symtyps1, symtyps2)
			 else ((err pos ("Array types inside record fields mismatched, expected: " 
					 ^ S.name(sym2) ^ " of type " ^ PT.asString(typ2) ^ ", received: " 
					 ^ S.name(sym1) ^ " of type " ^ PT.asString(typ1))); 
			       false)
		       | (_, _) => 
			 if typ1 = typ2
			 then nilEqualizer(symtyps1, symtyps2)
			 else ((err pos ("Types inside record fields mismatched, expected: " 
					 ^ S.name(sym2) ^ " of type " ^ PT.asString(typ2) ^ ", received: " 
					 ^ S.name(sym1) ^ " of type " ^ PT.asString(typ1))); 
			       false)
		    )
	    in
		(case typId of
		     Ty.RECORD (recList, _) =>
		     let
			 val recList' = actualSymTyp recList
			 val fields'' = actualSymTyp fields'
			 val sortedFields' = ListMergeSort.sort symSort fields''
			 val sortedRecList = ListMergeSort.sort symSort recList'
		     in
			 if nilEqualizer (sortedFields', sortedRecList)
			 then {exp=(Tr.record2IR (expList)), ty=typId}
			 else ((err pos ("Record types don't match, expected: " ^
					 PT.asString (Ty.RECORD(recList', ref ())) ^ ", received: " 
					 ^ PT.asString (Ty.RECORD(fields'', ref ()))));
			       {exp=(Tr.record2IR (expList)), ty=typId})
		     end
		   | _ => ((err pos ("Expected record type, received: " 
				     ^ PT.asString typId)); {exp=(Tr.nil2IR ()), ty=Ty.ERROR})
		)
	    end
(* using Tr.record2IR, maybe Tr.nil2IR with errors *)

          | trexp (A.SeqExp []) _ =
            (* ensure there is some expression if the SeqExp is empty *) (* Hvad betyder det? *)
	    {exp=(Tr.seq2IR []), ty=Ty.UNIT}

          | trexp (A.SeqExp (aexps as ((aexp', p) :: aexps'))) break =
	    transSeq(aexps, [], break)
(* using Tr.seq2IR, Tr.eseq2IR *)

          | trexp (A.AssignExp {var, exp, pos}) break =
            let
		val {exp=varExp, ty=varTy} = trvar var false break
		val {exp=expExp, ty=expTy} = (trexp exp break)
		fun isAssignable (A.SimpleVar (id, pos)) =
		    (case S.look(venv, id) of
			 SOME (E.VarEntry {access, ty, escape, assignable}) => assignable
		       | SOME (E.FunEntry {formals, result, label, level}) => false
		       | NONE => (err pos ("undefined variable " ^ (S.name id)); false))
		  | isAssignable (A.FieldVar (var, id, pos)) =  true
		  | isAssignable (A.SubscriptVar (var, exp, pos))   = true
		val assignable = isAssignable var
	    in
		if (assignable = false) 
		then ((err pos ("variable must not be assigned to"));
		      {exp=(Tr.assign2IR(varExp, expExp)), ty=Ty.UNIT}) 
		(* Når der ikke må blive assigned til var, skal exp=() ? *)
		else		      
		    if varTy = expTy
		    then {exp=(Tr.assign2IR (varExp, expExp)), ty=Ty.UNIT}
		    else ((err pos ("Variable and expression in assign expression not equal. Var: " ^
				    PT.asString varTy ^ ", Exp: " ^ PT.asString expTy));
			  {exp=(Tr.assign2IR (varExp, expExp)), ty=Ty.UNIT})
	    end
(* using Tr.assign2IR, checkAssignable *)

          | trexp (A.ForExp {var, escape, lo, hi, body, pos}) _ =
	    let
		val _ = (toggleBreakable(true))
		val _ = (breakLevel := !breakLevel + 1)
		val newBreakPoint = Tr.newBreakPoint("")
		val access = Tr.allocLocal level true
		val venv' = S.enter(venv, var, E.VarEntry{access = access, ty=Ty.INT, escape = escape, assignable=false})
		val {exp=bodyExp, ty=bodyTy} = transExp(venv', tenv, level) body newBreakPoint
		val _ = (toggleBreakable(false))
		val {exp=loExp, ty=loTy} = trexp lo newBreakPoint
		val {exp=hiExp, ty=hiTy} = trexp hi newBreakPoint
		val _ = (if !breakLevel > 0
			 then (breakLevel := !breakLevel - 1)
			 else ())
	    in
		checkInt(loTy, pos, "when checking 'lo' in ForExp");
		checkInt(hiTy, pos, "when checking 'hi' in ForExp");
		checkUnit(bodyTy, pos, "when checking 'bodyTy' in for expression");
		{exp=(Tr.for2IR(Tr.simpleVar(access, level), newBreakPoint, loExp, hiExp, bodyExp)), ty=Ty.UNIT}
	    end

(* using Tr.newBreakPoint, Tr.allocLocal, Tr.forIR *)

          | trexp (A.BreakExp pos) break =
            if (!breakLevel) = 0 orelse (!breakable) = false
	    then ((err pos ("Break expression outside of loop")); 
		  {exp=(Tr.break2IR (break)), ty=Ty.UNIT})
	    else ((breakLevel := !breakLevel - 1); 
		  {exp=(Tr.break2IR (break)), ty=Ty.UNIT}) (* NOT DONE *)
(* using Tr.break2IR *)

          | trexp (term as A.LetExp {decls, body, pos}) break =
	    let 
		  val ({venv = venv', tenv = tenv'}, explist') = 
		      transDecs(venv,tenv,level, break, [], decls)
		  val level' = (Tr.newAnonLevel {parent = level})
		  val {exp = bodyExp, ty = bodyTy} = 
		      transExp(venv',tenv', level') body break
	    in
		  {exp = Tr.let2IR (explist', bodyExp), ty = bodyTy}
	    end
(* using transDecs, transExp, Tr.let2IR *)

          | trexp (A.ArrayExp {typ, size, init, pos}) break =
	    let
		val {exp=sizeExp, ty=sizeTy} = (trexp size break)
		val {exp=initExp, ty=initTy} = (trexp init break)
		val arrTy = (actualTy (lookupTy(tenv, typ, pos)) pos)
	    in
		checkInt(sizeTy, pos, "when checking 'size' in ArrayExp");
		(case arrTy of
		     Ty.ARRAY(typTy, _) =>
		     if (actualTy typTy pos) = (actualTy initTy pos)
		     then {exp=(Tr.array2IR (sizeExp, initExp)), ty=Ty.ARRAY(typTy, ref ())}
		     else ((err pos ("Array type and init expression type don't agree, expected: " ^
				     PT.asString(typTy) ^ ", received: " ^ PT.asString(initTy))); 
			   {exp=(Tr.array2IR (sizeExp, initExp)), ty=Ty.ERROR})
		   | _ => ((err pos ("Array not of array type but of " ^ PT.asString(arrTy) ^ " type."));
			   {exp=(Tr.array2IR (sizeExp, initExp)), ty=Ty.ERROR})
		)
	    end 

(* using Tr.array2IR *)

        (* NB: trvar must generate a tree describing the given
         * variable such that it will work for both evaluation and
         * assignment; any expression will be fine for evaluation,
         * but assignment only works with MOVE(TEMP _, _) and
         * MOVE(MEM _, _) because we can only store the new value
         * into a register or into a memory cell (error cases can
         * generate a NoOp value (Ex (CONST 0)), so they avoid
         * the problem).  This means that Tr.simpleVar, Tr.fieldVar, 
         * and Tr.subscript2IR must return an Ex (MEM _) or an 
         * Ex (TEMP _).
         *)

	and trvar (A.SimpleVar (id, pos)) mutationRequested break =
	    (case S.look(venv, id) of 
		 SOME(E.VarEntry{access, ty, escape, assignable}) => {exp = (Tr.simpleVar(access, level)), ty = (actualTy ty pos)}
	       | SOME(E.FunEntry{formals, result, label, level}) => (err pos ("undefined variable " ^ (S.name id) 
							       ^ ", declared variable is a function");
						      {exp = (Tr.nil2IR()), ty = Ty.INT})
	       | NONE => (err pos ("undefined variable " ^ (S.name id));
			  {exp = (Tr.nil2IR()), ty = Ty.INT}))
(* using Tr.simpleVar *)

          | trvar (A.FieldVar (var, id, pos)) _ break =
            (* ignore 'mutationRequested': all record fields are mutable *)
	    let
		val {exp = varExp, ty = vaTy} = trvar var true break
		val varTy = actualTy vaTy pos
		fun checkForId (id, ((sym, typ) :: sts), counter) =
		    if id = sym
		    then {exp=(Tr.fieldVar(varExp, counter)), ty = typ}
		    else checkForId(id, sts, counter+1)
		  | checkForId (id, [], counter) = ((err pos ("Id doesn't exist in record type: " ^
						     S.name(id) ^ ", in: " ^ PT.asString(varTy))); 
					   {exp=(Tr.fieldVar(varExp, counter)), ty=Ty.ERROR})
	    in
		(case varTy of
		     Ty.RECORD(symList, _) => checkForId(id, symList, 1)
		   | _ => ((err pos ("Error while checking FieldVar, expected RECORD type, received: " 
				     ^ PT.asString(varTy))); 
			   {exp=(Tr.nil2IR()), ty = Ty.ERROR})
		)
	    end

(* using Tr.fieldVar *)

          | trvar (A.SubscriptVar (var, exp, pos)) mutationRequested break =
            (* ignore 'mutationRequested': all array entries are mutable *)
            let
		val {exp=expExp, ty=exTy} = (trexp exp break)
		val {exp=varExp, ty=vaTy} = trvar var true break
		val varTy = actualTy vaTy pos
		val expTy = actualTy exTy pos
	    in
		checkInt(expTy, pos, "when checking 'expTy' in subscript");
		(case varTy of
		     Ty.ARRAY(arrTy, _) => {exp=(Tr.subscript2IR(varExp, expExp)), ty = arrTy}
		   | _ => ((err pos ("Expected array type, received: " ^PT.asString varTy));
			   {exp=(Tr.subscript2IR(varExp, expExp)), ty = Ty.ERROR}))
	    end
(* using Tr.subscript2IR *)
	  
	and transSeq (((aexp', p) :: aexps'), l, break) =
	    (case aexps' of
		 [] =>
		 let
		       val {exp, ty} = (trexp aexp' break)
		       val res = List.rev(exp :: l)
		 in
		       if ty = Ty.UNIT
		       then {exp = Tr.seq2IR (res), ty = ty}
		       else {exp = Tr.eseq2IR (res), ty = ty}
		 end
	       | _ => 
		 let
		       val {exp, ty} = (trexp aexp' break)
		       val res = (exp :: l)
		 in
		       transSeq(aexps', res, break)
		 end
	    )
	  | transSeq ([], l, break) = 
	    {exp=(Tr.seq2IR []), ty=Ty.UNIT}
    in
          trexp
    end



and transDec ( venv                     (* environment var -> type *)
             , tenv                     (* environment tyname -> type *)
             , level                    (* frame of enclosing function *)
             , break                    (* jump to this label on 'break' *)
             , explist                  (* accumulate decl elaboration code *)
             , A.VarDec { name, escape, typ = NONE, init, pos}) (* AST of declaration to translate *)  = 
    let
    (* TODO: create venv': venv extended with the new variable
     * and explist': explist extended with its init code; 
     * will use Tr.allocLocal, Tr.assign2IR, Tr.simpleVar *)
	val {exp = initExp, ty = initTy} = transExp(venv, tenv, level) init break
	val access = Tr.allocLocal level true
	val simpleVar = Tr.simpleVar(access, level)
	val assignExp = Tr.assign2IR(simpleVar, initExp)
	val venv' = S.enter(venv, name, E.VarEntry{access=access, ty=initTy, escape=escape, assignable=true})
    in
	(if initTy = Ty.NIL
	 then (err pos "Variable initialized by nil expression")
	 else ());
        ( {tenv = tenv, venv = venv'}
        , (assignExp :: explist))
    end


  | transDec (venv, tenv, level, break, explist, A.VarDec { name, escape, typ = SOME (s, pos), init, pos = pos1}) =
    let 
	val {exp=initExp, ty} = transExp(venv, tenv, level) init break
	val access = Tr.allocLocal level true
	val simpleVar = Tr.simpleVar(access, level)
	val assignExp = Tr.assign2IR(simpleVar, initExp)
	val eTy = (actualTy ty pos)
	val sTy = (actualTy (lookupTy(tenv, s, pos)) pos)
	val venv' = S.enter(venv, name, E.VarEntry{access=access, ty=eTy, escape=escape, assignable=true})
    in 
	(case (sTy, eTy) of 
	     (Ty.RECORD(_,_), Ty.NIL) => 
	     ({tenv = tenv, venv = venv'}, (assignExp :: explist))
	   | (Ty.ARRAY (ty1, u1), Ty.ARRAY (ty2, u2)) => 		   
	     if ty1 = ty2
	     then ({tenv = tenv, venv = venv'}, (assignExp :: explist))
	     else ((err pos ("Constraint type and expression type mismatch: " ^ 
			     "different array types, expected: " ^ PT.asString sTy ^ 
			     ", received: " ^ PT.asString eTy)); 
		   ({tenv = tenv, venv = venv'}, (assignExp :: explist)))
	   | (Ty.RECORD(ty1, _), Ty.RECORD(ty2, _)) => 	  
	     if sTy = eTy
	     then ({tenv = tenv, venv = venv'}, (assignExp :: explist))
	     else ((err pos ("Constraint type and expression type mismatch: " ^ 
			     "different record types, expected: " ^ PT.asString sTy ^ 
			     ", received: " ^PT.asString eTy)); 
		   ({tenv = tenv, venv = venv'}, (assignExp :: explist)))
	   | (_, _) =>
	     if sTy = eTy
	     then ({tenv = tenv, venv = venv'}, (assignExp :: explist))
	     else ((err pos ("Constraint type and expression type mismatch, expected: " ^
			     PT.asString sTy ^ ", received: " ^PT.asString eTy)); 
		   ({tenv = tenv, venv = venv'}, (assignExp :: explist))))
    end
(* similar to previous case, but with declared type *)

  | transDec (venv, tenv, level, break, explist, A.TypeDec tydecls) =
    let
        (* TODO: create tenv': tenv extended with all the types
         * declared by 'tydecls'; will not use Tr *)
	val {venv, tenv = tenv'} = transTypeHeader(venv, tenv, A.TypeDec tydecls)
	val {venv, tenv = tenv''} = transTypeBody(venv, tenv', A.TypeDec tydecls)
    in
        ({tenv = tenv'', venv = venv}, explist)
    end

  | transDec (venv, tenv, level, break, explist, A.FunctionDec fundecls) =
    let
        (* TODO: create venv': venv extended with all the functions 
         * declared by 'fundecls'; also process the function bodies;
         * will use Tr.newLevel, Tr.accessOfFormal, Tr.procEntryExit,
         * Tr.funEntryExit *)
	val {venv = venv', tenv = tenv} = transFuncHeader(venv, tenv, level, A.FunctionDec fundecls)
	val ({venv = venv'', tenv = tenv}, explist') = transFuncBody(venv', tenv, level, explist, break, A.FunctionDec fundecls)
    in
        ({venv = venv'', tenv = tenv}, explist')
    end

and transDecs (venv, tenv, level, break, explist, decls) =
    case decls of
        [] => ({venv = venv, tenv = tenv}, explist)
      | (d::ds) =>
        let
            val ({venv = venv', tenv = tenv'}, explist') =
                transDec (venv, tenv, level, break, explist, d)
        in
            transDecs (venv', tenv', level, break, explist', ds)
        end

and transTypeHeader (venv, tenv, A.TypeDec([])) =
    {tenv = tenv, venv = venv}

  | transTypeHeader (venv, tenv, A.TypeDec(tydecl :: tydecls)) = 
    let
	val {name, ty, pos} = tydecl
	val tenv' = S.enter(tenv, name, Ty.NAME(name, ref NONE))
    in
	transTypeHeader(venv, tenv', A.TypeDec(tydecls))
    end

  | transTypeHeader (venv, tenv, _) =
    {venv = venv, tenv = tenv}

and transTypeBody (venv, tenv, A.TypeDec(tydecl :: tydecls)) = 
    let
	val {name, ty, pos} = tydecl
	val typ1 = lookupTy(tenv, name, pos)
	val typ2 = transTy(tenv, ty)
    in
	((case typ1 of
	     Ty.NAME(name, tyOp) => tyOp := SOME typ2
	   | _ => (err pos "Error in definition of recursive types")
	);
	transTypeBody(venv, tenv, A.TypeDec(tydecls)))
    end

  | transTypeBody (venv, tenv, _) =
    {venv = venv, tenv = tenv} 

and transFuncHeader (venv, tenv, level, A.FunctionDec(fundecl :: fundecls)) =
    let
	val {name, params, result, body, pos} = fundecl
	fun transparam {name, escape, typ = (t, p), pos} =
	    {name = name, ty = lookupTy(tenv, t, p)}
	fun trueList ([], res) =
	    res
	  | trueList ((formal :: formals), res) =
	    trueList(formals, (true :: res))
	val params' = map transparam params
	val formalList = trueList(params', [])
	val level' = Tr.newLevel {parent=level, name=name, formals=formalList}
    in
	(case result of 
	     SOME (s, p) => 
	     let 
		 val rt = lookupTy(tenv, s, p)
		 val venv' = S.enter(venv, name, E.FunEntry{formals = map #ty params', result = rt, label = Temp.newLabel(""), level = level'})
	     in
		 transFuncHeader(venv', tenv, level, A.FunctionDec(fundecls))
	     end
	   | NONE => 
	     let
		 val venv' = S.enter(venv, name, 
				     E.FunEntry{formals = map #ty params', result = Ty.UNIT, label = Temp.newLabel(""), level = level'})
	     in
		 transFuncHeader(venv', tenv, level, A.FunctionDec(fundecls))
	     end
	)
    end

  | transFuncHeader (venv, tenv, level, _) = 
    {venv = venv, tenv = tenv}

and transFuncBody (venv, tenv, level, explist, break, A.FunctionDec(fundecl :: fundecls)) =
    let
	val {name, params, result=result1, body, pos} = fundecl
	val level' = (case S.look (venv, name) of
			     SOME (E.FunEntry{formals, result, label, level = level''}) => level''
			   | SOME _ => ((err pos "SOME not FunEntry in transFuncBody"); level)
			   | NONE => ((err pos "NONE funEntry in transFuncBody"); level)) 
	fun transparam {name, escape, typ = (t, p), pos} =
	    {name = name, ty = lookupTy(tenv, t, p), escape = escape}
	fun enterparam ([], venv, res) = venv
	  | enterparam ({name, ty, escape} :: prs, venv, res) =
	    let
		val access = (Tr.accessOfFormal level res true)
	    in
		enterparam (prs, S.enter(venv, name, E.VarEntry{access = access, ty=ty, escape=escape, assignable=true}), res+1)
	    end
	fun trueList ([], res) =
	    res
	  | trueList ((formal :: formals), res) =
	    trueList(formals, (true :: res))
	val params' = map transparam params
	val formalList = trueList(params', [])
    in
	(case result1 of 
	     SOME (s, p) => 
	     let 
		 val rt = (actualTy (lookupTy(tenv, s, p)) pos)
		 val venv' = S.enter(venv, name, E.FunEntry{formals = map #ty params', result = rt, label = Temp.newLabel(""), level = level'})
		 val venv'' = enterparam (params', venv', 1)
		 val {exp=bodyExp, ty} = (transExp(venv'', tenv, level') body break)
		 val _ = Tr.funEntryExit {level = level', body = bodyExp}
		 val explist' = (bodyExp :: explist)
	     in
		 (if ty = rt
		  then ()
		  else (err pos ("Function result type different from declared result type, expected: " ^ 
				 PT.asString rt ^ ", received: " ^ PT.asString ty))); 
		 transFuncBody(venv', tenv, level, explist', break, A.FunctionDec(fundecls))
	     end
	   | NONE => 
	     let
		 val venv' = S.enter(venv, name, 
				     E.FunEntry{formals = map #ty params', result = Ty.UNIT, label = Temp.newLabel(""), level = level'})
		 val venv'' = enterparam (params', venv', 1)
		 val {exp=bodyExp, ty} = (transExp(venv'', tenv, level') body break)
		 val _ = Tr.procEntryExit {level = level', body = bodyExp}
		 val explist' = (bodyExp :: explist)
	     in
		 (if ty = Ty.UNIT
		  then ()
		  else (err pos ("Procedure result type different from UNIT, expected: UNIT, received: " ^ 
				 PT.asString ty))); 
		 transFuncBody(venv', tenv, level, explist', break, A.FunctionDec(fundecls))
	     end
	)
    end

  | transFuncBody (venv, tenv, level, explist, break, _) =
    ({venv = venv, tenv = tenv}, explist) 

fun transProg absyn =
    let
	  val break = Tr.newBreakPoint("")
          val {exp, ty} = transExp (Env.baseVenv, Env.baseTenv, Env.initLevel)
                                   absyn break
    in
        if ty=Ty.UNIT
        then Tr.procEntryExit {level = Env.initLevel, body = exp}
        else Tr.funEntryExit {level = Env.initLevel, body = exp};
        Tr.getResult ()
    end

end (* Semant *)

