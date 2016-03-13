signature TRANSLATE =
sig

  type level (* describes a static nesting level *)
  type access (* describes a level and a frame access located there *)
  type exp (* an IR tree with an Ex/Nx/Cx view on it *)
  type frag (* a fragment of generated IR code or data *)
  type breakpoint (* where to go in case of 'break' *)

  val outermost: level
  val newLevel: {parent: level, name: Temp.label, formals: bool list} -> level
  val newAnonLevel: {parent: level} -> level
  val formals: level -> access list
  val allocLocal: level -> bool -> access
  val accessOfFormal: level -> int -> bool -> access

  val seq: Tree.stm list -> Tree.stm

  val unEx: exp -> Tree.exp
  val unNx: exp -> Tree.stm
  val unCx: exp -> (Temp.label * Temp.label -> Tree.stm)

  val levelEq: level * level -> bool (* equality for levels *)
  val empty : exp (* use where expression required but nothing useful to do *)
  val newBreakPoint: string -> breakpoint

  val simpleVar : access * level -> exp
  val fieldVar : exp * int -> exp (* get offset arg2 in record arg1 *)

  (* create Ex/Nx/Cx values, often by composing smaller ones *)
  val assign2IR: exp * exp -> exp
  val break2IR: Tree.label -> exp
  val int2IR: int -> exp
  val nil2IR: unit -> exp
  val ifThen2IR: exp * exp -> exp
  val ifThenElse2IR: exp * exp * exp -> exp
  val intOp2IR: Absyn.oper * exp * exp -> exp
  val let2IR: exp list * exp -> exp
  val eseq2IR: exp list -> exp
  val seq2IR: exp list -> exp
  val string2IR: string -> exp
  val defaultStringIR: exp
  val stringOp2IR: Absyn.oper * exp * exp -> exp
  val while2IR: exp * exp * Tree.label -> exp
  val for2IR: exp * Tree.label * exp * exp * exp -> exp
  val funCall2IR: level * level * Tree.label * exp list -> exp
  val procCall2IR: level * level * Tree.label * exp list -> exp
  val array2IR: exp * exp -> exp
  val record2IR: exp list -> exp
  val subscript2IR: exp * exp -> exp

  (* add a function/procedure to the list of fragments, and fetch it *)
  val funEntryExit: {level: level, body: exp} -> unit
  val procEntryExit: {level: level, body: exp} -> unit
  val getResult: unit -> frag list

  (* Printing *)
  val asStringLevel: level -> string
  val asStringAccess: access -> string
  val asStringExp: exp -> string
  val printLevel: TextIO.outstream * level -> unit
  val printAccess: TextIO.outstream * access -> unit
  val printExp: TextIO.outstream * exp -> unit

end
