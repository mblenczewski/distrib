.PHONY: all build clean dist distclean test

all: dist

include config.mk

PACKAGE		:= distrib.tar
PACKAGE_SOURCES	:= benchmarks docs $(BIN) $(LIB) $(wildcard *.txt)

clean:
	rm -fr $(BIN) $(LIB) $(OBJ) $(wildcard $(PACKAGE)*)

build: libcompiler-build libdistrib-build distrib-build hello_world-build \
	mandelbrot-build websieve-build

dist: build test $(PACKAGE_SOURCES)
	$(TAR) -cf $(PACKAGE) $(PACKAGE_SOURCES)
	$(ZIP) -9 -kf $(PACKAGE)

test: libcompiler-test libdistrib-test distrib-test hello_world-test \
	mandelbrot-test websieve-test

include libcompiler/makefile.mk
include libdistrib/makefile.mk
include distrib/makefile.mk
include examples/hello_world/makefile.mk
include examples/mandelbrot/makefile.mk
include examples/websieve/makefile.mk
