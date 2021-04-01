
%{
    #include <string.h>

    int numDatatypeBindings = 0;
    int numValBindings = 0;
    int numFunBindings = 0;
    int numAnonymousFunctions = 0;
    int numLetExpressions = 0;
    int numIfThenElse = 0;
    int numBoolExpressions = 0;
    int numCaseExpressions = 0;
    int numArithmeticOps = 0;
    int numRelationalOps = 0;
    int numSeparators = 0;
    int numIntConst = 0;
    int largestIntConst = 0;
    int numBoolConst = 0;
    int numStrings = 0;
    int totalStringChars = 0;
    int largestStringSize = 0;
    int numIDs = 0;
    int largestIDSize = 0;
    int numComments = 0;
    int totalCommentChars = 0;
    int largestCommentSize = 0;
    int numLines = 0;
%}




%%

    /* Rules for keywords */
datatype        ++numDatatypeBindings;














    /* Rules for built-in types */




    /* Rules for "other" operators */




    /* Rules for arithmetic operators */






    /* Rules for relational operators */






    /* Rules for separators */








    /* Rule for integer and boolean literals */




    /* Rule for identifiers */


    /* Rule for string literal */
    /* Hint: you can call input() to read the next character in the stream */
























    /* Rule for comment */
    /* Hint: you can call input() to read the next character in the stream */
    /* Hint: you can call unput(char) to return a character to the stream after reading it */



























    /* Rule for whitespace */





    /* Catch unmatched tokens */
.               fprintf(stderr, "INVALID TOKEN: %s\n", yytext);

%%

void printStats() {
    //Remove "=" operators used for assignment in bindings
    numRelationalOps -= numDatatypeBindings + numValBindings + numFunBindings;
    // Print
    printf("Number of bindings                 = %d (%d datatype, %d variable, %d function)\n", numDatatypeBindings + numValBindings + numFunBindings, numDatatypeBindings, numValBindings, numFunBindings);
    printf("Number of functions                = %d (%d named, %d anonymous)\n", numFunBindings + numAnonymousFunctions, numFunBindings, numAnonymousFunctions);
    printf("Number of let expressions          = %d\n", numLetExpressions);
    printf("Number of if-then-else expressions = %d\n", numIfThenElse);
    printf("Number of Boolean expressions      = %d\n", numBoolExpressions);
    printf("Number of case expressions         = %d\n", numCaseExpressions);
    printf("Number of operators                = %d (%d arithmetic, %d relational)\n", numArithmeticOps + numRelationalOps, numArithmeticOps, numRelationalOps);
    printf("Number of separators               = %d\n", numSeparators);
    printf("Number of literals                 = %d (%d int, %d bool, %d string)\n", numIntConst + numBoolConst + numStrings, numIntConst, numBoolConst, numStrings);
    printf("    Largest int const = %d\n", largestIntConst);
    printf("    Average string size = %.2f\n", totalStringChars/(float)numStrings);
    printf("    Largest string size = %d\n", largestStringSize);
    printf("Number of identifiers              = %d\n", numIDs);
    printf("    Largest identifier size = %d\n", largestIDSize);
    printf("Number of comments                 = %d\n", numComments);
    printf("    Average comment size = %.2f\n", totalCommentChars/(float)numComments);
    printf("    Largest comment size = %d\n", largestCommentSize);
    printf("    Average comments per line = %.2f\n", numComments/(float)numLines);
    printf("Number of lines                    = %d\n", numLines);
}

int main(int argc, char** argv) {
    const char* inFileName = (argc > 1)?argv[1]:"test.sml";
    yyin = fopen(inFileName, "r");
    yylex();
    fclose(yyin);
    printStats();
    return 0;
}
int yywrap() {
    return 1;
}

