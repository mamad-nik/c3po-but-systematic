%{
int lineno = 1;
%}
%%
"class"                 { printf("%d, %s, class\n",lineno,yytext); }
"if"	                { printf("%d, %s, keyword\n",lineno,yytext); }
"else"	                { printf("%d, %s, keyword\n",lineno,yytext); }
"while"                 { printf("%d, %s, keyword\n",lineno,yytext); }
"public"                { printf("%d, %s, protect\n",lineno,yytext); }
"private"               { printf("%d, %s, protect\n",lineno,yytext); }
"void"                  { printf("%d, %s, prim\n",lineno,yytext); }
"int"                   { printf("%d, %s, prim\n",lineno,yytext); }
"boolean"               { printf("%d, %s, prim\n",lineno,yytext); }
"static"                { printf("%d, %s, static\n",lineno,yytext); }
"this"                  { printf("%d, %s, ref\n",lineno,yytext); }
"="                     { printf("%d, %s, assign\n",lineno,yytext); }
">"                     { printf("%d, %s, relop\n",lineno,yytext); }
"<"                     { printf("%d, %s, relop\n",lineno,yytext); }
"=="                    { printf("%d, %s, equal\n",lineno,yytext); }
"<="                    { printf("%d, %s, relop\n",lineno,yytext); }
">="                    { printf("%d, %s, relop\n",lineno,yytext); }
"!="                    { printf("%d, %s, relop\n",lineno,yytext); }
"&&"                    { printf("%d, %s, logop\n",lineno,yytext); }
"||"                    { printf("%d, %s, logop\n",lineno,yytext); }
"!"                     { printf("%d, %s, logop\n",lineno,yytext); }
"+"                     { printf("%d, %s, ariop\n",lineno,yytext); }
"-"                     { printf("%d, %s, ariop\n",lineno,yytext); }
"*"                     { printf("%d, %s, ariop\n",lineno,yytext); }
"/"                     { printf("%d, %s, ariop\n",lineno,yytext); }
"//"			        { printf("%d, %s, comment\n",lineno,yytext); }
"\."	                { printf("%d, %s, dot\n",lineno,yytext); }
"return"                { printf("%d, %s, returnstmt\n",lineno,yytext); }
";"                     { printf("%d, %s, EOL\n",lineno,yytext); }
"("                     { printf("%d, %s, openpar\n",lineno,yytext); }
")"                     { printf("%d, %s, closepar\n",lineno,yytext); }
"{"                     { printf("%d, %s, opcurbr\n",lineno,yytext); }
"}"                     { printf("%d, %s, clcurbr\n",lineno,yytext); }
"["                     { printf("%d, %s, opbr\n",lineno,yytext); }
"]"                     { printf("%d, %s, clbr\n",lineno,yytext); }
"\""                    { printf("%d, %s, qouma\n",lineno,yytext); }
[a-zA-Z]([a-zA-Z0-9_])* { printf("%d, %s, ID\n",lineno,yytext); }
("+"|"-")?[0-9]+	{ printf("%d: %s, NUM\n",lineno,yytext); }
"\n"			{ lineno++;}	
(" "|"\t")		;
%%
int main(int argc, char **argv){
	if(argc > 1){
		if(!(yyin = fopen(argv[1], "r"))){
			perror(argv[1]);
			return (1);
			}
		}

	yylex();
	return 0;
}

