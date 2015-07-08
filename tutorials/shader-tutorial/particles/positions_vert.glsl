#version 120
#define PROCESSING_COLOR_SHADER

uniform mat4 transform;
uniform mat3 normalMatrix;

// use these 2 attributes
attribute vec4 vertex;
attribute vec2 texCoord;

attribute vec4 color;
attribute vec3 normal;



varying vec2 coord;


void main() {

	//coord = gl_FragCoord.xy / vec2(width, height);
	//gl_Position = transform * vec4(pos,1);
}