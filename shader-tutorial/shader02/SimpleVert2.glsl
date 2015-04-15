#version 120
#define PI 3.1417

uniform mat4 transform;
uniform mat3 normalMatrix;

//custom uniforms
uniform float timePassed;
uniform float rect_w;
uniform float rect_h;

float freq = 2*PI;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;

void main() {
    
    float t = timePassed;
    
    float add_x = sin (freq * timePassed) / 2 - 0.5;
    add_x *= texCoord.x * rect_w;
    
    vec4 position = vertex + vec4 (add_x,0,0,0);
	gl_Position = transform * (position) ;
	
    vertColor = color;
}
