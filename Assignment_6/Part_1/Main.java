
import java.util.*;

public class Main {

    public static void main(String[] args) {
        // Create myFS
        FSObject myFS = generateMyFs();
        // Do not modify the test code below
        // Use a method to find total size of myFS
        System.out.println("Total size = " + myFS.totalSize());
        // Use a visitor to print myFS
        PrintLargeFilesVisitor printer = new PrintLargeFilesVisitor();
        printer.Traverse(myFS);
    }

    public static Directory generateMyFs() {


        List<FSObject> inDirA = new ArrayList<FSObject>();
        List<FSObject> inDirB = new ArrayList<FSObject>();
        List<FSObject> inDirC = new ArrayList<FSObject>();
        List<FSObject> inDirD = new ArrayList<FSObject>();

        inDirC.add( new File("file1", 4096) );
        inDirC.add( new File("file2", 2097152) );
        inDirC.add( new Link("linkX", "dirA/dirD/file4") );

        inDirB.add( new Directory("dirC", inDirC) );
        inDirB.add( new Link("linkY", "dirA/dirD/file4") );

        inDirA.add( new Directory( "dirB", inDirB ) );

        inDirD.add( new File("file3", 4194304) );
        inDirD.add( new File("file4", 128) );
        inDirD.add( new Link("linkZ", "dirA/dirB/dirC/file1") );

        inDirA.add( new Directory("dirD", inDirD) );

        return new Directory("dirA", inDirA);

    }

}

interface FSObject {

    public int totalSize();
    public void Accept( FSObjectVisitor visitor );

}

class File implements FSObject {
    
    private String name;
    private int size;
    
    public File(String n, int s) { name = n; size = s; }
    
    public String getName() { return name; }
    public int getSize() { return size; }
    
    @Override
    public int totalSize() {
        return this.getSize();
    }
    
    @Override
    public void Accept( FSObjectVisitor visitor ) {
        visitor.Visit(this);
    }

}

class Link implements FSObject {
    
    private String name;
    private String path;
    
    public Link(String n, String p) { name = n; path = p; }
    
    public String getName() { return name; }
    public String getPath() { return path; }
    
    @Override
    public int totalSize() {
        return 0;
    }
    
    @Override
    public void Accept( FSObjectVisitor visitor ) {
        visitor.Visit(this);
    }
}

class Directory implements FSObject {
    
    private String name;
    private List<FSObject> list;
    
    public Directory(String n, List<FSObject> l) { name = n; list = l; }
    
    public String getName() { return name; }
    public List<FSObject> getList() { return list; }
    
    @Override
    public int totalSize() {
        int s = 0;
        for(int i=0; i<this.list.size(); i++) {
            s += this.getList().get(i).totalSize();
        }
        return s;
    }

    @Override
    public void Accept( FSObjectVisitor visitor ) {
        visitor.Visit(this);
    }
}

interface FSObjectVisitor {

    default void Traverse( FSObject fs ) { fs.Accept(this); }

    public void Visit( File file );
    public void Visit( Link link );
    public void Visit( Directory dir );

}

class PrintLargeFilesVisitor implements FSObjectVisitor {

    @Override
    public void Visit( File file ) {
        if( file.getSize() > 1048576 ) {
            System.out.println( file.getName() );
        }
    }

    @Override
    public void Visit( Link link ) { }

    @Override
    public void Visit( Directory dir ) {
        
        List<FSObject> content = dir.getList();

        for ( int i=0; i<content.size(); i++) {
            this.Traverse( content.get(i) );
        }

    }

}




















































