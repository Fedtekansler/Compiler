structure Absyn =
struct

structure S = Symbol

type pos = int

datatype var = SimpleVar of S.symbol * pos
             | FieldVar of var * S.symbol * pos
             | SubscriptVar of var * exp * pos

and exp      = VarExp of var
             | NilExp
             | IntExp of int
             | StringExp of string * pos
             | CallExp of calldata
             | OpExp of opdata
             | RecordExp of rcxdata
             | SeqExp of (exp * pos) list
             | AssignExp of asxdata
             | IfExp of ifdata
             | WhileExp of whiledata
             | ForExp of fordata
             | BreakExp of pos
             | LetExp of letdata
             | ArrayExp of arxdata

and decl     = FunctionDec of fundecldata list
             | VarDec of vardecldata
             | TypeDec of tydecldata list

and ty       = NameTy of S.symbol * pos
             | RecordTy of fielddata list
             | ArrayTy of S.symbol * pos

and oper     = EqOp | NeqOp
             | LtOp | LeOp | GtOp | GeOp
             | PlusOp | MinusOp | TimesOp | DivideOp

withtype fielddata   = { name: S.symbol
                       , escape: bool ref
                       , typ: (S.symbol * pos)
                       , pos: pos}
and      fundecldata = { name: S.symbol
                       , params: fielddata list
                       , result: (S.symbol * pos) option
                       , body: exp
                       , pos: pos}
and      vardecldata = { name: S.symbol
                       , escape: bool ref
                       , typ: (S.symbol * pos) option
                       , init: exp
                       , pos: pos}
and      tydecldata  = { name: S.symbol
                       , ty: ty
                       , pos: pos}
and      fordata     = { var: S.symbol
                       , escape: bool ref
                       , lo: exp
                       , hi: exp
                       , body: exp
                       , pos: pos}
and      whiledata   = { test: exp
                       , body: exp
                       , pos: pos}
and      letdata     = { decls: decl list
                       , body: exp
                       , pos: pos}
and      ifdata      = { test: exp
                       , thn: exp
                       , els: exp option
                       , pos: pos}
and      calldata    = { func: S.symbol
                       , args: (exp * pos) list
                       , pos: pos}
and      opdata      = { left: exp
                       , oper: oper
                       , right: exp
                       , pos: pos}
and      arxdata     = { typ: S.symbol
                       , size: exp
                       , init: exp
                       , pos: pos}
and      asxdata     = { var: var
                       , exp: exp
                       , pos: pos}
and      rcxdata     = { fields: (S.symbol * exp * pos) list
                       , typ: S.symbol
                       , pos: pos}

end (* Absyn *)

