
   
import java_cup.runtime.*;
      
%%
%class Lexer

%line
%column
%cup
   

%{   
    
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    private Symbol symbol(int type, Object value) {	  
    	return new Symbol(type, yyline, yycolumn, value);
    }
    
%}
   
LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
digito= [1-6]
pR= "parrafo" | "label" 

texto  = "\"" ~"\""
%%  
   /* YYINITIAL is the state */
   
<YYINITIAL> {
   
    ";"                { return symbol(sym.SEMI); }
    ","                { return symbol(sym.COMA); }
    "+"				   { return symbol(sym.UNION); }
    "("                { return symbol(sym.LPAREN); }
    ")"                { return symbol(sym.RPAREN); }
    "titulo"           { return symbol(sym.TITULO); }
    "imagen"           { return symbol(sym.IMAGEN); }
    "encabezado"       { return symbol(sym.ENCABEZADO); }
    "vinculo"          { return symbol(sym.VINCULO); }
    "contenedor"       { return symbol(sym.CONTENEDOR); }
    "aTexto"           { return symbol(sym.ATEXTO); }
    "tabla"			   { return symbol(sym.TABLA); }
    "formulario"	   { return symbol(sym.FORMULARIO); }	
    "$"                { return symbol(sym.FIN); }
    
   
   
   	{pR}		  { return symbol(sym.PR, yytext()); }
   	{digito}	  { return symbol(sym.DIGITO, yytext()); }
   	{texto}		  { return symbol(sym.TEXTO, yytext()); }
   	
    {WhiteSpace}       { /* do nothing */ }   
}

[^]                    { throw new Error("Illegal character <"+yytext()+">"); }
