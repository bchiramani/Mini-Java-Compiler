%option yylineno
delim     [ \t]
bl        {delim}+
chiffre   [0-9]
lettre    [a-zA-Z]
id        {lettre}({lettre}|{chiffre})*
nb        ("-")?{chiffre}+("."{chiffre}+)?(("E"|"e")"-"?{chiffre}+)?
iderrone  {chiffre}({lettre}|{chiffre})*
ouvrante  (\()
fermante  (\))
COMMENT_LINE        "//"
COMMENT     "\/\*([^*]|\*+[^*\/])*\*+\/"

%%

{bl}             /* pas d'actions */
"class"          printf(" Class"); 
"public"         printf(" Identifier"); 
"static"         printf(" Identifier"); 
"void"           printf(" Identifier"); 
"main"           printf(" Identifier"); 
"extends"        printf(" Identifier"); 
"return"         printf(" RETURN"); 
"this"           printf(" Identifier"); 
"\n" 			 ++yylineno;
"{"              printf(" LBRACE"); 
"}"              printf(" RBRACE"); 
"("              printf(" LPAREN"); 
")"              printf(" RPAREN"); 
"["              printf(" LBRACKET"); 
"]"              printf(" RBRACKET"); 
";"              printf(" SEMICOLON"); 
","              printf(" COMMA"); 
"."              printf(" DOT"); 
{COMMENT_LINE}   printf("COMMENT_LINE");
{COMMENT}        printf("MULTI_LINE_COMMENT");
{nb}             printf(" Number ");
"="              printf(" OPPAFFECT ");
"int"            printf(" Type"); 
"boolean"        printf(" Type"); 
"int[]"          printf(" Type"); 
"if"             printf(" IF"); 
"else"           printf("turn ELSE"); 
"while"          printf(" WHILE"); 
"true"           printf(" TRUE"); 
"false"          printf(" FALSE"); 
{iderrone}       {fprintf(stderr,"illegal identifier \'%s\' on line :%d\n",yytext,yylineno);}



%%

int main(int argc, char *argv[]) 
{
     yyin = fopen(argv[1], "r");
     yylex();
     fclose(yyin);
}

int yywrap()
{
	return(1);
}

