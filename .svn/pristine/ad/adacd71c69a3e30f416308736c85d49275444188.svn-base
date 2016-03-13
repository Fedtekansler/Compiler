signature FRAME =
sig

  type frame (* describe a stack frame *)
  type access (* describe a formal arg or local var, in register or in frame *)

  val FP: Temp.temp
  val SP: Temp.temp
  val RV: Temp.temp
  val EAX: Temp.temp
  val EBX: Temp.temp
  val ECX: Temp.temp
  val EDX: Temp.temp
  val ESI: Temp.temp
  val EDI: Temp.temp
  val EIP: Temp.temp

  val wordSize: int

  val argregs: Temp.temp list
  val calldefs : Temp.temp list
  val calleesaves : Temp.temp list
  val callersaves : Temp.temp list

  val newFrame: {name: Temp.label, formals: bool list} -> frame
  val name: frame -> Temp.label
  val formals: frame -> access list
  val accessOfFormal: int -> bool -> access
  val allocLocal: frame -> bool -> access
  val staticLinkOffset: frame -> int

  val number2formal: int -> Tree.exp
  val exp: access -> Tree.exp -> Tree.exp
  val string: Temp.label * string -> string
  val externalCall: string * Tree.exp list -> Tree.exp

  val funEntryExit1: frame * Tree.exp -> Tree.stm
  val procEntryExit1: frame * Tree.stm -> Tree.stm

  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string

  (* Printing *)
  val asStringReg: Temp.temp -> string
  val asStringFrame: frame -> string
  val asStringAccess: access -> string
  val printFrame: TextIO.outstream * frame -> unit
  val printAccess: TextIO.outstream * access -> unit

end (* FRAME *)
