#version 120
#define PI 3.1417

// standard uniform to transform world coordinates to screen coordinates
uniform mat4 transform;
uniform mat3 normalMatrix;

//custom uniforms, pass time from application to shader
uniform float timePassed;
float freq = 2*PI;

// processing-defined attributes, which can be assigned to each vertex
attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

varying vec4 vertColor;

void main() {
    
    // calculate an offset in x direction as sine function of the time
    float x = sin (freq * timePassed);
    
    // add offset to vertex position
    vec4 position = vertex + vec4 (100*x,0,0,0);
    
    // transform to screen coordinates
	gl_Position = transform * (position) ;
    
    // pass color to fragment stage
	vertColor = color;
}
