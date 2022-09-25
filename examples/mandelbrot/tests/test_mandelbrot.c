#include "test.h"
#include "mandelbrot.h"

TEST(test_example, {
	int a = 42;

	TEST_EXPECT(a + 2 == 44, "a + 2 != 44")
	TEST_ASSERT(a == 42, "a != 42")

	TEST_PASS()
})

s32
main(s32 argc, char **argv) {
	(void)argc;
	(void)argv;

	TESTS_BEGIN()

	TEST_RUN(test_example)

	TESTS_END()
}
