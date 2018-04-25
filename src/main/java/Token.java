import java.util.Formatter;

public class Token {
   public enum T {IF, THEN, ELSE, BEGIN, END, PRINT, SEMI, EQ, NUM, EOF}

   public T type;
   public Object val;
   public int line;
   public int col;

   public Token(T type, Object val, int line, int col) {
      this.type = type;
      this.val = val;
      this.line = line;
      this.col = col;
   }

   public Token(T type, int line, int col) {
      this(type, null, line, col);
   }

   public String toString() {
      Formatter out = new Formatter();
      out.format("(%4d,%4d) %s", line, col, type);
      if (val != null)
         out.format(" [%s]", val);
      return out.toString();
   }
}
