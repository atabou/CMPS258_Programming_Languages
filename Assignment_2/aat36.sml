


datatype FSObject = File of string*int | Directory of string*FSObject list  | Link of string*string

val myFS = 

    Directory( "dirA", [ 
        
        Directory( "dirB", [ 
            
            Directory( "dirC", [ 

                File("file1", 4096), 

                File("file2", 2097152), 

                Link("linkX", "dirA/dirD/file4") 

            ]), 

            Link("linkY", "dirA/dirD/file4") 

        ]), 

        Directory( "dirD", [ 

            File("file3", 4194304), 

            File("file4", 128), 

            Link("linkZ", "dirA/dirB/dirC/file1") 

        ]) 
    ])


fun totalSize( fs: FSObject ) =
    case fs of
          Link (name, path)         =>  0
        | File (name, size)         =>  size
        | Directory (name, content) =>  let 
                                            fun exploreDir( dir: FSObject list) =
                                                if null dir
                                                then 0
                                                else totalSize( hd dir ) + exploreDir( tl dir )
                                        in
                                            exploreDir( content )
                                        end


fun containsLinks( fs: FSObject ) =
    case fs of
        Link (name, path)           =>  true
      | File(name, size)            =>  false
      | Directory(name, content)    =>  let
                                            fun exploreDir( dir: FSObject list ) =
                                                if null dir
                                                then false
                                                else containsLinks( hd dir ) orelse exploreDir(tl dir)
                                        in
                                            exploreDir( content )
                                        end



fun getFilesLargerThan( fs: FSObject, size_treshold: int ) =
    case fs of
         Link (name, path)          =>  []
       | File (name, size)          =>  if size > size_treshold then name::[] else []
       | Directory (name, content)  =>  let
                                            fun exploreDir( dir: FSObject list ) =
                                                if null dir
                                                then []
                                                else getFilesLargerThan( hd dir,
                                                size_treshold ) @ exploreDir( tl dir)
                                        in
                                            exploreDir( content )
                                        end



fun countLinks( fs: FSObject, p: string ) =
    case fs of
         Link (name, path)          =>  if p = path then 1 else 0
       | File (name, path)          =>  0
       | Directory (name, content)   =>  let
                                            fun exploreDir( dir: FSObject list) =
                                                if null dir
                                                then 0
                                                else countLinks( hd dir, p ) +
                                                exploreDir( tl dir )
                                        in
                                            exploreDir( content )
                                        end


