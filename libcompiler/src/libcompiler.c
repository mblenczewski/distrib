#include "libcompiler.h"

s32
main(s32 argc, char **argv) {
	(void)argc;
	(void)argv;

	dbglog("Version: " LIBCOMPILER_VERSION "\n");
	printf("Hello, World!\n");

	return 0;
}
