#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec3 camera;
varying vec3 pos;


void main() {
	float d = -(pos.z+692.0)*0.001;	

	//length (gl_FragCoord.xyz - camera);
	
	gl_FragColor = vec4(d,d,d,1.0);
}