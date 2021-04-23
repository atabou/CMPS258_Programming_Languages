
#include "tree.h"

#include <stdio.h>
#include <stdlib.h>

/* Structs */

struct BindingList {
    unsigned int id;
    BindingList* prevBindings;
    Binding* binding;
};

enum BindingKind { VAL_BINDING, FUN_BINDING };
struct Binding {
    unsigned int id;
    enum BindingKind kind;
    union {
        struct { unsigned int id2; char* varName; Expr* e; };
        struct { unsigned int id3; char* funcName; unsigned int id4; char* paramName; Expr* body; };
    };
};

enum ExprKind { IF_EXPR, ADD_EXPR, SUB_EXPR, MUL_EXPR, DIV_EXPR, GT_EXPR, LT_EXPR, AND_EXPR, OR_EXPR, CALL_EXPR, PAREN_EXPR, ID_EXPR, INT_CONST_EXPR, TRUE_EXPR, FALSE_EXPR };
struct Expr {
    unsigned int id;
    enum ExprKind kind;
    union {
        struct { Expr* e; };
        struct { Expr* e1; Expr* e2; Expr* e3; };
        struct { char* varName; };
        struct { unsigned int c; };
        struct { };
    };
};

/* Constructors */

unsigned int idGenerator = 0;

BindingList* createBindingListFromBinding(Binding* b) {
    BindingList* r = (BindingList*) malloc(sizeof(BindingList));
    r->id = idGenerator++;
    r->prevBindings = NULL;
    r->binding = b;
    return r;
}

BindingList* mergeBindingListAndBinding(BindingList* lst, Binding* b) {
    BindingList* r = (BindingList*) malloc(sizeof(BindingList));
    r->id = idGenerator++;
    r->prevBindings = lst;
    r->binding = b;
    return r;
}

Binding* createVariableBinding(char* varName, Expr* e) {
    Binding* r = (Binding*) malloc(sizeof(Binding));
    r->id = idGenerator++;
    r->kind = VAL_BINDING;
    r->id2 = idGenerator++;
    r->varName = varName;
    r->e = e;
    return r;
}

Binding* createFunctionBinding(char* funcName, char* paramName, Expr* body) {
    Binding* r = (Binding*) malloc(sizeof(Binding));
    r->id = idGenerator++;
    r->kind = FUN_BINDING;
    r->id3 = idGenerator++;
    r->funcName = funcName;
    r->id4 = idGenerator++;
    r->paramName = paramName;
    r->body = body;
    return r;
}

Expr* createIfThenElseExpr(Expr* e1, Expr* e2, Expr* e3) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = IF_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    r->e3 = e3;
    return r;
}

Expr* createAddExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = ADD_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createSubExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = SUB_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createMulExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = MUL_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createDivExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = DIV_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createGreaterThanExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = GT_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createLessThanExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = LT_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createAndExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = AND_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createOrExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = OR_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createCallExpr(Expr* e1, Expr* e2) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = CALL_EXPR;
    r->e1 = e1;
    r->e2 = e2;
    return r;
}

Expr* createParenthesesExpr(Expr* e) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = PAREN_EXPR;
    r->e = e;
    return r;
}

Expr* createIDExpr(char* varName) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = ID_EXPR;
    r->varName = varName;
    return r;
}

Expr* createIntConstExpr(unsigned int c) {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = INT_CONST_EXPR;
    r->c = c;
    return r;
}

Expr* createTrueExpr() {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = TRUE_EXPR;
    return r;
}

Expr* createFalseExpr() {
    Expr* r = (Expr*) malloc(sizeof(Expr));
    r->id = idGenerator++;
    r->kind = FALSE_EXPR;
    return r;
}

/* Printing */

void printBinding(Binding* b, FILE* outFile);
void printExpr(Expr* e, FILE* outFile);

void printBindingList(BindingList* lst, FILE* outFile) {
    fprintf(outFile, "%u [label=\"binding_list\"];\n", lst->id);
    if(lst->prevBindings != NULL) {
        fprintf(outFile, "%u -> %u;\n", lst->id, lst->prevBindings->id);
        printBindingList(lst->prevBindings, outFile);
    }
    fprintf(outFile, "%u -> %u;\n", lst->id, lst->binding->id);
    printBinding(lst->binding, outFile);
}

void printBinding(Binding* b, FILE* outFile) {
    switch(b->kind) {
        case VAL_BINDING:
            fprintf(outFile, "%u [label=\"val_binding\"];\n", b->id);
            fprintf(outFile, "%u -> %u [ label=\"var\" ];\n", b->id, b->id2);
            fprintf(outFile, "%u [label=\"%s\"];\n", b->id2, b->varName);
            fprintf(outFile, "%u -> %u [ label=\"expr\" ];\n", b->id, b->e->id);
            printExpr(b->e, outFile);
            break;
        case FUN_BINDING:
            fprintf(outFile, "%u [label=\"fun_binding\"];\n", b->id);
            fprintf(outFile, "%u -> %u [ label=\"func\" ];\n", b->id, b->id3);
            fprintf(outFile, "%u [label=\"%s\"];\n", b->id3, b->funcName);
            fprintf(outFile, "%u -> %u [ label=\"param\" ];\n", b->id, b->id4);
            fprintf(outFile, "%u [label=\"%s\"];\n", b->id4, b->paramName);
            fprintf(outFile, "%u -> %u [ label=\"body\" ];\n", b->id, b->body->id);
            printExpr(b->body, outFile);
            break;
    }
}

void printExpr(Expr* e, FILE* outFile) {
    switch(e->kind) {
        case IF_EXPR:
            fprintf(outFile, "%u [label=\"if-then-else\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"cond\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"then\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            fprintf(outFile, "%u -> %u [ label=\"else\" ];\n", e->id, e->e3->id);
            printExpr(e->e3, outFile);
            break;
        case ADD_EXPR:
            fprintf(outFile, "%u [label=\"+\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"lhs\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"rhs\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case SUB_EXPR:
            fprintf(outFile, "%u [label=\"-\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"lhs\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"rhs\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case MUL_EXPR:
            fprintf(outFile, "%u [label=\"*\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"lhs\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"rhs\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case DIV_EXPR:
            fprintf(outFile, "%u [label=\"/\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"lhs\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"rhs\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case GT_EXPR:
            fprintf(outFile, "%u [label=\">\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"lhs\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"rhs\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case LT_EXPR:
            fprintf(outFile, "%u [label=\"<\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"lhs\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"rhs\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case AND_EXPR:
            fprintf(outFile, "%u [label=\"andalso\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"lhs\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"rhs\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case OR_EXPR:
            fprintf(outFile, "%u [label=\"orelse\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"lhs\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"rhs\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case CALL_EXPR:
            fprintf(outFile, "%u [label=\"call\"];\n", e->id);
            fprintf(outFile, "%u -> %u [ label=\"func\" ];\n", e->id, e->e1->id);
            printExpr(e->e1, outFile);
            fprintf(outFile, "%u -> %u [ label=\"arg\" ];\n", e->id, e->e2->id);
            printExpr(e->e2, outFile);
            break;
        case PAREN_EXPR:
            fprintf(outFile, "%u [label=\"(...)\"];\n", e->id);
            fprintf(outFile, "%u -> %u;\n", e->id, e->e->id);
            printExpr(e->e, outFile);
            break;
        case ID_EXPR:
            fprintf(outFile, "%u [label=\"%s\"];\n", e->id, e->varName);
            break;
        case INT_CONST_EXPR:
            fprintf(outFile, "%u [label=\"%u\"];\n", e->id, e->c);
            break;
        case TRUE_EXPR:
            fprintf(outFile, "%u [label=\"true\"];\n", e->id);
            break;
        case FALSE_EXPR:
            fprintf(outFile, "%u [label=\"false\"];\n", e->id);
            break;
    }
}

