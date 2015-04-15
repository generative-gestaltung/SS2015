#version 120

uniform mat4 transform;
uniform mat3 normalMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;

void main() {
	gl_Position = transform * (vertex) ;
    
	vertColor = color;
    vertColor = vec4(vertex.xyz/50.0,1.0);
}
