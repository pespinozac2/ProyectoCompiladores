package codigo;
import java_cup.runtime.*;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ ,\t,\r,\n]+
%{
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

{espacio} {/*Ignore*/}
"//"(.)* {/*Ignore*/}

/* Comillas */
( "\"" ) {return new Symbol(sym.Comillas, yychar, yyline, yytext());}

/* Tipos de datos */
( byte | char | long | float | double ) {return new Symbol(sym.T_dato, yychar, yyline, yytext());}
( "int" ) {return new Symbol(sym.Int, yychar, yyline, yytext());}
string {return new Symbol(sym.Cadena, yychar, yyline, yytext());}

/*Palabras reservadas*/
if {return new Symbol(sym.If, yychar, yyline, yytext());}
else {return new Symbol(sym.Else, yychar, yyline, yytext());}
elseif {return new Symbol(sym.Elseif, yychar, yyline, yytext());}
for {return new Symbol(sym.For, yychar, yyline, yytext());}
while {return new Symbol(sym.While, yychar, yyline, yytext());}
do {return new Symbol(sym.Do, yychar, yyline, yytext());}
return {return new Symbol(sym.Return, yychar, yyline, yytext());}
break {return new Symbol(sym.Break, yychar, yyline, yytext());}

/*Constantes*/
( true | false ) {return new Symbol(sym.Op_booleano, yychar, yyline, yytext());}
null {return new Symbol(sym.NULL, yychar, yyline, yytext());}
pi {return new Symbol(sym.PI, yychar, yyline, yytext());}
max_int {return new Symbol(sym.MAX_INT, yychar, yyline, yytext());}

/*Operadores*/
/*Operadores Relacionales */
( ">" | "<" | "==" | "!=" | ">=" | "<=" ) {return new Symbol(sym.Op_relacional, yychar, yyline, yytext());}

/* Operadores Incremento y decremento */
( "++" | "--" ) {return new Symbol(sym.Op_incremento, yychar, yyline, yytext());}

"=" {return new Symbol(sym.Igual, yychar, yyline, yytext());}
"+" {return new Symbol(sym.Suma, yychar, yyline, yytext());}
"-" {return new Symbol(sym.Resta, yychar, yyline, yytext());}
"*" {return new Symbol(sym.Multiplicacion, yychar, yyline, yytext());}
"/" {return new Symbol(sym.Division, yychar, yyline, yytext());}
"(" {return new Symbol(sym.Parentesis_a, yychar, yyline, yytext());}
")" {return new Symbol(sym.Parentesis_c, yychar, yyline, yytext());}
"{" {return new Symbol(sym.Llave_a, yychar, yyline, yytext());}
"}" {return new Symbol(sym.Llave_c, yychar, yyline, yytext());}
"main" {return new Symbol(sym.Main, yychar, yyline, yytext());}
";" {return new Symbol(sym.P_coma, yychar, yyline, yytext());}
{L}({L}|{D})* {return new Symbol(sym.Identificador, yychar, yyline, yytext());}
("(-"{D}+")")|{D}+ {return new Symbol(sym.Numero, yychar, yyline, yytext());}
 . {return new Symbol(sym.ERROR, yychar, yyline, yytext());}