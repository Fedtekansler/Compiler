signature ENV =
sig

  type access

  datatype enventry = VarEntry of {ty: Types.ty, assignable: bool}
                    | FunEntry of {formals: Types.ty list, result: Types.ty}

  val baseTenv: Types.ty Symbol.table
  val baseVenv: enventry Symbol.table

end
