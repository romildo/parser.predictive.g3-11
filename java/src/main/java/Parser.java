import java.io.IOException;

public class Parser {
   private Lexer lex;
   private Token tok;

   public Parser(Lexer lex) throws IOException {
      this.lex = lex;
      this.tok = lex.getToken();
   }

   private void error(Token.T[] expected) {
      StringBuilder b = new StringBuilder();
      if (expected.length > 0) {
         b.append(expected[0]);
         for (int i = 1; i < expected.length; i++)
            b.append(", ").append(expected[i]);
      }
      ErrorMsg.error(tok.line, tok.col, "syntax error", "expecting " + b.toString() + ", found " + tok.type);
      System.exit(3);
   }

   private void advance() throws IOException {
      tok = lex.getToken();
   }

   private void eat(Token.T t) throws IOException {
      if (tok.type == t)
         advance();
      else
         error(new Token.T[]{t});
   }

   private void S() throws IOException {
      switch (tok.type) {
         case IF:
            eat(Token.T.IF);
            E();
            eat(Token.T.THEN);
            S();
            eat(Token.T.ELSE);
            S();
            break;
         case BEGIN:
            eat(Token.T.BEGIN);
            S();
            L();
            break;
         case PRINT:
            eat(Token.T.PRINT);
            E();
            break;
         default:
            error(new Token.T[]{Token.T.IF, Token.T.BEGIN, Token.T.PRINT});
      }
   }

   private void L() throws IOException {
      switch (tok.type) {
         case END:
            eat(Token.T.END);
            break;
         case SEMI:
            eat(Token.T.SEMI);
            S();
            L();
            break;
         default:
            error(new Token.T[]{Token.T.END, Token.T.SEMI});
      }
   }

   private void E() throws IOException {
      eat(Token.T.NUM);
      eat(Token.T.EQ);
      eat(Token.T.NUM);
   }

   public void parse() throws IOException {
      S();
      eat(Token.T.EOF);
   }
}
