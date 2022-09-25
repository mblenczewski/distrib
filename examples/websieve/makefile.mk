.PHONY: websieve websieve-build websieve-deps websieve-test

WEBSIEVE_MAJOR		:= 0
WEBSIEVE_MINOR		:= 1
WEBSIEVE_PATCH		:= 0
WEBSIEVE_VERSION	:= $(WEBSIEVE_MAJOR).$(WEBSIEVE_MINOR).$(WEBSIEVE_PATCH)

WEBSIEVE_FLAGS		:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -DWEBSIEVE_VERSION_MAJOR="\"$(WEBSIEVE_MAJOR)"\" \
			   -DWEBSIEVE_VERSION_MINOR="\"$(WEBSIEVE_MINOR)"\" \
			   -DWEBSIEVE_VERSION_PATCH="\"$(WEBSIEVE_PATCH)"\" \
			   -DWEBSIEVE_VERSION="\"$(WEBSIEVE_VERSION)"\"	\
			   -Iexamples/websieve/include -Ilibdistrib/include	\
			   $(LDFLAGS) -ldistrib

WEBSIEVE_TEST_FLAGS	:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -Iexamples/websieve/include -Ilibdistrib/include	\
			   $(LDFLAGS)

WEBSIEVE_SOURCES	:= examples/websieve/src/unity.c
WEBSIEVE_OBJECTS	:= $(WEBSIEVE_SOURCES:%.c=$(OBJ)/%.c.o)

WEBSIEVE_TEST_SOURCES	:= examples/websieve/tests/test_websieve.c
WEBSIEVE_TEST_OBJECTS	:= $(WEBSIEVE_TEST_SOURCES:%.c=$(TST)/%.x)

$(WEBSIEVE_OBJECTS): $(OBJ)/%.c.o: %.c | $(OBJ)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ -c $< $(WEBSIEVE_FLAGS)

$(WEBSIEVE_TEST_OBJECTS): $(TST)/%.x: %.c | $(TST)
	@mkdir -p $(shell dirname $@)
	$(CC) -static -o $@ $< $(WEBSIEVE_TEST_FLAGS)

$(BIN)/examples/websieve: websieve-deps $(WEBSIEVE_OBJECTS) | $(BIN)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ $(WEBSIEVE_OBJECTS) $(WEBSIEVE_FLAGS)

websieve-deps: libdistrib-build

websieve-build: $(BIN)/examples/websieve

websieve-test: $(WEBSIEVE_TEST_OBJECTS)
	@for f in $(WEBSIEVE_TEST_OBJECTS); do ./$$f ; done

websieve: websieve-build websieve-test
