#define PROCESSING_COLOR_SHADER
#define PI 3.1417

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


// pass the normal and the position to the fragment stage
varying vec3 norm;
varying vec3 pos;


uniform float terrain_w;
uniform float terrain_h;



float calcHeight (float x, float z) {
  float s = sin(x*4.0*PI) * sin(z*4.0*PI);
  return (s*0.5)+0.5;
}


void main() {

	
  
  vec4 position = vertex;

  // calculate height based on x and z position
  position.y = calcHeight(position.x, position.z);

  // calculate normal
  vec3 p0 = position.xyz;
  vec3 p1 = vec3(position.x+0.01, calcHeight(position.x+0.01, position.z), position.z);
  vec3 p2 = vec3(position.x, calcHeight(position.x+0.01, position.z), position.z+0.01);

  vec3 v01 = normalize(p0-p1);
  vec3 v02 = normalize(p0-p2);

  // this is passed as varying vec
  norm = normalize(cross(v01,v02));

  
  // stretch the mesh on user defined dimensions
  position.x *= terrain_w;
  position.z *= terrain_w;
  position.y *= terrain_h;
  
  
  // map world coordinate to screen coordinates
  gl_Position = transform * position;


  // this is passed as varying vec
  pos = position.xyz;
}