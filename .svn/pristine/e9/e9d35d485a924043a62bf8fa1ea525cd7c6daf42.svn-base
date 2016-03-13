signature ENV =
sig

  type access

  datatype enventry = VarEntry of { access: Translate.access
                                  , ty: Types.ty
                                  , escape: bool ref
                                  , assignable: bool}
                    | FunEntry of { formals: Types.ty list
                                  , result: Types.ty
                                  , label: Temp.label
                                  , level: Translate.level}
                                  
  val initLevel: Translate.level
  val baseTenv: Types.ty Symbol.table
  val baseVenv: enventry Symbol.table

end

