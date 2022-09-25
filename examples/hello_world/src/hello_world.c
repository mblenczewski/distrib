#include "hello_world.h"

s32
main(s32 argc, char **argv) {
	(void)argc;
	(void)argv;

	dbglog("Version: " HELLO_WORLD_VERSION "\n");
	printf("Hello, World!\n");

	return 0;
}
