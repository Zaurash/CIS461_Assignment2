CUPHOME = ./lib
CUP = java -cp $(CUPHOME)/java-cup-11b.jar java_cup.Main 
CUPLIB = ./lib/java-cup-11b-runtime.jar
JFLEX = ./tools/jflex-1.6.1/bin/jflex

LIBS = $(CUPLIB)

all: scanner_driver.class

%.class:	%.java
	javac -cp .:$(CUPLIB) $<

lex_scanner.java: lex_scanner.l  sym.java
	$(JFLEX) lex_scanner.l

scanner_driver.class: lex_scanner.class

scanner: scanner_driver.class lex_scanner.class 

#=================

clean: ; rm *.class parser.java lex_scanner.java *~