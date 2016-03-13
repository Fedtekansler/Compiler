(* ---------- Initial code for hand-in 1, dOvs 2013: warmup.sml ---------- *)

structure SLgrammar = struct

type id = string
type table = (id * int) list

datatype binop = Plus | Minus | Times | Div

datatype stm = CompoundStm of stm * stm
	     | AssignStm of id * exp
	     | PrintStm of exp list
     and exp = IdExp of id
	     | NumExp of int
             | OpExp of exp * binop * exp
             | EseqExp of stm * exp

end (* SLgrammar *)

(* ----- Fill in: Interpret SLgrammar as specified ----- *)

structure G = SLgrammar

(*...*)

fun intListToString [] = "\n"
  | intListToString ((s: string) :: (ss: string list)) = s ^ " " ^ intListToString(ss)

fun interp (s: G.stm): unit =
    let val _ = print ("Executing: " ^ (stringOfStm s) ^ "\n")
    	val env = interpStm (s, [])
    in ()
    end
	
and interpStm (G.AssignStm(i,exp), t: G.table): G.table =  
    let val expres = interpExp(exp, t)
    in update(#2 expres, i, #1 expres)
    end
  | interpStm (G.PrintStm(x), t: G.table): G.table =
    let val expList = interpExpList(x, t)
	val stringList = map Int.toString (#1 expList)
	val _ = print(intListToString(stringList));
    in  #2 expList
    end
  | interpStm (G.CompoundStm(stm1,stm2), t: G.table): G.table =
    interpStm(stm2, (interpStm(stm1, t)))

and interpExp (G.NumExp(n), t: G.table): int * G.table = (n, t)
  | interpExp (G.IdExp(i), t: G.table): int * G.table = (lookup(t, i), t)
  | interpExp (G.OpExp(e1, binop, e2), t: G.table): int * G.table = 
    let val e1res = interpExp(e1, t)
	val e2res = interpExp(e2, #2 e1res)
    in (interpBinop(#1 e1res, binop, #1 e2res), #2 e2res)
    end
  | interpExp (G.EseqExp(stm1, exp1), t: G.table): int * G.table = interpExp(exp1, interpStm(stm1, t))

and interpBinop (n1:int, G.Plus, n2:int): int = n1 + n2
  | interpBinop  (n1:int, G.Times, n2:int): int = n1 * n2 
  | interpBinop  (n1:int, G.Minus, n2:int): int = n1 - n2 
  | interpBinop  (n1:int, G.Div, n2:int): int = n1 div n2 

and interpExpList ([], t: G.table): int list * G.table = ([], t)
  | interpExpList (((e: G.exp) :: (es: G.exp list)), t: G.table): int list * G.table = 
    let val expres = interpExp(e, t)
	val expListres = interpExpList(es, #2 expres)
    in ((#1 expres :: #1 expListres), #2 expListres)
    end

and update (t: G.table, i: G.id, n: int): G.table = ((i, n) :: t)

and lookup ([], i: G.id): int = 0
  | lookup ((((i1, n): G.id * int) :: (ts: G.table)), i2: G.id): int = if i1 = i2 then n else lookup(ts, i2)

and stringOfStm (G.CompoundStm(stm1,stm2)) = (stringOfStm stm1) ^ (stringOfStm stm2)
  | stringOfStm (G.AssignStm(id,exp)) = id ^ " := " ^ stringOfExp(exp) ^ "; "
  | stringOfStm (G.PrintStm(expList)) = "print(" ^ stringOfExpList(expList) ^ ")"

and stringOfExp (G.IdExp(exp)) = exp
  | stringOfExp (G.NumExp(exp)) = Int.toString(exp)
  | stringOfExp (G.OpExp(exp1,binop,exp2)) = stringOfExp(exp1) ^ stringOfBinop(binop) ^ stringOfExp(exp2)
  | stringOfExp (G.EseqExp(stm, exp)) = "(" ^stringOfStm(stm) ^ ", " ^ stringOfExp(exp) ^ ")"

and stringOfExpList [] = ""
  | stringOfExpList ((e: G.exp) :: []) = stringOfExp(e) 
  | stringOfExpList ((e: G.exp) :: (es: G.exp list)) = stringOfExp(e) ^ ", " ^ stringOfExpList(es)

and stringOfBinop (G.Plus) = "+"
  | stringOfBinop (G.Minus) = "-"
  | stringOfBinop (G.Times) = "*"
  | stringOfBinop (G.Div) = "/"

fun maxargs (G.PrintStm(x)) =
    let val l = length x
	val listlength = expListHandler x
    in if l > listlength
       then l
       else listlength
    end
  | maxargs (G.AssignStm(id,exp)) = expHandler exp
  | maxargs (G.CompoundStm(stm1,stm2)) = 
    let val n1 = maxargs stm1
	val n2 = maxargs stm2
    in if n1 > n2
       then n1
       else n2
    end

and expHandler (G.OpExp (e1, binop, e2)) = 
    let val n1 = expHandler e1
	val n2 = expHandler e2
    in if n1 > n2
       then n1
       else n2
    end
  | expHandler (G.EseqExp (stm1,e1))  = 
    let val n1 = maxargs stm1
	val n2 = expHandler e1
    in if n1 > n2
       then n1
       else n2
    end
  | expHandler _ = 0

and expListHandler [] = 0
  | expListHandler ((e: G.exp) :: (es: G.exp list)) = 
    let val n1 = expHandler e
	val n2 = expListHandler es
    in if n1 > n2
       then n1
       else n2
    end

(* ----- Example for testing ----- *)
val prog =
    (* a := 5+3; b := (print(a,a-1), 10*a); print(b) *)
    G.CompoundStm (
	G.AssignStm ("a", G.OpExp (G.NumExp 5, G.Plus, G.NumExp 3)),
	G.CompoundStm (
	    G.AssignStm ("b", G.EseqExp (
			     G.PrintStm [G.IdExp "a", G.OpExp (G.IdExp "a", G.Minus, G.NumExp 1)],
			     G.OpExp (G.NumExp 10, G.Times, G.IdExp "a"))),
	    G.PrintStm [G.IdExp "b"]))
		  
val exp1 = 
    (* a := 10+5; b := 83-5; c := (print(a,a*b), (print(b, a/b, a), a+b)); print(c); *)
    G.CompoundStm (
	G.AssignStm ("a", G.OpExp (G.NumExp 10, G.Plus, G.NumExp 5)),
	G.CompoundStm (
	    G.AssignStm ("b", G.OpExp (G.NumExp 83, G.Minus, G.NumExp 5)),
	    G.CompoundStm (
		G.AssignStm ("c", G.EseqExp (
				 G.PrintStm[G.IdExp "a", G.OpExp(G.IdExp "a", G.Times, G.IdExp "b")], G.EseqExp(
				     G.PrintStm[G.IdExp "b", G.OpExp(G.IdExp "a", G.Div, G.IdExp "b"), G.IdExp "a"], G.OpExp(G.IdExp "a", G.Plus, G.IdExp "b")))),
		G.PrintStm [G.IdExp "c"])))

val exp2 =
    (* a := 3+5; b := 7-4; c := (print(a,b), a*b); print(c); *)
    G.CompoundStm (
	G.AssignStm ("a", G.OpExp (G.NumExp 3, G.Plus, G.NumExp 5)),
	G.CompoundStm (
	    G.AssignStm ("b", G.OpExp (G.NumExp 7, G.Minus, G.NumExp 4)),
	    G.CompoundStm (
		G.AssignStm ("c", G.EseqExp (
				 G.PrintStm [G.IdExp "a", G.IdExp "b"],
				 G.OpExp (G.IdExp "a", G.Times, G.IdExp "b"))),
		G.PrintStm[G.IdExp "c"])))
		  
val exp3 = 
    (* a := 3*10; b := (print(a,a+1), a/4); c := (print (3,  b), b*2); print(c); *)
    G.CompoundStm (
	G.AssignStm ("a", G.OpExp (G.NumExp 3, G.Times, G.NumExp 10)),
	G.CompoundStm (
	    G.AssignStm ("b", G.EseqExp (
			     G.PrintStm [G.IdExp "a", G.OpExp (G.IdExp "a", G.Plus, G.NumExp 1)],
			     G.OpExp (G.IdExp "a", G.Div, G.NumExp 4))),
	    G.CompoundStm (
		G.AssignStm ("c", G.EseqExp (
				 G.PrintStm [G.NumExp 3, G.IdExp "b"],
				 G.OpExp (G.IdExp "b", G.Times, G.NumExp 2))),
		G.PrintStm [G.IdExp "c"])))

val exp4 = 
    (* a := 4/2; b := (print(a, a+1, a+2), a*a); print(b); *)
    G.CompoundStm (
	G.AssignStm ("a", G.OpExp (G.NumExp 4, G.Div, G.NumExp 2)),
	G.CompoundStm (
	    G.AssignStm ("b", G.EseqExp (
			     G.PrintStm [G.IdExp "a", G.OpExp (G.IdExp "a", G.Plus, G.NumExp 1), G.OpExp (G.IdExp "a", G.Plus, G.NumExp 2)],
			     G.OpExp (G.IdExp "a", G.Times, G.IdExp "a"))),
	    G.PrintStm [G.IdExp "b"]))

val exp5 =
    (* a := (print (1+2,2+3), 4*6); b := (print (a*2,a*3,a*4,a*5,a), a*6); print(b); *)
    G.CompoundStm (
	G.AssignStm ("a", G.EseqExp (
			 G.PrintStm [G.OpExp (G.NumExp 1, G.Plus, G.NumExp 2), G.OpExp (G.NumExp 2, G.Plus, G.NumExp 3)],
			 G.OpExp (G.NumExp 4, G.Times, G.NumExp 6))),
	G.CompoundStm (
	    G.AssignStm ("b", G.EseqExp (
			     G.PrintStm [G.OpExp (G.IdExp "a", G.Times, G.NumExp 2), G.OpExp (G.IdExp "a", G.Times, G.NumExp 3), G.OpExp (G.IdExp "a", G.Times, G.NumExp 4), G.OpExp (G.IdExp "a", G.Times, G.NumExp 5), G.IdExp "a"],
			     G.OpExp (G.IdExp "a", G.Times, G.NumExp 6))),
	    G.PrintStm [G.IdExp "b"]))	
		  
	;
