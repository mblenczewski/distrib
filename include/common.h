#ifndef COMMON_H
#define COMMON_H

#include <assert.h>
#include <float.h>
#include <limits.h>
#include <locale.h>
#include <stdalign.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdnoreturn.h>
#include <wchar.h>

typedef int32_t b32;

typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;

typedef int8_t s8;
typedef int16_t s16;
typedef int32_t s32;
typedef int64_t s64;

typedef float f32;
typedef double f64;

#define ALLOC_OVERFLOWS(type, count) ((UINT_MAX / sizeof(type)) < (count))
#define ARRLEN(arr) (sizeof(arr) / sizeof((arr)[0]))
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

#define errlog(...) fprintf(stderr, __VA_ARGS__)

#ifndef NDEBUG
	#define dbglog(...) errlog(__VA_ARGS__)
#else
	#define dbglog(...)
#endif

#endif /* COMMON_H */
