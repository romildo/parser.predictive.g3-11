
let main () =
  try
    Parser.prog
      (Parser.parsebuf_of_lexbuf
         (Lexing.from_channel stdin)
         Lexer.get_token);
    print_endline "compilation succeeded"
  with
  | Lexer.Lex msg -> Printf.eprintf "lexical error: %s\n" msg
  | Parser.Syntax msg -> Printf.eprintf "syntax error: %s\n" msg

let _ = main ()
