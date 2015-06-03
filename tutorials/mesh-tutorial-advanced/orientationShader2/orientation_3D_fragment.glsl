#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;

void main() {
	gl_FragColor = vertColor;
	//gl_FragColor = vec4 (gl_FragCoord.xyz*0.001,1.0);
}