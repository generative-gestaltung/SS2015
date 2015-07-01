#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;

uniform sampler2D tex0;
uniform sampler2D tex1;
uniform float scale;


varying vec2 coord;


void main() {
	
	// iterate thru neighborhood to calc blur
	
	// the center pixel
	vec4 pixel = vec4(0,0,0,0);

	int N = 4;
	for (int i=-N; i<=N; i++) {
		for (int j=-N; j<=N; j++) {
			float falloff = length(vec2(i,j));
			if (falloff==0.0) falloff = 1.0;
			pixel += texture2D(tex1, coord+vec2(i,j)*scale) / falloff;
		}
	}
	
	pixel = pixel / 16.0;
	gl_FragColor = pixel;



	//gl_FragColor = vec4 (texture2D(tex0, tex).xyz, 1); // + texture2D(tex1, tex).xyz, 1.0);
}
