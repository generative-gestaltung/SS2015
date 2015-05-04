#version 120
#define PI 3.1417

uniform mat4 transform;
uniform mat3 normalMatrix;

//custom uniforms
uniform float timePassed;
float freq = 2*PI;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;

void main() {
    
    float x = sin (freq * timePassed + (vertex.x*vertex.y)*0.01);
    vec4 position = vertex + vec4 (150*x,0,0,0);
	gl_Position = transform * (position) ;
	
    vertColor = color;
}
