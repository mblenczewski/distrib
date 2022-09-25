.PHONY: libcompiler libcompiler-build libcompiler-deps libcompiler-test

LIBCOMPILER_MAJOR	:= 0
LIBCOMPILER_MINOR	:= 1
LIBCOMPILER_PATCH	:= 0
LIBCOMPILER_VERSION	:= $(LIBCOMPILER_MAJOR).$(LIBCOMPILER_MINOR).$(LIBCOMPILER_PATCH)

LIBCOMPILER_FLAGS	:= \
			   $(CFLAGS) -fPIC					\
			   $(CPPFLAGS)						\
			   -DLIBCOMPILER_VERSION_MAJOR="\"$(LIBCOMPILER_MAJOR)"\" \
			   -DLIBCOMPILER_VERSION_MINOR="\"$(LIBCOMPILER_MINOR)"\" \
			   -DLIBCOMPILER_VERSION_PATCH="\"$(LIBCOMPILER_PATCH)"\" \
			   -DLIBCOMPILER_VERSION="\"$(LIBCOMPILER_VERSION)"\"	\
			   -Ilibcompiler/include				\
			   $(LDFLAGS)

LIBCOMPILER_TEST_FLAGS	:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -Ilibcompiler/include				\
			   $(LDFLAGS)

LIBCOMPILER_SOURCES	:= libcompiler/src/unity.c
LIBCOMPILER_OBJECTS	:= $(LIBCOMPILER_SOURCES:%.c=$(OBJ)/%.c.o)

LIBCOMPILER_TEST_SOURCES:= libcompiler/tests/test_libcompiler.c
LIBCOMPILER_TEST_OBJECTS:= $(LIBCOMPILER_TEST_SOURCES:%.c=$(TST)/%.x)

$(LIBCOMPILER_OBJECTS): $(OBJ)/%.c.o: %.c | $(OBJ)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ -c $< $(LIBCOMPILER_FLAGS)

$(LIBCOMPILER_TEST_OBJECTS): $(TST)/%.x: %.c | $(TST)
	@mkdir -p $(shell dirname $@)
	$(CC) -static -o $@ $< $(LIBCOMPILER_TEST_FLAGS)

$(LIB)/libcompiler.$(LIBCOMPILER_VERSION).a: libcompiler-deps $(LIBCOMPILER_OBJECTS) | $(LIB)
	@mkdir -p $(shell dirname $@)
	$(AR) -rcs $@ $(LIBCOMPILER_OBJECTS)

$(LIB)/libcompiler.$(LIBCOMPILER_MAJOR).a: $(LIB)/libcompiler.$(LIBCOMPILER_VERSION).a
	ln -sf libcompiler.$(LIBCOMPILER_VERSION).a $@

$(LIB)/libcompiler.a: $(LIB)/libcompiler.$(LIBCOMPILER_MAJOR).a
	ln -sf libcompiler.$(LIBCOMPILER_MAJOR).a $@

$(LIB)/libcompiler.$(LIBCOMPILER_VERSION).so: libcompiler-deps $(LIBCOMPILER_OBJECTS) | $(LIB)
	@mkdir -p $(shell dirname $@)
	$(CC) -shared -o $@ $(LIBCOMPILER_OBJECTS) $(TARGET_FLAGS)

$(LIB)/libcompiler.$(LIBCOMPILER_MAJOR).so: $(LIB)/libcompiler.$(LIBCOMPILER_VERSION).so
	ln -sf libcompiler.$(LIBCOMPILER_VERSION).so $@

$(LIB)/libcompiler.so: $(LIB)/libcompiler.$(LIBCOMPILER_MAJOR).so
	ln -sf libcompiler.$(LIBCOMPILER_MAJOR).so $@

libcompiler-deps:

libcompiler-build: $(LIB)/libcompiler.a $(LIB)/libcompiler.so

libcompiler-test: $(LIBCOMPILER_TEST_OBJECTS)
	@for f in $(LIBCOMPILER_TEST_OBJECTS); do ./$$f ; done

libcompiler: libcompiler-build libcompiler-test
