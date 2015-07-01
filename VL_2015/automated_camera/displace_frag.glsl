#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif



varying vec3 norm;
varying vec3 pos;

uniform vec3 sunPos;
uniform vec3 camPos;


void main() {

  // calculate brightness as dot product of normal and the vector that points
  // the fragments position to the sun
  vec3 sunDir = normalize (sunPos-pos);
  float b = dot(sunDir, norm);


  gl_FragColor = vec4 (b,b,b,1.0);
}