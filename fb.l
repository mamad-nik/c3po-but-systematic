%{
#include "b.tab.h"
int lineno = 1;

%}
%%
"class"                 { return CLASS; }
"if"	                { return KEYWORD; }
"else"	                { return KEYWORD; }
"while"                 { return KEYWORD; }
"public"                { return PROTECT; }
"private"               { return PROTECT; }
"void"                  { return PRIM; }
"int"                   { return PRIM; }
"boolean"               { return PRIM; }
"static"                { return STATIC; }
"this"                  { return REF; }
"="                     { return ASSIGN; }
"=="                    { return EQUAL; }
">"                     { return RELOP; }
"<"                     { return RELOP; }
"<="                    { return RELOP; }
">="                    { return RELOP; }
"!="                    { return RELOP; }
"&&"                    { return LOGOP; }
"||"                    { return LOGOP; }
"!"                     { return LOGOP; }
"+"                     { return ARIOP; }
"-"                     { return ARIOP; }
"*"                     { return ARIOP; }
"/"                     { return ARIOP; }
"//"			        { return COMMENT; }
"." 	                { return DOT; }
"return"                { return RETURNSTMT; }
";"                     { return EOL; }
"("                     { return OPENPAR; }
")"                     { return CLOSEPAR; }
"{"                     { return OPCURBR; }
"}"                     { return CLCURBR; }
"["                     { return OPBR; }
"]"                     { return CLBR; }
"\""                    { return QOUMA; }
("true"|"false")      { return VAL; }
[a-zA-Z]([a-zA-Z0-9_])* { return ID; }
("+"|"-")?[0-9]+	    { return NUM; }
"\n"			        { lineno++;}	
(" "|"\t")		        ;
%%

