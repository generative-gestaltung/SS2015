#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D tex0;
uniform sampler2D tex1;
uniform float time;


varying vec2 tex;


void main() {

	vec4 col;

	vec2 tx = tex;
	tx.y += time*0.1;

	if (tx.y<1.0) {

		vec3 c = texture2D(tex0, tx).xyz;
		col = vec4 (c.x, c.x, c.x, 1); 
	}
	else if (tx.y<2.0) {
		tx.y -= 1.0;
		vec3 c = texture2D(tex0, tx).xyz;
		col = vec4 (c.y, c.y, c.y, 1); 
	}
	else {
		tx.y -= 2.0;
		vec3 c = texture2D(tex0, tx).xyz;
		col = vec4 (c.z, c.z, c.z, 1); 
	}
	//gl_FragColor = vec4 (texture2D(tex0, tx).xyz, 1); 
	gl_FragColor = col;
}
