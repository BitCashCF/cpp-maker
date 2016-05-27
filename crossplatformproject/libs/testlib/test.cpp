#include "test.h"
#include "test2.h"

#include <iostream>

using namespace std;

int testfunction () {
	cout << "Inside a library" << endl;
    testfunction2();
    
    return 42;
}