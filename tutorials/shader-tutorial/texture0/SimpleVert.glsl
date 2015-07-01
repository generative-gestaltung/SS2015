#version 120


uniform mat4 transform;
uniform mat3 normalMatrix;

// use these 2 attributes
attribute vec4 vertex;
attribute vec2 texCoord;

attribute vec4 color;
attribute vec3 normal;


// pass texcoord to fragment
varying vec2 coord;



void main() {

	gl_Position = transform * (vertex) ;
   	coord = texCoord;
}