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
varying vec2 vertTexCoord;

void main() {
    
    vec2 t = vec2 (timePassed*0.01, timePassed*0.04);
    vec2 phase = vec2 (vertex.y* 0.01, vertex.x*0.004);
    
    vec2 add_xy = sin (freq * timePassed + phase);
    add_xy *= texCoord.xy * vec2(rect_w,rect_h);
    
    vec4 position = vertex + vec4 (add_xy, 0, 0);
	gl_Position = transform * (position) ;
	
    vertColor = color;
    vertTexCoord = texCoord;
}
