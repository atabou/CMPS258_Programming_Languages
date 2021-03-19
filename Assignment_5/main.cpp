
#include <iostream>
using namespace std;

class Scanner {
    private:
        int lampLife;
    public:
        Scanner(int l) : lampLife(l) { }
        virtual bool changeLamp(int l) { lampLife = l; }
        virtual bool scan(int numPages) {
            if(numPages > lampLife) {
                cout << "Please change the lamp\n";
                return false;
            } else {
                cout << "Scanning successful\n";
                lampLife -= numPages;
                return true;
            }
        }
};

class Printer {
    private:
        int tonerLevel;
    public:
        Printer(int t) : tonerLevel(t) { }
        virtual bool replenishToner(int t) { tonerLevel = t; }
        virtual bool print(int numPages) {
            if(numPages > tonerLevel) {
                cout << "Not enough toner\n";
                return false;
            } else {
                cout << "Printing successful\n";
                tonerLevel -= numPages;
                return true;
            }
        }
};

class ScannerPrinter : public Scanner, public Printer {
    public:
        ScannerPrinter(int l, int t) : Scanner(l), Printer(t) { }
        virtual bool scanPrint(int numPages) {
            return scan(numPages) && print(numPages);
        }
};

int main() {
    ScannerPrinter* sp = new ScannerPrinter(0, 0);
    sp->changeLamp(30000);
    sp->replenishToner(10000);
    sp->scan(15);
    sp->print(30);
    sp->scanPrint(10);
    Scanner* s = sp;
    s->changeLamp(30000);
    s->scan(25);
    Printer* p = sp;
    p->replenishToner(10000);
    p->print(20);
    return 0;
}
