signature SEMANT =
sig
    val transProg: Absyn.exp -> Types.ty
end

structure Semant :> SEMANT =
struct

structure S = Symbol
structure A = Absyn
structure E = Env
structure Ty = Types
structure PT = PrintTypes

val err = ErrorMsg.error
val breakLevel = ref 0

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
		  Ty.NAME(s, ty))) (* Hvad er den korrekte retur type når ty er NONE? *)
  | actualTy t _ = t  
 
fun checkInt (ty, pos, msg) =
    case ty of
        Ty.INT => ()
      | _ => err pos ("INT required " ^ msg ^ ", " ^
                      PT.asString ty ^ " provided")

fun checkUnit (ty, pos, msg) = 
    case ty of
	Ty.UNIT => ()
      | _  => err pos ("UNIT required " ^ msg ^ ", " ^
                       PT.asString ty ^ " provided")

fun checkAssignable (declared: Ty.ty, assigned: Ty.ty, pos, msg) =
    let
        val aDeclared = actualTy declared pos
        val aAssigned = actualTy assigned pos
    in
        () (* TODO *)
    end

fun recordTy (tenv, []) = []
  | recordTy (tenv, ({name, escape, typ = (s, p), pos} :: records)) = 
    ((name, lookupTy(tenv, s, p)) :: recordTy (tenv, records))

fun transTy (tenv, t) = 
    (case t of
	 A.RecordTy (fd) => Ty.RECORD (recordTy (tenv, fd), ref ())
       | A.ArrayTy (sym, pos) => Ty.ARRAY (lookupTy(tenv, sym, pos), ref ())
       | A.NameTy (sym, pos) => lookupTy(tenv, sym, pos)
    ) 

fun transExp (venv, tenv) =
    let
        fun trexp (A.NilExp) = {exp = (), ty = Ty.NIL}
          | trexp (A.VarExp var) = (trvar var)
          | trexp (A.IntExp i) = {exp = (), ty = Ty.INT}	
          | trexp (A.StringExp (str, pos)) = {exp = (), ty = Ty.STRING}	
          | trexp (A.OpExp {left, oper, right, pos}) =
	    let val {exp, ty=leftty} = trexp left
		val {exp, ty=rightty} = trexp right
	    in
		(case (leftty, oper, rightty) of 
		     (Ty.INT, _, Ty.INT) => {exp=(), ty=Ty.INT}
		   | (Ty.STRING, A.EqOp, Ty.STRING) => {exp=(), ty=Ty.INT}
		   | (Ty.STRING, A.NeqOp, Ty.STRING) => {exp=(), ty=Ty.INT}
		   | (Ty.STRING, A.LtOp, Ty.STRING) => {exp=(), ty=Ty.INT}
		   | (Ty.STRING, A.LeOp, Ty.STRING) => {exp=(), ty=Ty.INT} 
		   | (Ty.STRING, A.GtOp, Ty.STRING) => {exp=(), ty=Ty.INT}
		   | (Ty.STRING, A.GeOp, Ty.STRING) => {exp=(), ty=Ty.INT}
		   | (Ty.NIL, A.EqOp, Ty.NIL)  => {exp=(), ty=Ty.INT}
		   | (Ty.NIL, A.NeqOp, Ty.NIL)  => {exp=(), ty=Ty.INT}
		   | (Ty.RECORD (_, _), A.EqOp, Ty.NIL)  => {exp=(), ty=Ty.INT}
		   | (Ty.RECORD (_, _), A.NeqOp, Ty.NIL)  => {exp=(), ty=Ty.INT}
		   | (Ty.NIL, A.EqOp, Ty.RECORD(_,_))  => {exp=(), ty=Ty.INT}
		   | (Ty.NIL, A.NeqOp, Ty.RECORD(_,_))  => {exp=(), ty=Ty.INT}
		   | (Ty.ARRAY (ty1, _), A.EqOp, Ty.ARRAY (ty2, _)) => 
		     if ty1 = ty2
		     then {exp=(), ty=Ty.INT}
		     else ((err pos ("Comparison of incompatible array types: " ^ 
				     PT.asString ty1 ^ ", " ^ PT.asString ty2)); 
			   {exp=(), ty=Ty.INT})

		   | (Ty.ARRAY (ty1, _), A.NeqOp, Ty.ARRAY (ty2, _)) =>		   
		     if ty1 = ty2
		     then {exp=(), ty=Ty.INT}
		     else ((err pos ("Comparison of incompatible array types: " ^ 
				     PT.asString ty1 ^ ", " ^ PT.asString ty2)); 
			   {exp=(), ty=Ty.INT})

		   | (Ty.RECORD (sytys1, _), A.EqOp, Ty.RECORD (sytys2, _)) =>		
		     let
			 fun symSort ((sym1, ty1) , (sym2, ty2)) =
			     S.name(sym1) > S.name(sym2)
			 val sorted1 = ListMergeSort.sort symSort sytys1
			 val sorted2 = ListMergeSort.sort symSort sytys2
		     in
			 if sorted1 = sorted2
			 then {exp=(), ty = Ty.INT}
			 else ((err pos ("Comparison of incompatible record types: " ^ 
					 PT.asString leftty ^ ", " ^ PT.asString rightty)); 
			       {exp=(), ty=Ty.INT})
		     end

		   | (Ty.RECORD (sytys1, _), A.NeqOp, Ty.RECORD (sytys2, _)) =>		
		     let
			 fun symSort ((sym1, ty1) , (sym2, ty2)) =
			     S.name(sym1) > S.name(sym2)
			 val sorted1 = ListMergeSort.sort symSort sytys1
			 val sorted2 = ListMergeSort.sort symSort sytys2
		     in
			 if sorted1 = sorted2
			 then {exp=(), ty = Ty.INT}
			 else ((err pos ("Comparison of incompatible record types: " ^ 
					 PT.asString leftty ^ ", " ^ PT.asString rightty)); 
			       {exp=(), ty=Ty.INT})
		     end

		   |  (_, _, _) => ((err pos ("Operator used on incompatible types: " ^ 
					      PT.asString leftty ^ ", " ^ PT.asString rightty)); 
				    {exp=(), ty=Ty.INT})
		)
	    end
          | trexp (A.CallExp {func, args, pos}) = 
	    let
		val funct = S.look(venv, func)
		fun transargs (exp, pos) =
		    let val {exp, ty} = trexp exp
		    in actualTy ty pos
		    end
		val args' = map transargs args
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
	    in
		(case funct
		  of SOME (E.FunEntry ({formals, result})) => 
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
			  {exp=(), ty = result}
		     end
		  |  _ => 
		     ((err pos ("Function doesn't exist: " ^ S.name(func))); 
		      {exp=(), ty=Ty.ERROR})
		)
	    end
          | trexp (A.IfExp {test, thn, els, pos}) = 
	    let
		val {exp, ty=testTy} = trexp test		
		val {exp, ty=thnTy} = trexp thn
	    in
		checkInt(testTy, pos, "when checking 'test' in if expression");
		(case els of
		     SOME(elsExp) =>
		     let
			 val {exp, ty=elsTy} = trexp elsExp
		     in
			 if thnTy = elsTy
			 then {exp=(), ty=thnTy}
			 else  (case (thnTy, elsTy) of
				    (Ty.NIL, Ty.RECORD(_,_)) => {exp=(), ty=elsTy}
				  | (Ty.RECORD(_,_), Ty.NIL) => {exp=(), ty=thnTy}
				  | _ => 
				    ((err pos ("'thnTy' and 'elsTy' has different types. thnTy: " ^
					       PT.asString thnTy ^ ", elsTy: " ^ PT.asString elsTy));
				     {exp=(), ty=Ty.ERROR})
			       )
		     end
		   | NONE => 
		     (checkUnit(thnTy, pos, "when checking 'thnTy' in if expression");		   
		      {exp=(), ty=Ty.UNIT}))		  
	    end	    
          | trexp (A.WhileExp {test, body, pos}) = 
	    let 
		val {exp, ty = testTy} = trexp test
		val _ = (breakLevel := !breakLevel + 1)
		val	{exp, ty = bodyTy} = trexp body
		val _ = (if !breakLevel > 0 then (breakLevel := !breakLevel - 1) else ())
	    in 
		checkInt(testTy, pos, "in 'test' in while expression");
		checkUnit(bodyTy, pos, "in 'body' in while expression");
		{exp=(), ty=Ty.UNIT}
	    end
          | trexp (A.RecordExp {fields, typ, pos}) = 
	    let
		val typId = actualTy (lookupTy(tenv, typ, pos)) pos
		fun transfields (sym, exp, pos) = 
		    let  val {exp, ty} = trexp exp
		    in (sym, (actualTy ty pos))
		    end
		val fields' = map transfields fields
		fun symSort ((sym1, ty1) , (sym2, ty2)) =
		    S.name(sym1) > S.name(sym2)
		fun actualSymTyp [] = []
		  | actualSymTyp ((sym, typ) :: symtyps) =
		    ((sym, actualTy typ pos) :: actualSymTyp (symtyps))
		fun nilEqualizer ([], []) = true
		  | nilEqualizer (symtyps1, []) = ((err pos ("Amount of parameters in record larger than in record type: " ^ PT.asString(typId))); 
						   false)
		  | nilEqualizer ([], symtyps2) = ((err pos ("Amount of parameters in record less than in record type: " ^ PT.asString(typId))); 
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
			 then {exp=(), ty=typId}
			 else ((err pos ("Record types don't match, expected: " ^
					 PT.asString (Ty.RECORD(recList', ref ())) ^ ", received: " 
					 ^ PT.asString (Ty.RECORD(fields'', ref ()))));
			       {exp=(), ty=typId})
		     end
		   | _ => ((err pos ("Expected record type, received: " 
				     ^ PT.asString typId)); {exp=(), ty=Ty.ERROR})
		)
	    end
          | trexp (A.SeqExp []) = {exp=(), ty=Ty.UNIT}

	  | trexp (A.SeqExp (aexps as ((aexp', p) :: []))) = 
	    (trexp aexp')

          | trexp (A.SeqExp (aexps as ((aexp', p) :: aexps'))) = 
	    ((trexp aexp'); trexp (A.SeqExp (aexps')))

          | trexp (A.AssignExp {var, exp, pos}) = 
	    let
		val {exp=_, ty=varTy} = trvar var
		val {exp, ty=expTy} = trexp exp
		fun isAssignable (A.SimpleVar (id, pos)) =
		    (case S.look(venv, id) of
			 SOME (E.VarEntry {ty, assignable}) => assignable
		       | SOME (E.FunEntry {formals, result}) => false
		       | NONE => (err pos ("undefined variable " ^ (S.name id)); false))
		  | isAssignable (A.FieldVar (var, id, pos)) =  true
		  | isAssignable (A.SubscriptVar (var, exp, pos))   = true
		val assignable = isAssignable var		    
	    in
		if (assignable = false) 
		then ((err pos ("variable must not be assigned to"));
		      {exp=(), ty=Ty.UNIT})
		else		      
		    if varTy = expTy
		    then {exp=(), ty=Ty.UNIT}
		    else ((err pos ("Variable and expression in assign expression not equal. Var: " ^
				    PT.asString varTy ^ ", Exp: " ^ PT.asString expTy));
			  {exp=(), ty=Ty.UNIT})
	    end

          | trexp (A.ForExp {var, escape, lo, hi, body, pos}) =
	    let
		val {exp, ty=loTy} = trexp lo
		val {exp, ty=hiTy} = trexp hi
	    in
		(breakLevel := !breakLevel + 1);
		checkInt(loTy, pos, "when checking 'lo' in ForExp");
		checkInt(hiTy, pos, "when checking 'hi' in ForExp");
		let
		    val venv' = S.enter(venv, var, E.VarEntry{ty=loTy, assignable=false})
		    val {exp, ty=bodyTy} = transExp(venv', tenv) body
		in
		      (if !breakLevel > 0
		       then (breakLevel := !breakLevel - 1)
		       else ());
		    checkUnit(bodyTy, pos, "when checking 'bodyTy' in for expression");
		    {exp=(), ty=Ty.UNIT}
		end
	    end

          | trexp (A.BreakExp pos) = 
	    if (!breakLevel) = 0
	    then ((err pos ("Break expression outside of loop")); {exp=(), ty=Ty.UNIT})
	    else ((breakLevel := !breakLevel - 1); {exp=(), ty=Ty.UNIT})

	  | trexp (A.LetExp {decls, body, pos}) = 
	    let 
		val {venv = venv'', tenv = tenv''} = transDecs(venv,tenv,decls)
	    in 
		transExp(venv'',tenv'') body
	    end

          | trexp (A.ArrayExp {typ, size, init, pos}) = 
	    let
		val {exp, ty=sizeTy} = trexp size
		val {exp, ty=initTy} = trexp init
		val arrTy = (actualTy (lookupTy(tenv, typ, pos)) pos)
	    in
		checkInt(sizeTy, pos, "when checking 'size' in ArrayExp");
		(case arrTy of
		     Ty.ARRAY(typTy, _) =>
		     if (actualTy typTy pos) = (actualTy initTy pos)
		     then {exp=(), ty=Ty.ARRAY(typTy, ref ())}
		     else ((err pos ("Array type and init expression type don't agree, expected: " ^
				     PT.asString(typTy) ^ ", received: " ^ PT.asString(initTy))); 
			   {exp=(), ty=Ty.ERROR})
		   | _ => ((err pos ("Array not of array type but of " ^ PT.asString(arrTy) ^ " type."));
			   {exp=(), ty=Ty.ERROR})
		)
	    end

        and trvar (A.SimpleVar (id, pos)) =
	    (case S.look(venv, id) of 
		 SOME(E.VarEntry{ty, assignable}) => {exp = (), ty = (actualTy ty pos)}
	       | SOME(E.FunEntry{formals, result}) => (err pos ("undefined variable " ^ (S.name id) 
							       ^ ", declared variable is a function");
						      {exp = (), ty = Ty.INT})
	       | NONE => (err pos ("undefined variable " ^ (S.name id));
			  {exp = (), ty = Ty.INT}))
          | trvar (A.FieldVar (var, id, pos)) = 
	    let
		val {exp, ty = vaTy} = trvar var
		val varTy = actualTy vaTy pos
		fun checkForId (id, ((sym, typ) :: sts)) =
		    if id = sym
		    then {exp=(), ty = typ}
		    else checkForId(id, sts)
		  | checkForId (id, []) = ((err pos ("Id doesn't exist in record type: " ^
						     S.name(id) ^ ", in: " ^ PT.asString(varTy))); 
					   {exp=(), ty=Ty.ERROR})
	    in
		(case varTy of
		     Ty.RECORD(symList, _) => checkForId(id, symList)
		   | _ => ((err pos ("Error while checking FieldVar, expected RECORD type, received: " 
				     ^ PT.asString(varTy))); 
			   {exp=(), ty = Ty.ERROR})
		)
	    end

          | trvar (A.SubscriptVar (var, exp, pos)) = 
	    let
		val {exp, ty=expTy} = trexp exp
		val {exp, ty=vaTy} = trvar var
		val varTy = actualTy vaTy pos
	    in
		checkInt(expTy, pos, "when checking 'expTy' in subscript");
		(case varTy of
		     Ty.ARRAY(arrTy, _) => {exp=(), ty = arrTy}
		   | _ => ((err pos ("Expected array type, received: " ^PT.asString varTy));
			   {exp=(), ty = Ty.ERROR}))
	    end
    in
        trexp
    end

and transDec ( venv,  tenv, A.VarDec {name, escape, typ = NONE, init, pos}) =
    let 
	val {exp, ty} = transExp(venv, tenv) init
    in 
	(if ty = Ty.NIL
	then (err pos "Variable initialized by nil expression")
	else ());
	{tenv = tenv, venv = S.enter(venv, name, E.VarEntry{ty=ty, assignable=true})}
    end
	
  | transDec ( venv, tenv
               , A.VarDec {name, escape, typ = SOME (s, pos), init, pos=pos1}) =
    let 
	val {exp, ty} = transExp(venv, tenv) init
	val eTy = (actualTy ty pos)
	val sTy = (actualTy (lookupTy(tenv, s, pos)) pos)
    in (case (sTy, eTy) of 
	    (Ty.RECORD(_,_), Ty.NIL) => 
	    {tenv = tenv, venv = S.enter(venv, name, E.VarEntry{ty=ty, assignable=true})}
	  | (Ty.ARRAY (ty1, u1), Ty.ARRAY (ty2, u2)) => 		   
	    if ty1 = ty2
	    then {tenv = tenv, venv = S.enter(venv, name, E.VarEntry{ty=ty, assignable=true})}
	    else ((err pos ("Constraint type and expression type mismatch: " ^ 
			    "different array types, expected: " ^ PT.asString sTy ^ 
			    ", received: " ^ PT.asString eTy)); 
		  {tenv = tenv, venv = 
				S.enter(venv, name, E.VarEntry{ty=Ty.ERROR, assignable=true})})
	  | (Ty.RECORD(ty1, _), Ty.RECORD(ty2, _)) => 	  
	    if sTy = eTy
	    then {tenv = tenv, venv = S.enter(venv, name, E.VarEntry{ty=ty, assignable=true})}
	    else ((err pos ("Constraint type and expression type mismatch: " ^ 
			    "different record types, expected: " ^ PT.asString sTy ^ 
			    ", received: " ^PT.asString eTy)); 
		  {tenv = tenv, venv = 
				S.enter(venv, name, E.VarEntry{ty=Ty.ERROR, assignable=true})})
	  | (_, _) =>
	    if sTy = eTy
	    then {tenv = tenv, venv = S.enter(venv, name, E.VarEntry{ty=ty, assignable=true})}
	    else ((err pos ("Constraint type and expression type mismatch, expected: " ^
			    PT.asString sTy ^ ", received: " ^PT.asString eTy)); 
		  {tenv = tenv, venv = 
				S.enter(venv, name, E.VarEntry{ty=Ty.ERROR, assignable=true})}))
    end

  | transDec (venv, tenv, A.TypeDec ([])) =
    {tenv = tenv, venv = venv}

  | transDec (venv, tenv, A.TypeDec (tydecl :: tydecls)) =
    let
	val {name, ty, pos} = tydecl
	val typ1 = lookupTy(tenv, name, pos)
	val typ2 = transTy(tenv, ty)
    in
	((case typ1 of
	     Ty.NAME(name, tyOp) => tyOp := SOME typ2
	   | _ => (err pos "Error in definition of recursive types")
	);
	transDec(venv, tenv, A.TypeDec(tydecls)))
    end

  | transDec (venv, tenv, A.FunctionDec ([])) = 
    {venv = venv, tenv = tenv}
  | transDec (venv, tenv, A.FunctionDec (fundecl :: fundecls)) =
    let
	val {name, params, result, body, pos} = fundecl
	fun transparam {name, escape, typ = (t, p), pos} =
	    {name = name, ty = lookupTy(tenv, t, p)}
	fun enterparam ([], venv) = venv
	  | enterparam ({name, ty} :: prs, venv) =
	    enterparam (prs, S.enter(venv, name, E.VarEntry{ty=ty, assignable=true}))
	val params' = map transparam params
    in
	(case result of 
	     SOME (s, p) => 
	     let 
		 val rt = (actualTy (lookupTy(tenv, s, p)) pos)
		 val venv' = S.enter(venv, name, E.FunEntry{formals = map #ty params', result = rt})
		 val venv'' = enterparam (params', venv')
		 val {exp, ty} = (transExp(venv'', tenv) body)
	     in
		 (if ty = rt
		  then ()
		  else (err pos ("Function result type different from declared result type, expected: " ^ 
				 PT.asString rt ^ ", received: " ^ PT.asString ty))); 
		 transDec(venv', tenv, A.FunctionDec(fundecls))
	     end
	   | NONE => 
	     let
		 val venv' = S.enter(venv, name, 
				     E.FunEntry{formals = map #ty params', result = Ty.UNIT})
		 val venv'' = enterparam (params', venv')
		 val {exp, ty} = (transExp(venv'', tenv) body)
	     in
		 (if ty = Ty.UNIT
		  then ()
		  else (err pos ("Procedure result type different from UNIT, expected: UNIT, received: " ^ 
				 PT.asString ty))); 
		 transDec(venv', tenv, A.FunctionDec(fundecls))
	     end
	)
    end

and transHeader (venv, tenv, A.TypeDec([])) =
    {tenv = tenv, venv = venv}

  | transHeader  (venv, tenv, A.TypeDec (tydecl :: tydecls)) =
    let
	val {name, ty, pos} = tydecl
    in
	transHeader(venv, S.enter(tenv, name, Ty.NAME(name, ref NONE)), A.TypeDec(tydecls)) 
    end

  | transHeader (venv, tenv, A.FunctionDec ([])) = 
    {venv = venv, tenv = tenv}

  | transHeader (venv, tenv, A.FunctionDec (fundecl :: fundecls)) =
    let
	val {name, params, result, body, pos} = fundecl
	fun transparam {name, escape, typ = (t, p), pos} =
	    {name = name, ty = lookupTy(tenv, t, p)}
	val params' = map transparam params
    in
	(case result of 
	     SOME (s, p) => 
	     let 
		 val rt = lookupTy(tenv, s, p)
		 val venv' = S.enter(venv, name, E.FunEntry{formals = map #ty params', result = rt})
	     in
		 transHeader(venv', tenv, A.FunctionDec(fundecls))
	     end
	   | NONE => 
	     let
		 val venv' = S.enter(venv, name, 
				     E.FunEntry{formals = map #ty params', result = Ty.UNIT})
	     in
		 transHeader(venv', tenv, A.FunctionDec(fundecls))
	     end
	)
    end
  | transHeader (venv, tenv, A.VarDec {name, escape, typ, init, pos}) = {tenv = tenv, venv = venv}
	
and transDecs (venv, tenv, decls) =
    case decls of 
	[] => {venv = venv, tenv = tenv}
      | (d::ds) =>
        let
	    val {venv = venv', tenv = tenv'} = transHeader (venv, tenv, d)
            val {venv = venv'', tenv = tenv''} = transDec (venv', tenv', d)
        in
            transDecs (venv'', tenv'', ds)
        end

fun transProg absyn =
    let
        val {exp=_,ty} = transExp (Env.baseVenv, Env.baseTenv) absyn
    in
        ty
    end

end (* Semant *)

