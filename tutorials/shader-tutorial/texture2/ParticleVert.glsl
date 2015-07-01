#version 120
#define PI 3.14

uniform mat4 transform;
uniform mat3 normalMatrix;
uniform int frameCount;


attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec2 tex;



void main() {


	gl_Position = transform * (vertex) ;
   	tex = texCoord;
}