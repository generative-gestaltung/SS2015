#version 120
#define PI 3.14

uniform mat4 transform;
uniform mat3 normalMatrix;

uniform float time;
uniform int w;
uniform int h;
uniform int N;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;



void main() {

	float phase = time;

	float d = 1.0 / N;
	//d *= (1/(1+length(vertex.xy-vec2(N/2, N/2))));

	float dx = -d/2 * normal.y;
	float dy = -d/2 * normal.z;
	float dz = 100 * normal.x; //) * sin(phase+vertex.x*0.1);


	phase = time - normal.x*PI*0.95;
	if (phase<0) phase=0;
	dz *= sin(phase);

	dx *= cos(phase)*abs(vertex.x-N/2);
	dy *= cos(phase*PI);
	
	vec3 newPosition = (vertex.xyz/N + vec3(dx,dy,dz)) * vec3(w,h,1);

	gl_Position = transform * vec4(newPosition,1) ;
    vertColor = vec4(vertex.xyz/N,1);
}


	//d *= (1/(1+length(vertex.xy-vec2(N/2, N/2))));
	//dx = d*sin(time+vertex.z/4*2*PI);
	//dy = d*cos(time+vertex.z/4*2*PI);