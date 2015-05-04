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

varying vec4 vertColor;



// USER PARAMETERS
float SIN_X_FREQUENCY = 1.0;
float SIN_Z_FREQUENCY = 2.2;

float SIN_X_AMPLITUDE = 100.0;
float SIN_Z_AMPLITUDE = 300.0;

float Y_OFFSET = 200.0;

void main() {

	
  // this is the default vertex position coming from the mesh creation code in the sketch
  vec4 position = vertex;

  // TODO: uncomment next line, to override position value with a value calculated here in the shader
  position.y = Y_OFFSET + SIN_X_AMPLITUDE * sin (position.x*0.01)
  						+ SIN_Z_AMPLITUDE * sin (position.z*0.01);

  
  // map world coordinate to screen coordinates
  gl_Position = transform * position;


  // use the color defined in the sketch    
  vertColor = color;
}