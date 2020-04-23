/*
Houman Eskandani
Project1
April 1
*/

%{
   int currLine = 1, currPos = 1;
   int numNumbers = 0;
   int numOperators = 0;
   int numParens = 0;
   int numBrackets = 0;
   int numEquals = 0;
   int numSemicolons = 0;
   int numAssigns = 0;
   int numCommas = 0;
   int numColons = 0;
%}

DIGIT    [0-9]
IDENT [a-zA-Z][_a-zA-Z0-9]* 
COMMENT ##.*\n
ERR3 [0-9][a-zA-Z] 

%%

"-"            {printf("SUB\n"); currPos += yyleng; numOperators++;}
"+"            {printf("ADD\n"); currPos += yyleng; numOperators++;}
"*"            {printf("MULT\n"); currPos += yyleng; numOperators++;}
"/"            {printf("DIV\n"); currPos += yyleng; numOperators++;}
"="            {printf("EQUAL\n"); currPos += yyleng; numEquals++;}
"("            {printf("L_PAREN\n"); currPos += yyleng; numParens++;}
")"            {printf("R_PAREN\n"); currPos += yyleng; numParens++;}
"["            {printf("L_SQUARE_BRACKET\n");numBrackets++;}
"]"            {printf("R_SQUARE_BRACKET\n");numBrackets++;}
"%"            {printf("MOD\n"); currPos += yyleng; numOperators++;}
"<>"           {printf("NEQ\n"); currPos += yyleng; numOperators++;}
"=="           {printf("EQ\n"); currPos += yyleng; numOperators++;}
">="           {printf("GTE\n"); currPos += yyleng; numOperators++;}
"<="           {printf("LTE\n"); currPos += yyleng; numOperators++;}
"<"            {printf("LT\n"); currPos += yyleng; numOperators++;}
">"            {printf("GT\n"); currPos += yyleng; numOperators++;}
";"            {printf("SEMICOLON\n"); currPos += yyleng; numSemicolons++;}
":"            {printf("COLON\n"); currPos += yyleng; numColons++;}
","            {printf("COMMA\n"); currPos += yyleng; numCommas++;}
":="           {printf("ASSIGN\n"); currPos += yyleng; numAssigns++;}

"function"      {printf("FUNCTION\n"); currPos += yyleng;}
"beginparams"   {printf("BEGIN_PARAMS\n"); currPos += yyleng;}
"endparams"     {printf("END_PARAMS\n"); currPos += yyleng;}
"beginlocals"   {printf("BEGIN_LOCALS\n"); currPos += yyleng;}
"endlocals"     {printf("END_LOCALS\n"); currPos += yyleng;}
"beginbody"     {printf("BEGIN_BODY\n"); currPos += yyleng;}
"endbody"       {printf("END_BODY\n"); currPos += yyleng;}
"integer"       {printf("INTEGER\n"); currPos += yyleng;}
"array"         {printf("ARRAY\n"); currPos += yyleng;}
"of"            {printf("OF\n"); currPos += yyleng;}
"if"            {printf("IF\n"); currPos += yyleng;}
"then"          {printf("THEN\n"); currPos += yyleng;}
"endif"         {printf("ENDIF\n"); currPos += yyleng;}
"else"          {printf("ELSE\n"); currPos += yyleng;}
"while"         {printf("WHILE\n"); currPos += yyleng;}
"do"            {printf("DO\n"); currPos += yyleng;}
"for"           {printf("FOR\n"); currPos += yyleng;}
"beginloop"     {printf("BEGINLOOP\n"); currPos += yyleng;;}
"endloop"       {printf("ENDLOOP\n"); currPos += yyleng;}
"continue"      {printf("CONTINUE\n"); currPos += yyleng;}
"read"          {printf("READ\n"); currPos += yyleng;}
"write"         {printf("WRITE\n"); currPos += yyleng;}
"and"           {printf("AND\n"); currPos += yyleng;}
"or"            {printf("OR\n"); currPos += yyleng;}
"not"           {printf("NOT\n"); currPos += yyleng;}
"true"          {printf("TRUE\n"); currPos += yyleng;}
"false"         {printf("FALSE\n"); currPos += yyleng;}
"return"        {printf("RETURN\n"); currPos += yyleng;}



([a-zA-Z]*_)|([0-9]*_) {printf("Error at line %d, column %d: identifier \"%s\"  cannot end with an underscore \n", currLine, currPos, yytext); exit(0);}

{ERR3}          {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter \n", currLine, currPos, yytext); exit(0);}

{COMMENT}       {currLine++; currPos = 1;}

{IDENT}         {printf("IDENT %s\n", yytext); currPos += yyleng;}

(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?[0-9]+)?)   {printf("NUMBER %s\n", yytext); currPos += yyleng; numNumbers++;}

[ \t]+         {/* ignore spaces */ currPos += yyleng;}

"\n"           {currLine++; currPos = 1;}

.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%

int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
      yyin = fopen(argv[1], "r");
      if(yyin == NULL)
      {
         yyin = stdin;
      }
   }
   else
   {
      yyin = stdin;
   }

   yylex();

   printf("# Numbers: %d\n", numNumbers);
   printf("# Operators: %d\n", numOperators);
   printf("# Parentheses: %d\n", numParens);
   printf("# Equal Signs: %d\n", numEquals);
   printf("# Brackets: %d\n", numBrackets);
   printf("# Semicolons: %d\n", numSemicolons);
   printf("# numAssigns: %d\n", numAssigns);
   printf("# numCommas: %d\n", numCommas);
   printf("# numColons: %d\n", numColons);
}
