.PHONY: distrib distrib-build distrib-deps distrib-test

DISTRIB_MAJOR		:= 0
DISTRIB_MINOR		:= 1
DISTRIB_PATCH		:= 0
DISTRIB_VERSION		:= $(DISTRIB_MAJOR).$(DISTRIB_MINOR).$(DISTRIB_PATCH)

DISTRIB_FLAGS		:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -DDISTRIB_VERSION_MAJOR="\"$(DISTRIB_MAJOR)"\"	\
			   -DDISTRIB_VERSION_MINOR="\"$(DISTRIB_MINOR)"\"	\
			   -DDISTRIB_VERSION_PATCH="\"$(DISTRIB_PATCH)"\"	\
			   -DDISTRIB_VERSION="\"$(DISTRIB_VERSION)"\"		\
			   -Idistrib/include -Ilibcompiler/include		\
			   -Ilibdistrib/include					\
			   $(LDFLAGS) -lcompiler -ldistrib

DISTRIB_TEST_FLAGS	:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -Idistrib/include -Ilibcompiler/include		\
			   -Ilibdistrib/include					\
			   $(LDFLAGS)

DISTRIB_SOURCES		:= distrib/src/unity.c
DISTRIB_OBJECTS		:= $(DISTRIB_SOURCES:%.c=$(OBJ)/%.c.o)

DISTRIB_TEST_SOURCES	:= distrib/tests/test_distrib.c
DISTRIB_TEST_OBJECTS	:= $(DISTRIB_TEST_SOURCES:%.c=$(TST)/%.x)

$(DISTRIB_OBJECTS): $(OBJ)/%.c.o: %.c | $(OBJ)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ -c $< $(DISTRIB_FLAGS)

$(DISTRIB_TEST_OBJECTS): $(TST)/%.x: %.c | $(TST)
	@mkdir -p $(shell dirname $@)
	$(CC) -static -o $@ $< $(DISTRIB_TEST_FLAGS)

$(BIN)/distrib: distrib-deps $(DISTRIB_OBJECTS) | $(BIN)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ $(DISTRIB_OBJECTS) $(DISTRIB_FLAGS)

distrib-deps: libcompiler-build libdistrib-build

distrib-build: $(BIN)/distrib

distrib-test: $(DISTRIB_TEST_OBJECTS)
	@for f in $(DISTRIB_TEST_OBJECTS); do ./$$f ; done

distrib: distrib-build distrib-test
