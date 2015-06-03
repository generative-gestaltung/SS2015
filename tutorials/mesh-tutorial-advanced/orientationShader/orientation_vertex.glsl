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

	float d = 1.0 / N;
	d *= (7/(1+length(vertex.xy-vec2(N/2, N/2))));

	float dx = -d/2;
	float dy = -d/2;
	
	if (vertex.z==1) {
		dx = d/2;
	}
	if (vertex.z==2) {
		dx = d/2;
		dy = d/2;
	}
	if (vertex.z==3) {
		dy = d/2;
	}

	//dx *= sin(time);
	//dy *= cos(time);
	
	dx = d*sin(time+vertex.z/2*PI);
	dy = d*cos(time+vertex.z/2*PI);

	vec3 newPosition = (vertex.xyz/N + vec3(dx,dy,0)) * vec3(w,h,0);

	gl_Position = transform * vec4(newPosition,1) ;
    vertColor = vec4(vertex.x/N,vertex.y/N,1,1);
}


	//d *= (1/(1+length(vertex.xy-vec2(N/2, N/2))));
	//dx = d*sin(time+vertex.z/4*2*PI);
	//dy = d*cos(time+vertex.z/4*2*PI);