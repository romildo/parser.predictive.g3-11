(* Analisador sintático para a linguagem da gramática 3.11 do livro do
Appel *)

open Token

type parsebuf = { lexbuf : Lexing.lexbuf;
                  next_token : Lexing.lexbuf -> token;
                  mutable tok : token
                }

let parsebuf_of_lexbuf lb token =
  { lexbuf = lb;
    next_token = token;
    tok = token lb
  }

let rec intersperse sep = function
  | [] -> ""
  | [s] -> s
  | s::others -> s ^ sep ^ intersperse sep others

exception Syntax of string

let error tokens_expected token_found =
  raise
    (Syntax
       (Printf.sprintf
          "expected %s, but found %s"
          (intersperse ", " (List.map show_token tokens_expected))
          (show_token token_found)))

let advance pb =
  pb.tok <- pb.next_token pb.lexbuf

let eat pb tok =
  if same_token_type pb.tok tok then
    advance pb
  else
    error [tok] pb.tok

let rec s pb =
  match pb.tok with
  | TIf -> advance pb; e pb; eat pb TThen; s pb; eat pb TElse; s pb
  | TBegin -> advance pb; s pb; l pb
  | TPrint -> advance pb; e pb
  | _ -> error [TIf; TBegin; TPrint] pb.tok

and l pb =
  match pb.tok with
  | TEnd -> advance pb
  | TSemi -> advance pb; s pb; l pb
  | _ -> error [TEnd; TSemi] pb.tok

and e pb =
  eat pb (TNum 0); eat pb TEq; eat pb (TNum 0)

and prog pb =
  s pb; eat pb TEOF
