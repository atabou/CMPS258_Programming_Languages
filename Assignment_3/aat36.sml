

datatype FSObject = File of string*int | Link of string*string | Directory of string*(FSObject list) 


(*
*
* traverseFS does not produce the same exact binding as presented in the
* assignment. It replaces 'a with (unit -> 'a). 
*
* The reason for this is that instead of passing a value for the base case, 
* I'm passing an anonymous function with 0 arguments, which explains the
* appearance of (unit -> 'a). 
*
* However, since (unit -> 'a) can be reduced to 'a, we can assume that the
* binding is the same with the small difference that you have to pass a function
* instead of a value for the base case.
*
* The reason I decided to keep it as a function is that in question 1, the
* problem states that we need to pass "a function for variant of the FSObject (and a base case for the list variant)"
*
* From this statement we can deduce that the base case also needs to be a
* function, which conflicts with the binding proposed.
*
* As a result, I decided to go with the question prompt, I hope that you will
* not consider this wrong, as I did not know which option to choose.
*
*)

fun traverseFS ( fs, fileProc, linkProc, emptyDirProc, dirProc ) =
    case fs of
        File (name, size)       => fileProc(name, size)
    |   Link (name, path)       => linkProc(name, path)
    |   Directory (name, fsObj) =>  let
                                        fun exploreDir( dir ) =
                                            if null dir
                                            then emptyDirProc()
                                            else dirProc( traverseFS(hd dir, fileProc, linkProc, emptyDirProc, dirProc ), exploreDir(tl dir) )
                                        in
                                            exploreDir( fsObj )
                                        end


fun totalSize( fs: FSObject ) = traverseFS( 
        fs, 
        fn (name, size)  => size,
        fn (name, path)  => 0,
        fn () => 0,
        fn (sizeOfHead, sizeOfTail) => sizeOfHead + sizeOfTail
    )


fun containsLinks( fs: FSObject ) = traverseFS (
        fs,
        fn (name, size) => false,
        fn (name, path) => true,
        fn () => false,
        fn (headContainsLink, tailContainsLink) => headContainsLink orelse tailContainsLink
    )

fun getFilesLargerThan( fs: FSObject, threshold: int ) = traverseFS(
        fs,
        fn (name, size) => if size < threshold then [] else [name],
        fn (name, path) => [],
        fn () => [],
        fn (head, tail) => head @ tail
    )

fun countLinksTo( fs: FSObject, p: string ) = traverseFS(
        fs,
        fn (name, size) => 0,
        fn (name, path) => if p = path then 1 else 0,
        fn () => 0,
        fn (head, tail) => head + tail
    )

fun concatStrings ( xs: string list ) =
    
    let 
        fun aux(xs: string list, acc: string) =
            
            case xs of
                [] => acc
            |   x::xs' => aux(xs', acc^x)
    in
        aux(xs,"")
    end



































