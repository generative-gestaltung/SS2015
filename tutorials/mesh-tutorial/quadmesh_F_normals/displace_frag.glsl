#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


/*
* The only thing that happens here is that the color, which comes
* from the vertex shader is interpolated to the fragments (aka screen pixels).
*/


varying vec4 position;
varying vec4 norm;

uniform vec3 sunPosition;
uniform vec3 sunColor;

void main() {

  vec3 dir = sunPosition-position.xyz;
  dir = dir/length(dir);


  // use the normal added to the mesh
  float b = dot(norm.xyz, dir);


  gl_FragColor = vec4 (sunColor*b, 1.0);
}