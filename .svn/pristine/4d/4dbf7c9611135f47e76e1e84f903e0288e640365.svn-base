structure PrintTypes: PRINTTYPES =
struct

structure T = Types

val indentStep = 2
val nameUnfoldMax = 0

fun indentString n = 
    if n <= 0 then "" else " " ^ (indentString (n-1))

fun asStringI indent (T.RECORD (fields, uniq)) =
    let fun fieldString indent (s, ty) =
            (indentString indent) ^
            (Symbol.name s) ^ ": " ^
            (asStringI indent ty) ^ "\n"
        val fieldsString = map (fieldString (indent+indentStep)) fields
    in  "RECORD\n" ^ (concat fieldsString) ^ (indentString indent) ^ "END"
    end
  | asStringI indent T.NIL = "NIL"
  | asStringI indent T.INT = "INT"
  | asStringI indent T.STRING = "STRING"
  | asStringI indent (T.ARRAY (ty1, uniq)) = 
    "ARRAY of " ^ (asStringI indent ty1)
  | asStringI indent (T.NAME (s, tyor)) =
    if indent <= nameUnfoldMax*indentStep then
        let val tyAsStringI =
                case !tyor of
                    SOME ty => asStringI indent ty
                  | NONE => "(NONE)"
        in  "NAME " ^ (Symbol.name s) ^ " = " ^ tyAsStringI
        end
    else "NAME " ^ (Symbol.name s)
  | asStringI indent T.UNIT = "UNIT"
  | asStringI indent T.ERROR = "ERROR"

fun asString ty = asStringI 0 ty

fun print (outstream, ty) =
    let fun say s =  TextIO.output (outstream, s)
        fun sayln s = (say s; say "\n")
    in 
        sayln (asString ty)
    end

end (* PrintTypes *)

