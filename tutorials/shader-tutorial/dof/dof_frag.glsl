#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec3 vertColor;
varying vec3 vert;


uniform sampler2D tex0;

float scale = 0.001;




void main() {
	

	
	// iterate thru neighborhood to calc blur
	vec2 coord = gl_FragCoord.xy / vec2(800,800);

	// the center pixel
	vec4 pixel = vec4(0,0,0,0);

	scale = -0.0001 * vert.z;
	int N = 4;
	for (int i=-N; i<=N; i++) {
		for (int j=-N; j<=N; j++) {
			float falloff = length(vec2(i,j));
			if (falloff==0.0) falloff = 1.0;
			pixel += texture2D(tex0, coord+vec2(i,j)*scale) / falloff;
		}
	}
	
	pixel = pixel / 16.0;

	gl_FragColor = pixel;


}
