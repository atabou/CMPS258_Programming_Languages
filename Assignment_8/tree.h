
#include <stdio.h>

typedef struct BindingList BindingList;
typedef struct Binding Binding;
typedef struct Expr Expr;

BindingList* createBindingListFromBinding(Binding* b);
BindingList* mergeBindingListAndBinding(BindingList* lst, Binding* b);

Binding* createVariableBinding(char* varName, Expr* e);
Binding* createFunctionBinding(char* funcName, char* paramName, Expr* body);

Expr* createIfThenElseExpr(Expr* e1, Expr* e2, Expr* e3);
Expr* createAddExpr(Expr* e1, Expr* e2);
Expr* createSubExpr(Expr* e1, Expr* e2);
Expr* createMulExpr(Expr* e1, Expr* e2);
Expr* createDivExpr(Expr* e1, Expr* e2);
Expr* createGreaterThanExpr(Expr* e1, Expr* e2);
Expr* createLessThanExpr(Expr* e1, Expr* e2);
Expr* createAndExpr(Expr* e1, Expr* e2);
Expr* createOrExpr(Expr* e1, Expr* e2);
Expr* createCallExpr(Expr* e1, Expr* e2);
Expr* createParenthesesExpr(Expr* e);
Expr* createIDExpr(char* varName);
Expr* createIntConstExpr(unsigned int c);
Expr* createTrueExpr();
Expr* createFalseExpr();

void printBindingList(BindingList* lst, FILE* outFile);

