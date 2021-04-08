
%{
    #include <string.h>

    int numDatatypeBindings = 0;    // Done
    int numValBindings = 0;         // Done
    int numFunBindings = 0;         // Done
    int numAnonymousFunctions = 0;  // Done
    int numLetExpressions = 0;      // Done
    int numIfThenElse = 0;          // Done (Ask)
    int numBoolExpressions = 0;     // Done
    int numCaseExpressions = 0;     // Done
    int numArithmeticOps = 0;       // Done
    int numRelationalOps = 0;       // Done
    int numSeparators = 0;          // Done (Ask)
    int numIntConst = 0;            // Done
    int largestIntConst = 0;        // Done
    int numBoolConst = 0;           // Done
    int numStrings = 0;             // Done
    int totalStringChars = 0;       // (Ask if special characters like \n or escaped characters should count in total), Also do we have to handle the case where the user does close a string a comment?
    int largestStringSize = 0;      // (Also ask if input returns a single \ as char or will it count also the next char)
    int numIDs = 0;                 // Done
    int largestIDSize = 0;          // Done
    int numComments = 0;            // Done
    int totalCommentChars = 0;      // (Ask if we can include in stdlib or even string)
    int largestCommentSize = 0;     // (Ask)
    int numLines = 0;               // Done

    void iterateOverString();
    void iterateOverComment();
%}

typesdef       int|real|string|char|bool
arithmetic     \+|\-|\*|div|mod
relational     (<=?)|(>=?)|=
otherops       ::|=>|\|
separators     [:\.\[\],\(\)\|;]
identifier     [a-zA-Z_][a-zA-Z_']*

%%
    /* Rules for keywords */
datatype        ++numDatatypeBindings;
of              /*Do not do anything*/
val             ++numValBindings;
fun             ++numFunBindings;
fn              ++numAnonymousFunctions;
let             ++numLetExpressions;
in              /*Do not do anything*/
end             /*Do not do anything*/
if              ++numIfThenElse;
then            /*Do not do anything*/
else            /*Do not do anything*/
orelse          ++numBoolExpressions;
andalso         ++numBoolExpressions;
case            ++numCaseExpressions;

    /* Rules for built-in types */

{typesdef}      /*Do not do anything*/

    /* Rules for "other" operators */

{otherops}      /*Do not do anything*/

    /* Rules for arithmetic operators */

{arithmetic}    ++numArithmeticOps;

    /* Rules for relational operators */

{relational}    ++numRelationalOps;

    /* Rules for separators */

{separators}    ++numSeparators;

    /* Rule for integer and boolean literals */

[0-9]+          {++numIntConst; largestIntConst = (atoi(yytext) > largestIntConst) ? atoi(yytext) : largestIntConst;}

true|false      ++numBoolConst;

    /* Rule for identifiers */

{identifier}    {++numIDs; largestIDSize = (strlen(yytext) > largestIDSize) ? strlen(yytext) : largestIDSize;}

    /* Rule for string literal */
    /* Hint: you can call input() to read the next character in the stream */

\"               {++numStrings; iterateOverString();}

    /* Rule for comment */
    /* Hint: you can call input() to read the next character in the stream */
    /* Hint: you can call unput(char) to return a character to the stream after reading it */

\(\*            {++numComments; iterateOverComment();}

    /* Rule for whitespace */

[\\t\\r ]
 
\\n             ++numLines;  


    /* Catch unmatched tokens */
.               fprintf(stderr, "INVALID TOKEN: %s\n", yytext);

%%

void iterateOverString() {

    // char prev = '"';
    // char current = input();
    // while( input() != '\"' && prev != '\\' ) {

    //     prev = current;
    //     current = input();

    // }

}

void iterateOverComment() {

    // char* str = malloc( sizeof(char) );
    
    // char prev = '"';
    // char current = input();
    // while(current != '\"' && prev != '\\') {
    //     str = str
    // }

    // free(str);

    // char prev = '*';
    // char current = input();
    // while( input() != '}' && prev != '*' ) {

    //     prev = current;
    //     current = input();

    // }

}

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

