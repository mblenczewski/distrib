.PHONY: hello_world hello_world-build hello_world-deps hello_world-test

HELLO_WORLD_MAJOR	:= 0
HELLO_WORLD_MINOR	:= 1
HELLO_WORLD_PATCH	:= 0
HELLO_WORLD_VERSION	:= $(HELLO_WORLD_MAJOR).$(HELLO_WORLD_MINOR).$(HELLO_WORLD_PATCH)

HELLO_WORLD_FLAGS	:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -DHELLO_WORLD_VERSION_MAJOR="\"$(HELLO_WORLD_MAJOR)"\" \
			   -DHELLO_WORLD_VERSION_MINOR="\"$(HELLO_WORLD_MINOR)"\" \
			   -DHELLO_WORLD_VERSION_PATCH="\"$(HELLO_WORLD_PATCH)"\" \
			   -DHELLO_WORLD_VERSION="\"$(HELLO_WORLD_VERSION)"\"	\
			   -Iexamples/hello_world/include -Ilibdistrib/include	\
			   $(LDFLAGS) -ldistrib

HELLO_WORLD_TEST_FLAGS	:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -Iexamples/hello_world/include -Ilibdistrib/include	\
			   $(LDFLAGS)

HELLO_WORLD_SOURCES		:= examples/hello_world/src/unity.c
HELLO_WORLD_OBJECTS		:= $(HELLO_WORLD_SOURCES:%.c=$(OBJ)/%.c.o)

HELLO_WORLD_TEST_SOURCES	:= examples/hello_world/tests/test_hello_world.c
HELLO_WORLD_TEST_OBJECTS	:= $(HELLO_WORLD_TEST_SOURCES:%.c=$(TST)/%.x)

$(HELLO_WORLD_OBJECTS): $(OBJ)/%.c.o: %.c | $(OBJ)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ -c $< $(HELLO_WORLD_FLAGS)

$(HELLO_WORLD_TEST_OBJECTS): $(TST)/%.x: %.c | $(TST)
	@mkdir -p $(shell dirname $@)
	$(CC) -static -o $@ $< $(HELLO_WORLD_TEST_FLAGS)

$(BIN)/examples/hello_world: hello_world-deps $(HELLO_WORLD_OBJECTS) | $(BIN)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ $(HELLO_WORLD_OBJECTS) $(HELLO_WORLD_FLAGS)

hello_world-deps: libdistrib-build

hello_world-build: $(BIN)/examples/hello_world

hello_world-test: $(HELLO_WORLD_TEST_OBJECTS)
	@for f in $(HELLO_WORLD_TEST_OBJECTS); do ./$$f ; done

hello_world: hello_world-build hello_world-test
