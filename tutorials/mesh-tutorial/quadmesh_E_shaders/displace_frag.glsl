#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


/*
* The only thing that happens here is that the color, which comes
* from the vertex shader is interpolated to the fragments (aka screen pixels).
*/


varying vec4 vertColor;


void main() {
  gl_FragColor = vertColor;
}