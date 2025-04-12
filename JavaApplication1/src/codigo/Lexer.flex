package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ ,\t,\r]+
%{
    public String lexeme;
%}
%%

{espacio} {/*Ignore*/}
"//"(.)* {/*Ignore*/}

/* Comillas */
( "\"" ) {lexeme=yytext(); return Comillas;}

/* Tipos de datos */
( byte | int | char | long | float | double ) {lexeme=yytext(); return T_dato;}
string {lexeme=yytext(); return Cadena;}

/*Palabras Reservadas*/
if {lexeme=yytext(); return If;}
else {lexeme=yytext(); return Else;}
elseif {lexeme=yytext(); return Elseif;}
for {lexeme=yytext(); return For;}
while {lexeme=yytext(); return While;}
( do ) {lexeme=yytext(); return Do;}
( return ) {lexeme=yytext(); return Do;}
( break ) {lexeme=yytext(); return Do;}

/* Constantes */
(true | false) {lexeme = yytext(); return Op_booleano;}
(null) {lexeme = yytext(); return NULL;}
(pi) {lexeme = yytext(); return PI;}
(max_int) {lexeme = yytext(); return MAX_INT;}

/*Operadores*/
/*Operadores Relacionales */
( ">" | "<" | "==" | "!=" | ">=" | "<=") {lexeme = yytext(); return Op_relacional;}

/* Operadores Incremento y decremento */
( "++" | "--" ) {lexeme = yytext(); return Op_incremento;}

"\n" {return Linea;}
"=" {lexeme=yytext(); return Igual;}
"+" {lexeme=yytext(); return Suma;}
"-" {lexeme=yytext(); return Resta;}
"*" {lexeme=yytext(); return Multiplicacion;}
"/" {lexeme=yytext(); return Division;}
"(" {lexeme=yytext(); return Parentesis_a;}
")" {lexeme=yytext(); return Parentesis_c;}
"{" {lexeme=yytext(); return Llave_a;}
"}" {lexeme=yytext(); return Llave_c;}

"main" {lexeme=yytext(); return Main;}
";" {lexeme=yytext(); return P_coma;}
{L}({L}|{D})* {lexeme=yytext(); return Identificador;}
("(-"{D}+")")|{D}+ {lexeme=yytext(); return Numero;}
 . {return ERROR;}