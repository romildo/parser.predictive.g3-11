
type token =
  | TIf
  | TThen
  | TElse
  | TBegin
  | TEnd
  | TPrint
  | TSemi
  | TEq
  | TNum of int
  | TEOF
[@@deriving show]

let same_token_type t1 t2 =
  match (t1, t2) with
  | (TNum _, TNum _) -> true
  | _                -> t1 = t2
