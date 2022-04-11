//#include "../../Library/Dither.metal"

typedef struct {
    float4 position [[position]];
    float3 viewPosition;
    float3 normal;
} DiffuseVertexData;

typedef struct {
    float4 color;
    float hardness;
    float diffusePower;
} BasicDiffuseUniforms;

vertex DiffuseVertexData basicDiffuseVertex(
    Vertex in [[stage_in]],
    constant VertexUniforms &vertexUniforms [[buffer(VertexBufferVertexUniforms)]]
) {
    DiffuseVertexData out;


    return out;
}

fragment float4 basicDiffuseFragment(DiffuseVertexData in [[stage_in]],
                                     constant BasicDiffuseUniforms &uniforms
                                     [[buffer(FragmentBufferMaterialUniforms)]]) {
    
    return float4(1, 0, 0, 1);
}
