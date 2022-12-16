%{
#include<stdio.h>
int yylex();
int yyerror(char *s);
extern FILE* yyin;
%}
%token CLASS KEYWORD PROTECT PRIM STATIC REF
%token ASSIGN RELOP EQUAL LOGOP ARIOP COMMENT
%token DOT RETURNSTMT EOL OPENPAR CLOSEPAR OPCURBR
%token CLCURBR OPBR CLBR QOUMA ID NUM VAL

%%
Program: 
    |Program ClassDeclaration EOL
	;
ClassDeclaration: CLASS ID OPCURBR Declaration CLCURBR
	;
Declaration: 
	| Declaration FieldDeclaration
	| Declaration MethodDeclaration	 
	;
FieldDeclaration: Declarators ID
	;
MethodDeclaration: Declarators ID OPENPAR ParameterList CLOSEPAR OPCURBR Statements Return CLCURBR
				 ;
Declarators: Protection Staticality Type
		   ;
Statements: 
		  | Statements Statement
		  ;
Return:
	  |  RETURNSTMT ID EOL
	  |  RETURNSTMT NUM EOL
	  ;
Protection:
		  | PROTECT
		  ;
Staticality:
		   | STATIC
		   ;
Type: Primtype 
	| Arrtype
	;
Primtype: PRIM
		;
Classtype: ID
		 ;
Arrtype: Primtype OPBR CLBR
	   | Classtype OPBR CLBR
	   ;
ParameterList:
			 | Type ID 
			 | ParameterList ',' Type ID
			 ;
Reference: REF
		 | ID
		 | REF DOT ID
		 | ID DOT ID
		 ;
Statement: OPCURBR Statement CLCURBR
		 | Type ID ASSIGN Expression EOL 
		 | Reference ASSIGN Expression EOL
		 | KEYWORD OPENPAR Expression CLOSEPAR Statement
		 | 'i''f' OPENPAR Expression CLOSEPAR OPCURBR Statement CLCURBR 'e''l''s''e' Statement
		 ;
Expression:	
	  	  |  Factor
		  |  Unary
		  |  Condition
		  |  OPENPAR Expression CLOSEPAR
		  |  'n''e''w' ID
		  |  PRIM OPBR Condition CLBR 
		  |  ID OPBR Condition CLBR
  		  ;
Condition: VAL 
	 | Expression LOGOP Factor
         | Expression ARIOP Factor
	 ;
Unary: '-' Factor
     ;
Factor: NUM
      | ID
      ;	
%%
int main(int argc, char **argv)
{ 

 if(argc > 1) {
	if(!(yyin = fopen(argv[1], "r"))) {
		perror(argv[1]);
	return (1);
	}
 } 
  printf("> "); 
  yyparse();
}

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}



