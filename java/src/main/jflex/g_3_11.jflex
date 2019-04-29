/* -*-Mode: java-*- */

%%

%public
%class Lexer
%type Token
%function getToken
%line
%column

%{  
    private Token tok(Token.T typ, Object val) {
        return new Token(typ, val, yyline, yycolumn);
    }

    private Token tok(Token.T typ) {
        return tok(typ, null);
    }
    
    private void error(String msg) {
    	ErrorMsg.error(yyline, yycolumn, "lexical error", msg);
    }
%}

%%

[ \t\f\n\r]+          { /* skip */ }

"if"                  { return tok(Token.T.IF); }
"then"                { return tok(Token.T.THEN); }
"else"                { return tok(Token.T.ELSE); }
"begin"               { return tok(Token.T.BEGIN); }
"end"                 { return tok(Token.T.END); }
"print"               { return tok(Token.T.PRINT); }

"="                   { return tok(Token.T.EQ); }
";"                   { return tok(Token.T.SEMI); }

0|[1-9][0-9]*         { return tok(Token.T.NUM, new Long(yytext())); }
                        
<<EOF>>               { return tok(Token.T.EOF); }

.                     { error("illegal character: " + yytext()); }
