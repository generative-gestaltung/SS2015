#version 120
#define PI 3.14

uniform mat4 transform;
uniform mat3 normalMatrix;


attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;




void main() {


	vec4 newPosition = vertex; // + vec4(100.0 * sin(frameCount*0.05),0,0,0);
	gl_Position = transform * (newPosition);
}