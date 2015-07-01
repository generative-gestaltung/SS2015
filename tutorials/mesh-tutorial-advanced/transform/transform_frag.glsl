#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

void main() {

/*
  float phase = time*0.1;
  vec3 offset = vec3 (0, sin(position.x*0.05+phase), 0);
  vec3 dif = cross(position, offset)*0.0001;

  vec3 ref = refract (norm, vertTexCoord.xyz, 0.1);
  ref = vec3(gl_TextureMatrix[0] * vec4(ref, 1.0));
*/

  gl_FragColor = vec4(0.4, 0.4, 1.0, 0.6);
  //texture2D(texture, ref.yz*10.0) * vertColor;
}