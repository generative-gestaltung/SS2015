#define PROCESSING_COLOR_SHADER

/*
* default processing variables, used to map the geometry from world coordinates to screen coordinates.
*/
uniform mat4 transform;
uniform mat4 texMatrix;

/*
* default processing attributes, that are set for each vertex during setup in quadmesh_E.pde
*/
attribute vec4 vertex;
attribute vec4 color;
attribute vec4 normal;

varying vec4 position;
varying vec4 norm;


// USER PARAMETERS
float SIN_X_FREQUENCY = 1.0;
float SIN_Z_FREQUENCY = 2.2;

float SIN_X_AMPLITUDE = 100.0;
float SIN_Z_AMPLITUDE = 300.0;

float Y_OFFSET = 200.0;

void main() {

	
  // this is the default vertex position coming from the mesh creation code in the sketch
  position = vertex;
  norm = normal;

  
  // map world coordinate to screen coordinates
  gl_Position = transform * position;
}