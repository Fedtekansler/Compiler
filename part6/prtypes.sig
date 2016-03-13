signature PRINTTYPES =
sig
    val asString: Types.ty -> string
    val print: TextIO.outstream * Types.ty -> unit
end

