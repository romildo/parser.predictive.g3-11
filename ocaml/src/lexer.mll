{
  open Token

  exception Lex of string

  let fail msg = raise (Lex msg)
}

let dig = [ '0' - '9' ]

rule get_token = parse
| [ ' ' '\t' '\n' ] { get_token lexbuf            }
| "if"              { TIf                         }
| "then"            { TThen                       }
| "else"            { TElse                       }
| "begin"           { TBegin                      }
| "end"             { TEnd                        }
| "print"           { TPrint                      }
| ";"               { TSemi                       }
| "="               { TEq                         }
| dig+ as str       { TNum (int_of_string str)    }
| eof               { TEOF                        }
| _                 { fail (Printf.sprintf
                             "at offset %d: unexpected character '%c'"
                             (Lexing.lexeme_start lexbuf)
                             (Lexing.lexeme_char lexbuf 0))
                    }
