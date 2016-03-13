structure Env :> ENV = 
struct

structure Sy = Symbol
structure Ty = Types
structure Tm = Temp
structure Tr = Translate

type access = unit ref

datatype enventry = VarEntry of { access: Tr.access
                                , ty: Ty.ty
                                , escape: bool ref
                                , assignable: bool}
                  | FunEntry of { formals: Ty.ty list
                                , result: Ty.ty
                                , label: Tm.label
                                , level: Tr.level}

val initLevel = Tr.newLevel { parent = Tr.outermost
                            , name = Tm.topLabel
                            , formals = []}

local
    fun enter ((symbol, entry), env) = Sy.enter (env, symbol, entry)
in
    val baseTenv =
        foldl enter Sy.empty
              [ (Sy.symbol "int", Ty.INT)
              , (Sy.symbol "string", Ty.STRING)]

    val baseVenv = foldl enter Sy.empty [

      (Sy.symbol "print",     FunEntry { formals = [Ty.STRING]
                                       , result = Ty.UNIT
                                       , label = Tm.namedLabel "print"
                                       , level = initLevel}),

      (Sy.symbol "flush",     FunEntry { formals = []
                                       , result = Ty.UNIT
                                       , label =  Tm.namedLabel "flush"
                                       , level = initLevel}),

      (Sy.symbol "getchar",   FunEntry { formals = []
                                       , result = Ty.STRING
                                       , label =  Tm.namedLabel "getchar"
                                       , level = initLevel}),

      (Sy.symbol "ord",       FunEntry { formals = [Ty.STRING]
                                       , result = Ty.INT
                                       , label =  Tm.namedLabel "ord"
                                       , level = initLevel}),

      (Sy.symbol "chr",       FunEntry { formals = [Ty.INT]
                                       , result = Ty.STRING
                                       , label =  Tm.namedLabel "chr"
                                       , level = initLevel}),

      (Sy.symbol "size",      FunEntry { formals = [Ty.STRING]
                                       , result = Ty.INT
                                       , label =  Tm.namedLabel "size"
                                       , level = initLevel}),
   
      (Sy.symbol "substring", FunEntry { formals = [Ty.STRING, Ty.INT, Ty.INT]
                                       , result = Ty.STRING
                                       , label =  Tm.namedLabel "substring"
                                       , level = initLevel}),

      (Sy.symbol "concat",    FunEntry { formals = [Ty.STRING, Ty.STRING]
                                       , result = Ty.STRING
                                       , label =  Tm.namedLabel "concat"
                                       , level = initLevel}),

      (Sy.symbol "not",       FunEntry { formals = [Ty.INT]
                                       , result = Ty.INT
                                       , label =  Tm.namedLabel "not"
                                       , level = initLevel}),

      (Sy.symbol "exit",      FunEntry { formals = [Ty.INT]
                                       , result = Ty.UNIT
                                       , label =  Tm.namedLabel "exit"
                                       , level = initLevel})
    ]   
end   
   
end (* Env *)
