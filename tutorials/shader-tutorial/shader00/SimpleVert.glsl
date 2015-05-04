#version 120
#define PI 3.14

uniform mat4 transform;
uniform mat3 normalMatrix;
uniform int frameCount;


attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;



void main() {


	vec4 newPosition = vertex + vec4(100.0 * sin(frameCount*0.05),0,0,0);
	gl_Position = transform * (newPosition) ;
    
	//vertColor = color;
    vertColor = vec4(vertex.xyz/50.0,1.0);
    vertColor *= sin(frameCount*0.1);
}