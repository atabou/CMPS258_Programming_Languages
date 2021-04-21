
%{

#include "tree.h"

#include <stdio.h>

extern FILE *yyin;
FILE* outFile;

int yylex();
void yyerror(const char* s);

%}

%union{
    char*           idName;
    unsigned int    constVal;
    BindingList*    bindingList;
    Binding*        binding;
    Expr*           expr;
    bool            boolVal;
}

/* Terminals */
%token              VAL
%token              FUN
%token              ANDALSO
%token              ORELSE
%token              IF
%token              THEN
%token              ELSE

%token <idName>     ID

%token <constVal>   INT_CONST
%token <boolVal>    TRUE
%token <boolVal>    FALSE

%token              EQ
%token              PLUS
%token              MINUS
%token              MULT
%token              DIV
%token              GREATERTHAN
%token              LESSTHAN
%token              OPENPARENTH
%token              CLOSEPARENTH

/* Non-terminals */
%type <bindingList> binding_list
%type <binding>     binding
%type <expr>        expr
%type <expr>        op_expr
%type <expr>        call_expr
%type <expr>        basic_expr

/* Start Symbol */
%start              program

/* Precedence and Associativity */
%left               ORELSE
%left               ANDALSO
%left               GREATERTHAN LESSTHAN
%left               PLUS MINUS
%left               MULT DIV

%%
/* Production Rules and Actions */

program:        binding_list                { printBindingList($1, outFile); }
              | /* empty */                 { }
              ;

binding_list:   binding_list binding        { $$ = mergeBindingListAndBinding($1, $2); }
              | binding                     { $$ = createBindingListFromBinding($1); }
              ;

binding:        VAL ID expr               { $$ = createVariableBinding($2, $3); }
              | FUN ID ID expr            { $$ = createFunctionBinding($2, $3, $4); }
              ;

expr:           IF expr THEN expr ELSE expr { $$ = createIfThenElseExpr($2, $4, $6); }
              | op_expr                     { $$ = $1 }
              ;

op_expr:        op_expr PLUS op_expr           { $$ = createAddExpr($1, $3); }
              | op_expr MINUS op_expr           { $$ = createSubExpr($1, $3); }
              | op_expr MULT op_expr           { $$ = createMulExpr($1, $3); }
              | op_expr DIV op_expr           { $$ = createDivExpr($1, $3); }
              | op_expr GREATERTHAN op_expr           { $$ = createGreaterThanExpr($1, $3); }
              | op_expr LESSTHAN op_expr           { $$ = createLessThanExpr($1, $3); }
              | op_expr ANDALSO op_expr     { $$ = createAndExpr($1, $3); }
              | op_expr ORELSE op_expr      { $$ = createOrExpr($1, $3); }
              | call_expr                   { $$ = $1 }
              ;

call_expr:      call_expr basic_expr        { $$ = createCallExpr($1, $2); }
              | basic_expr                  { $$ = $1 }
              ;

basic_expr:     expr                        { $$ = createParenthesesExpr($1); }
              | ID                          { $$ = createIDExpr($1); }
              | INT_CONST                   { $$ = createIntConstExpr($1); }
              | TRUE                        { $$ = createTrueExpr($1); }
              | FALSE                       { $$ = createFalseExpr($1); }
              ;

%%

#include <stdlib.h>
int main(int argc, char **argv){
    const char* inFileName = (argc > 1)?argv[1]:"test.sml";
    const char* outFileName = (argc > 2)?argv[2]:"test.dot";
    yyin = fopen(inFileName, "r");
    outFile = fopen(outFileName, "w");
    fprintf(outFile, "digraph tree {\n");
    do {
        yyparse();
    } while(!feof(yyin));
    fprintf(outFile, "}\n");
    fclose(yyin);
    fclose(outFile);
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}

