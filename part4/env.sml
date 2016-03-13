structure Env :> ENV = 
struct

structure Sy = Symbol
structure Ty = Types

type access = unit ref
type ty = Ty.ty

datatype enventry = VarEntry of {ty: ty, assignable: bool}
                  | FunEntry of {formals: ty list, result: ty}

fun enter ((symbol, entry), env) = Sy.enter (env, symbol, entry)

val baseTenv =
    foldl enter Sy.empty 
          [ (Sy.symbol "int", Ty.INT)
          , (Sy.symbol "string", Ty.STRING)]

val baseVenv = foldl enter Sy.empty [

  (Sy.symbol "print",       FunEntry { formals = [Ty.STRING]
                                     , result = Ty.UNIT}),

  (Sy.symbol "flush",       FunEntry { formals = []
                                     , result = Ty.UNIT}),

  (Sy.symbol "getchar",       FunEntry { formals = []
                                     , result = Ty.STRING}),

  (Sy.symbol "ord",       FunEntry { formals = [Ty.STRING]
                                     , result = Ty.INT}),

  (Sy.symbol "chr",       FunEntry { formals = [Ty.INT]
                                     , result = Ty.STRING}),

  (Sy.symbol "size",       FunEntry { formals = [Ty.STRING]
                                     , result = Ty.INT}),

  (Sy.symbol "substring",       FunEntry { formals = [Ty.STRING, Ty.INT, Ty.INT]
                                     , result = Ty.STRING}),

  (Sy.symbol "concat",       FunEntry { formals = [Ty.STRING, Ty.STRING]
                                     , result = Ty.STRING}),

  (Sy.symbol "not",       FunEntry { formals = [Ty.INT]
                                     , result = Ty.INT}),

  (Sy.symbol "exit",       FunEntry { formals = [Ty.INT]
                                     , result = Ty.UNIT})
]

end (* Env *)

