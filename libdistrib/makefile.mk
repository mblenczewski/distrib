.PHONY: libdistrib libdistrib-build libdistrib-deps libdistrib-test

LIBDISTRIB_MAJOR	:= 0
LIBDISTRIB_MINOR	:= 1
LIBDISTRIB_PATCH	:= 0
LIBDISTRIB_VERSION	:= $(LIBDISTRIB_MAJOR).$(LIBDISTRIB_MINOR).$(LIBDISTRIB_PATCH)

LIBDISTRIB_FLAGS	:= \
			   $(CFLAGS) -fPIC					\
			   $(CPPFLAGS)						\
			   -DLIBDISTRIB_VERSION_MAJOR="\"$(LIBDISTRIB_MAJOR)"\"	\
			   -DLIBDISTRIB_VERSION_MINOR="\"$(LIBDISTRIB_MINOR)"\"	\
			   -DLIBDISTRIB_VERSION_PATCH="\"$(LIBDISTRIB_PATCH)"\"	\
			   -DLIBDISTRIB_VERSION="\"$(LIBDISTRIB_VERSION)"\"	\
			   -Ilibdistrib/include					\
			   $(LDFLAGS)

LIBDISTRIB_TEST_FLAGS	:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -Ilibdistrib/include					\
			   $(LDFLAGS)

LIBDISTRIB_SOURCES	:= libdistrib/src/unity.c
LIBDISTRIB_OBJECTS	:= $(LIBDISTRIB_SOURCES:%.c=$(OBJ)/%.c.o)

LIBDISTRIB_TEST_SOURCES	:= libdistrib/tests/test_libdistrib.c
LIBDISTRIB_TEST_OBJECTS	:= $(LIBDISTRIB_TEST_SOURCES:%.c=$(TST)/%.x)

$(LIBDISTRIB_OBJECTS): $(OBJ)/%.c.o: %.c | $(OBJ)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ -c $< $(LIBDISTRIB_FLAGS)

$(LIBDISTRIB_TEST_OBJECTS): $(TST)/%.x: %.c | $(TST)
	@mkdir -p $(shell dirname $@)
	$(CC) -static -o $@ $< $(LIBDISTRIB_TEST_FLAGS)

$(LIB)/libdistrib.$(LIBDISTRIB_VERSION).a: libdistrib-deps $(LIBDISTRIB_OBJECTS) | $(LIB)
	@mkdir -p $(shell dirname $@)
	$(AR) -rcs $@ $(LIBDISTRIB_OBJECTS)

$(LIB)/libdistrib.$(LIBDISTRIB_MAJOR).a: $(LIB)/libdistrib.$(LIBDISTRIB_VERSION).a
	ln -sf libdistrib.$(LIBDISTRIB_VERSION).a $@

$(LIB)/libdistrib.a: $(LIB)/libdistrib.$(LIBDISTRIB_MAJOR).a
	ln -sf libdistrib.$(LIBDISTRIB_MAJOR).a $@

$(LIB)/libdistrib.$(LIBDISTRIB_VERSION).so: libdistrib-deps $(LIBDISTRIB_OBJECTS) | $(LIB)
	@mkdir -p $(shell dirname $@)
	$(CC) -shared -o $@ $(LIBDISTRIB_OBJECTS) $(TARGET_FLAGS)

$(LIB)/libdistrib.$(LIBDISTRIB_MAJOR).so: $(LIB)/libdistrib.$(LIBDISTRIB_VERSION).so
	ln -sf libdistrib.$(LIBDISTRIB_VERSION).so $@

$(LIB)/libdistrib.so: $(LIB)/libdistrib.$(LIBDISTRIB_MAJOR).so
	ln -sf libdistrib.$(LIBDISTRIB_MAJOR).so $@

libdistrib-deps:

libdistrib-build: $(LIB)/libdistrib.a $(LIB)/libdistrib.so

libdistrib-test: $(LIBDISTRIB_TEST_OBJECTS)
	@for f in $(LIBDISTRIB_TEST_OBJECTS); do ./$$f ; done

libdistrib: libdistrib-build libdistrib-test
