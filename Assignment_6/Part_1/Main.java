
import java.util.*;

interface FSObject {

}

class File implements FSObject {
    private String name;
    private int size;
    public File(String n, int s) { name = n; size = s; }
    public String getName() { return name; }
    public int getSize() { return size; }
}

class Link implements FSObject {
    private String name;
    private String path;
    public Link(String n, String p) { name = n; path = p; }
    public String getName() { return name; }
    public String getPath() { return path; }
}

class Directory implements FSObject {
    private String name;
    private List<FSObject> list;
    public Directory(String n, List<FSObject> l) { name = n; list = l; }
    public String getName() { return name; }
    public List<FSObject> getList() { return list; }
}

public class Main {

    public static void main(String[] args) {
        // Create myFS
        FSObject myFS = ...;
        // Do not modify the test code below
        // Use a method to find total size of myFS
        System.out.println("Total size = " + myFS.totalSize());
        // Use a visitor to print myFS
        PrintLargeFilesVisitor printer = new PrintLargeFilesVisitor();
        printer.Traverse(myFS);
    }
}
