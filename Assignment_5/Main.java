

public class Main {
    public static void main(String[] args) {
        ScannerPrinter sp = new ScannerPrinterImpl(0, 0);
        sp.changeLamp(30000);
        sp.replenishToner(10000);
        sp.scan(15);
        sp.print(30);
        sp.scanPrint(10);
        Scanner s = sp;
        s.changeLamp(30000);
        s.scan(25);
        Printer p = sp;
        p.replenishToner(10000);
        p.print(20);
    }
}

public interface Printer {

    public boolean replenishToner(int t);
    public boolean print(int numPages);

}

public interface Scanner { 

    public boolean changeLamp(int l);
    public boolean scan(int numPages);

}

public interface ScannerPrinter extends Printer, Scanner {

    public boolean scanPrint(int numPages);

}

public class ScannerImpl implements Scanner {

    private int lampLife;

    public ScannerImpl(int l) {
        this.lampLife = l;
    }

    @Override
    public boolean changeLamp(int l) {
        this.lampLife = l;
        return true;
    }

    @Override
    public boolean scan(int numPages) {
 
        if (numPages > this.lampLife) {
            
            System.out.println("Please change the lamp");
            return false;

        } else {

            System.out.println("Scanning successful");
            this.lampLife -= numPages;
            return true;

        }

    }

}

public class PrinterImpl implements Printer {

    private int tonerLevel;

    public PrinterImpl(int t) {
        this.tonerLevel = t;
    }

    @Override
    public boolean replenishToner(int t) {
        this.tonerLevel = t;
        return true;
    }

    @Override
    public boolean print(int numPages) {

        if (numPages > this.tonerLevel) {
            
            System.out.println("Not enough toner");
            return false;
        
        } else {
        
            System.out.println("Printing successful");
            this.tonerLevel -= numPages;
            return true;
        
        }

    }

}

public class ScannerPrinterImpl implements ScannerPrinter {

    private PrinterImpl p;
    private ScannerImpl s;

    public ScannerPrinterImpl(int l, int t) {

        this.p = new PrinterImpl(t);
        this.s = new ScannerImpl(l);

    }

    @Override
    public boolean scanPrint(int numPages) { return this.s.scan(numPages) && this.p.print(numPages); }

    @Override
    public boolean scan(int numPages) { return this.s.scan(numPages); }

    @Override
    public boolean changeLamp(int l) { return this.s.changeLamp(l); }

    @Override
    public boolean print(int numPages) { return this.p.print(numPages); } 

    @Override
    public boolean replenishToner(int t) { return this.p.replenishToner(t); }

}


