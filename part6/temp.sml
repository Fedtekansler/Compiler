(* make this an abstraction sometime *)
structure Temp : TEMP =
struct

type temp = int

local
    val temps = ref 100
in
    fun newtemp () =
        let
            val t = !temps
        in
            temps := t+1; t
        end
(* add this function to temp.sml *)
    fun forcetemp n = (if (!temps)<=n then temps := n+1 else (); n)
end

structure Table = IntMapTable (type key = int fun getInt n = n)

fun makestring t = "t" ^ Int.toString t

type label = Symbol.symbol

local
    structure F = Format
    fun postinc x = let val i = !x in x := i+1; i end
    val labs = ref 0
in
    fun newLabel s =
        let
            val front = F.format "L%d" [F.INT (postinc labs)]
            val back = if s = "" then "" else "_" ^ s
        in
            Symbol.symbol (front ^ back)
        end
    val namedLabel = Symbol.symbol
end

val topLabel = namedLabel "tigermain"

end (* Temp *)

