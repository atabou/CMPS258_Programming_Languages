
%{

#include "tree.h"
#include "parser.tab.h"

#include <stdio.h>
#include <string.h>

%}

%option noyywrap

ID  [a-zA-Z_][a-zA-Z_0-9]*

%%
    /* Rules for keywords */
val             { return VAL; }
fun             { return FUN; }
andalso         { return ANDALSO; }
orelse          { return ORELSE; }
if              { return IF; }
then            { return THEN; }
else            { return ELSE; }

    /* Rules for identifiers */
{ID}            { yylval.idName = strdup(yytext); return ID; }

    /* Rules for integer and boolean literals */
[0-9]+          { return INT_CONST; }
true            { return TRUE; } 
false           { return FALSE; }

    /* Rules for operators and separators */
"="             { return EQ; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
">"             { return GREATERTHAN; }
"<"             { return LESSTHAN; }
"("             { return OPENPARENTH; }
")"             { return CLOSEPARENTH; }

    /* Rule for whitespace */
"\t"            /* DO NOTHING */
"\n"            /* DO NOTHING */
"\r"            /* DO NOTHING */
" "             /* DO NOTHING */

    /* Catch unmatched tokens */
.           { fprintf(stderr, "Unrecognized token: %s\n", yytext); }

%%

