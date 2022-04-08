#ifndef Types_h
#define Types_h

#include <simd/simd.h>

typedef struct {
    simd_float4 position;
    simd_float3 normal;
    simd_float2 uv;
} Vertex;

#endif /* Types_h */
