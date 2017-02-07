import java.io.*;

public class scanner_driver {
  static public void main(String argv[]) {    
    /* Start the parser */
	System.out.println("Beginning parse ...");
    try {
      parser p = new parser(new Lexer(new FileReader(argv[0])));
      Object result = p.parse().value;      
    } catch (Exception e) {
      /* do cleanup here -- possibly rethrow e */
      e.printStackTrace();
    }
  }
}