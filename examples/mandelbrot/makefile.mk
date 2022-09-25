.PHONY: mandelbrot mandelbrot-build mandelbrot-deps mandelbrot-test

MANDELBROT_MAJOR	:= 0
MANDELBROT_MINOR	:= 1
MANDELBROT_PATCH	:= 0
MANDELBROT_VERSION	:= $(MANDELBROT_MAJOR).$(MANDELBROT_MINOR).$(MANDELBROT_PATCH)

MANDELBROT_FLAGS	:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -DMANDELBROT_VERSION_MAJOR="\"$(MANDELBROT_MAJOR)"\" \
			   -DMANDELBROT_VERSION_MINOR="\"$(MANDELBROT_MINOR)"\" \
			   -DMANDELBROT_VERSION_PATCH="\"$(MANDELBROT_PATCH)"\" \
			   -DMANDELBROT_VERSION="\"$(MANDELBROT_VERSION)"\"	\
			   -Iexamples/mandelbrot/include -Ilibdistrib/include	\
			   $(LDFLAGS) -ldistrib

MANDELBROT_TEST_FLAGS	:= \
			   $(CFLAGS)						\
			   $(CPPFLAGS)						\
			   -Iexamples/mandelbrot/include -Ilibdistrib/include	\
			   $(LDFLAGS)

MANDELBROT_SOURCES	:= examples/mandelbrot/src/unity.c
MANDELBROT_OBJECTS	:= $(MANDELBROT_SOURCES:%.c=$(OBJ)/%.c.o)

MANDELBROT_TEST_SOURCES	:= examples/mandelbrot/tests/test_mandelbrot.c
MANDELBROT_TEST_OBJECTS	:= $(MANDELBROT_TEST_SOURCES:%.c=$(TST)/%.x)

$(MANDELBROT_OBJECTS): $(OBJ)/%.c.o: %.c | $(OBJ)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ -c $< $(MANDELBROT_FLAGS)

$(MANDELBROT_TEST_OBJECTS): $(TST)/%.x: %.c | $(TST)
	@mkdir -p $(shell dirname $@)
	$(CC) -static -o $@ $< $(MANDELBROT_TEST_FLAGS)

$(BIN)/examples/mandelbrot: mandelbrot-deps $(MANDELBROT_OBJECTS) | $(BIN)
	@mkdir -p $(shell dirname $@)
	$(CC) -o $@ $(MANDELBROT_OBJECTS) $(MANDELBROT_FLAGS)

mandelbrot-deps: libdistrib-build

mandelbrot-build: $(BIN)/examples/mandelbrot

mandelbrot-test: $(MANDELBROT_TEST_OBJECTS)
	@for f in $(MANDELBROT_TEST_OBJECTS); do ./$$f ; done

mandelbrot: mandelbrot-build mandelbrot-test
