import java_cup.runtime.*;

%%

%class Lexer
%line
%column
%unicode
%cup

%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

Identifier = [:jletter:] [:jletterdigit:]*
DittoInteger = 0 | [1-9][0-9]*

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
CommentContent       = ( [^*] | \*+ [^/*] )*

Comment = {TraditionalComment} | {EndOfLineComment}

Trips = [\"][\"][\"]

%state STRING
%state TRIPSTRING

%%

/* White Space */
{WhiteSpace} {/* ignore */}

/* Keywords */
<YYINITIAL> "class" {System.out.println(yyline + " CLASS " + "\"" + yytext() + "\""); return symbol(sym.CLASS);}
<YYINITIAL> "def" {System.out.println(yyline + " DEF " + "\"" + yytext() + "\""); return symbol(sym.DEF);}
<YYINITIAL> "extends" {System.out.println(yyline + " EXTENDS " + "\"" + yytext() + "\""); return symbol(sym.EXTENDS);}
<YYINITIAL> "if" {System.out.println(yyline + " IF " + "\"" + yytext() + "\""); return symbol(sym.IF);}
<YYINITIAL> "elif" {System.out.println(yyline + " ELIF " + "\"" + yytext() + "\""); return symbol(sym.ELIF);}
<YYINITIAL> "else" {System.out.println(yyline + " ELSE " + "\"" + yytext() + "\""); return symbol(sym.ELSE);}
<YYINITIAL> "while" {System.out.println(yyline + " WHILE " + "\"" + yytext() + "\""); return symbol(sym.WHILE);}
<YYINITIAL> "return" {System.out.println(yyline + " RETURN " + "\"" + yytext() + "\""); return symbol(sym.RETURN);}
/* <YYINITIAL> "String" {System.out.println(yyline + " STRING " + "\"" + yytext() + "\""); return symbol(sym.STRING);} */
/* <YYINITIAL> "Integer" {System.out.println(yyline + " INTEGER " + "\"" + yytext() + "\""); return symbol(sym.INTEGER);} */
<YYINITIAL> "and" {System.out.println(yyline + " AND " + "\"" + yytext() + "\""); return symbol(sym.AND);}
<YYINITIAL> "or" {System.out.println(yyline + " OR " + "\"" + yytext() + "\""); return symbol(sym.OR);}
<YYINITIAL> "not" {System.out.println(yyline + " NOT " + "\"" + yytext() + "\""); return symbol(sym.NOT);}
<YYINITIAL> "none" {System.out.println(yyline + " none " + "\"" + yytext() + "\""); return symbol(sym.none);}


/* Punctuation */
[+] {System.out.println(yyline + " PLUS " + "\"" + yytext() + "\""); return symbol(sym.PLUS);}
[-] {System.out.println(yyline + " MINUS " + "\"" + yytext() + "\""); return symbol(sym.MINUS);}
[*] {System.out.println(yyline + " TIMES " + "\"" + yytext() + "\""); return symbol(sym.TIMES);}
[/] {System.out.println(yyline + " DIVIDE " + "\"" + yytext() + "\""); return symbol(sym.DIVIDE);}
[\(] {System.out.println(yyline + " LPAREN " + "\"" + yytext() + "\""); return symbol(sym.LPAREN);}
[\)] {System.out.println(yyline + " RPAREN " + "\"" + yytext() + "\""); return symbol(sym.RPAREN);}
[\[] {System.out.println(yyline + " LBRACE " + "\"" + yytext() + "\""); return symbol(sym.LBRACE);}
[\]] {System.out.println(yyline + " RBRACE " + "\"" + yytext() + "\""); return symbol(sym.RBRACE);}
[\{] {System.out.println(yyline + " LBRACKET " + "\"" + yytext() + "\""); return symbol(sym.LBRACKET);}
[\}] {System.out.println(yyline + " RBRACKET " + "\"" + yytext() + "\""); return symbol(sym.RBRACKET);}
[,] {System.out.println(yyline + " COMMA " + "\"" + yytext() + "\""); return symbol(sym.COMMA);}
[;] {System.out.println(yyline + " SEMICOLON " + "\"" + yytext() + "\""); return symbol(sym.SEMICOLON);}
[.] {System.out.println(yyline + " DOT " + "\"" + yytext() + "\""); return symbol(sym.DOT);}
[:] {System.out.println(yyline + " COLON " + "\"" + yytext() + "\""); return symbol(sym.COLON);}
<YYINITIAL> "=" {System.out.println(yyline + " EQUALS " + "\"" + yytext() + "\""); return symbol(sym.EQUALS);}
<YYINITIAL> "==" {System.out.println(yyline + " EQUALS " + "\"" + yytext() + "\""); return symbol(sym.EQUALS);}
<YYINITIAL> "<=" {System.out.println(yyline + " ATMOST " + "\"" + yytext() + "\""); return symbol(sym.ATMOST);}
<YYINITIAL> "<" {System.out.println(yyline + " LESS " + "\"" + yytext() + "\""); return symbol(sym.LESS);}
<YYINITIAL> ">=" {System.out.println(yyline + " ATLEAST " + "\"" + yytext() + "\""); return symbol(sym.ATLEAST);}
<YYINITIAL> ">" {System.out.println(yyline + " MORE " + "\"" + yytext() + "\""); return symbol(sym.MORE);}

/* Identifiers */
<YYINITIAL> {Identifier} {System.out.println(yyline + " IDENT " + "\"" + yytext() + "\""); return symbol(sym.IDENT);}


/* Ditto Integers */
<YYINITIAL> {DittoInteger} {System.out.println(yyline + " INT " + "\"" + yytext() + "\""); return symbol(sym.INT);}


/* Comments */
{Comment} { /* ignore */ }


/* Strings */

<YYINITIAL> [\"] {string.setLength(0); yybegin(STRING);}
<YYINITIAL> {Trips} {string.setLength(0); yybegin(STRING);}


<STRING> {
  \" {yybegin(YYINITIAL); System.out.println(yyline + " STRING " + "\"" + string.toString() + "\""); return symbol(sym.STRING);}
  {Trips} {yybegin(YYINITIAL); System.out.println(yyline + " STRING " + "\"" + string.toString() + "\""); return symbol(sym.STRING);}
  [^\n\r\"\\]+ { string.append( yytext() ); }
  \\0 {string.append('\0');}
  \\b {string.append('\b');}
  \\t {string.append('\t');}
  \\n {string.append('\n');}
  \\r {string.append('\r');}
  \\f {string.append('\f');}
  \\\" {string.append('\"');}
  \\  {string.append('\\');}
}




