#include <iostream>

#include "gtest/gtest.h"

#include "test.h"

TEST(sample_test_case, sample_test)
{
    EXPECT_EQ(1, 1);
    EXPECT_EQ(testfunction(), 42);
}