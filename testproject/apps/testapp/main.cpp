#include <iostream>
#include "test.h"

#include <boost/smart_ptr.hpp>

using namespace std;
using namespace boost;

class Test {
public:
    Test() {
        cout << "Yay" << endl;
    }
    ~Test() {
        cout << "Nay" << endl;
    }
};

int main (int argc, char** argv) {
  cout << "Testing123" << endl;
  testfunction();
    
    shared_ptr<Test> test(new Test);
}
