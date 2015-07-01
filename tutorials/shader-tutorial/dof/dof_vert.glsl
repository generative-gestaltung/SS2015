#version 120


uniform mat4 transform;
uniform mat3 normalMatrix;

// use these 2 attributes
attribute vec4 vertex;
attribute vec2 texCoord;

attribute vec4 color;
attribute vec3 normal;


// pass texcoord to fragment
varying vec3 vertColor;
varying vec3 vert;



void main() {

	gl_Position = transform * (vertex);

   	vertColor = vec3 (-vertex.z / 1000.0);
   	vert = vertex.xzy;
}