distrib
==============================================================================
A generic framework for distributed computing, allowing clients to distribute
a computation across the nodes in the network. Supports both IPv4 and IPv6,
local discovery and auto-bootstrapping, and configuration through a simple
INI-like file format.

Written in portable C11, and building for Linux and Windows.

Documentation
------------------------------------------------------------------------------
Documentation for the framework's design and API can be found under the
`docs/` directory.

Building
------------------------------------------------------------------------------
Building this framework requires a standards-conforming C11 compiler, GNU
Make, a POSIX-compliant bourne-like shell, and GNU-compatible coreutils.

Benchmarks
------------------------------------------------------------------------------
Benchmarks for performance can be found under the `benchmarks/` directory, as
well as the scripts that generated them.

Examples
------------------------------------------------------------------------------
Example applications making use of the framework are included under the
`examples/` directory, and include a simple commandline calculator, a
distributed mandelbrot set calculator, and a website that sieves for primes
under the specified limit.

Contributing
------------------------------------------------------------------------------
Instructions to read before contributing can be found in `CONTRIBUTING.txt`.

License
------------------------------------------------------------------------------
For details on the license this project is released under, please read the
`LICENSE.txt` file. When using this project in either source or binary
(library) form, please include a copy of the `LICENSE.txt` file alongside the
included files (e.g. in the root directory of your project, named
`LICENSE-distrib.txt` or similar).
