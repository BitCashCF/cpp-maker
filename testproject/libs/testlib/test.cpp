#include "test.h"
#include "test2.h"

#include <iostream>

using namespace std;

void testfunction () {
	cout << "Inside a library" << endl;
    testfunction2();
}