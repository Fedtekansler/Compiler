signature TABLE =
sig
   type key
   type 'a table
   val empty      : 'a table
   val enter      : 'a table * key * 'a -> 'a table
   val look       : 'a table * key -> 'a option
   val numItems   : 'a table -> int
   val fromList   : (key * 'a) list -> 'a table
end

