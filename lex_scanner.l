/* String,Integer,Obj,... should I not list them in identifiers even though they're predifined identifiers? */
/* Is this way of printing to out fine? */
/* In the makefile, the scanner keyword for executing doesn't seem to work */


import java_cup.runtime.*;

%%

%class lex_scanner
%line
%column
%unicode
%standalone

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
<YYINITIAL> "class" {System.out.println(yyline + " CLASS " + "\"" + yytext() + "\"");}
<YYINITIAL> "def" {System.out.println(yyline + " DEF " + "\"" + yytext() + "\"");}
<YYINITIAL> "extends" {System.out.println(yyline + " EXTENDS " + "\"" + yytext() + "\"");}
<YYINITIAL> "if" {System.out.println(yyline + " IF " + "\"" + yytext() + "\"");}
<YYINITIAL> "elif" {System.out.println(yyline + " ELIF " + "\"" + yytext() + "\"");}
<YYINITIAL> "else" {System.out.println(yyline + " ELSE " + "\"" + yytext() + "\"");}
<YYINITIAL> "while" {System.out.println(yyline + " WHILE " + "\"" + yytext() + "\"");}
<YYINITIAL> "return" {System.out.println(yyline + " RETURN " + "\"" + yytext() + "\"");}
<YYINITIAL> "String" {System.out.println(yyline + " STRING " + "\"" + yytext() + "\"");}
<YYINITIAL> "Integer" {System.out.println(yyline + " INTEGER " + "\"" + yytext() + "\"");}
<YYINITIAL> "Obj" {System.out.println(yyline + " OBJ " + "\"" + yytext() + "\"");}
<YYINITIAL> "Boolean" {System.out.println(yyline + " BOOLEAN " + "\"" + yytext() + "\"");}
<YYINITIAL> "true" {System.out.println(yyline + " TRUE " + "\"" + yytext() + "\"");}
<YYINITIAL> "false" {System.out.println(yyline + " FALSE " + "\"" + yytext() + "\"");}
<YYINITIAL> "and" {System.out.println(yyline + " AND " + "\"" + yytext() + "\"");}
<YYINITIAL> "or" {System.out.println(yyline + " OR " + "\"" + yytext() + "\"");}
<YYINITIAL> "not" {System.out.println(yyline + " NOT " + "\"" + yytext() + "\"");}
<YYINITIAL> "Nothing" {System.out.println(yyline + " NOTHING " + "\"" + yytext() + "\"");}
<YYINITIAL> "none" {System.out.println(yyline + " none " + "\"" + yytext() + "\"");}


/* Punctuation */
[+] {System.out.println(yyline + " PLUS " + "\"" + yytext() + "\"");}
[-] {System.out.println(yyline + " MINUS " + "\"" + yytext() + "\"");}
[*] {System.out.println(yyline + " TIMES " + "\"" + yytext() + "\"");}
[/] {System.out.println(yyline + " DIVIDE " + "\"" + yytext() + "\"");}
[\(] {System.out.println(yyline + " LPAREN " + "\"" + yytext() + "\"");}
[\)] {System.out.println(yyline + " RPAREN " + "\"" + yytext() + "\"");}
[\[] {System.out.println(yyline + " LBRACE " + "\"" + yytext() + "\"");}
[\]] {System.out.println(yyline + " RBRACE " + "\"" + yytext() + "\"");}
[\{] {System.out.println(yyline + " LBRACKET " + "\"" + yytext() + "\"");}
[\}] {System.out.println(yyline + " RBRACKET " + "\"" + yytext() + "\"");}
[,] {System.out.println(yyline + " COMMA " + "\"" + yytext() + "\"");}
[;] {System.out.println(yyline + " SEMICOLON " + "\"" + yytext() + "\"");}
[.] {System.out.println(yyline + " DOT " + "\"" + yytext() + "\"");}
[:] {System.out.println(yyline + " COLON " + "\"" + yytext() + "\"");}
<YYINITIAL> "=" {System.out.println(yyline + " EQUALS " + "\"" + yytext() + "\"");}
<YYINITIAL> "==" {System.out.println(yyline + " EQUALS " + "\"" + yytext() + "\"");}
<YYINITIAL> "<=" {System.out.println(yyline + " ATMOST " + "\"" + yytext() + "\"");}
<YYINITIAL> "<" {System.out.println(yyline + " LESS " + "\"" + yytext() + "\"");}
<YYINITIAL> ">=" {System.out.println(yyline + " ATLEAST " + "\"" + yytext() + "\"");}
<YYINITIAL> ">" {System.out.println(yyline + " MORE " + "\"" + yytext() + "\"");}


/* Identifiers */
<YYINITIAL> {Identifier} {System.out.println(yyline + " IDENT " + "\"" + yytext() + "\"");}


/* Ditto Integers */
<YYINITIAL> {DittoInteger} {System.out.println(yyline + " INT " + "\"" + yytext() + "\"");}


/* Comments */
{Comment} { /* ignore */ }


/* Strings */

<YYINITIAL> [\"] {string.setLength(0); yybegin(STRING);}
<YYINITIAL> {Trips} {string.setLength(0); yybegin(STRING);}


<STRING> {
  \" {yybegin(YYINITIAL); System.out.println(yyline + " STRING " + "\"" + string.toString() + "\"");}
  {Trips} {yybegin(YYINITIAL); System.out.println(yyline + " STRING " + "\"" + string.toString() + "\"");}
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


