#include "shared.inl"

DAXA_DECL_PUSH_CONSTANT(DrawPush, push)

#if DAXA_SHADER_STAGE == DAXA_SHADER_STAGE_VERTEX

layout(location = 0) out f32vec3 out_color;
layout(location = 1) out f32vec2 out_uv;

void main() {
  out_color = deref(push.vertices[gl_VertexIndex]).color;
  gl_Position = push.modelViewProjection * vec4(deref(push.vertices[gl_VertexIndex]).pos, 1.0);
  out_uv = deref(push.vertices[gl_VertexIndex]).uv;
}

#elif DAXA_SHADER_STAGE == DAXA_SHADER_STAGE_FRAGMENT

layout(location = 0) in f32vec3 in_color;
layout(location = 1) in f32vec2 in_uv;

layout(location = 0) out vec4 color;

void main() {
    //color = vec4(in_color, 1.0);
    color = vec4(texture(daxa_sampler2DArray(push.textures, push.texturesSampler), vec3(in_uv, 1.0)).rgb, 1.0);
}

#endif