functor IntMapTable (type key
		     val getInt: key -> int) : TABLE =
struct

type key = key
type 'a table = 'a IntBinaryMap.map
val empty = IntBinaryMap.empty
fun enter (t, k, a) = IntBinaryMap.insert (t, getInt k, a)
fun look (t, k) = IntBinaryMap.find (t, getInt k)
val numItems = IntBinaryMap.numItems
fun fromList kas =
    let
        fun fromList1 [] t = t
          | fromList1 ((k, a)::kas) t = enter (fromList1 kas t, k, a)
    in
        fromList1 kas empty
    end

end (* IntMapTable *)

