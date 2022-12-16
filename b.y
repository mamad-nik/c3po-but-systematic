%{
#include<stdio.h>
int yylex();
int yyerror(char *s);
int err;
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
		 | REF DOT ID 
		 | ID DOT ID 
		 ;
Statement: Type ID ASSIGN Expression EOL 
		 | Reference ASSIGN Expression EOL 
		 | KEYWORD OPENPAR Condition CLOSEPAR  OPCURBR Statement CLCURBR  
		 | Ifstatement
		 | ID ASSIGN Expression EOL
		 ;
Ifstatement:  'i''f' OPENPAR Condition CLOSEPAR OPCURBR Statement CLCURBR 'e''l''s''e'  OPCURBR Statement CLCURBR  
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
         | Expression RELOP Factor
		 | Expression EQUAL Factor 
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

  yyparse();
  if( err == 0) printf("parse complited successfully; there was no errors.\n");
}

int yyerror(char *s)
{
  err = 1;
  fprintf(stderr, "error: %s\n", s);
}



