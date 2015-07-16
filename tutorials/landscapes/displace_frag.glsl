#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif



varying vec3 norm;
varying vec3 pos;
varying vec3 col;

uniform vec3 sunPos;
uniform vec3 camPos;


void main() {

  vec3 dir = sunPos-pos.xyz;
  dir = dir/length(dir);

  // use the normal added to the mesh
  float b = dot(norm.xyz, dir);

  gl_FragColor = vec4 (col, 1.0);
}