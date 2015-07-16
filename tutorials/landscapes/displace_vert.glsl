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
varying vec3 col;


uniform float terrain_w;
uniform float h0;
uniform float h2;
uniform float bottom0;
uniform float top0;
uniform float thresh1;

uniform sampler2D noise;


float calcHeight(float x, float z) {
  return texture2D(noise, vec2(vertex.x,vertex.z)).x;
}



void main() {


  vec2 coord = vertex.xz;
  if (coord.x<0.0) coord.x=0.0;
  if (coord.y<0.0) coord.y=0.0;

  vec3 noiseTxt = texture2D(noise, coord).xyz;
  float noise0 = noiseTxt.x;
  float noise1 = noiseTxt.y;
  float noise2 = noiseTxt.z;	
  
  vec4 position = vertex;
  norm = vec3(0);
  pos = vec3(0);

  position.y = 0.0;
  int zone = 1;

  // sealevel theshold
  if (noise0<bottom0) {
    noise0 = bottom0;
    zone = 0;
  }


  else {
    zone = 1;
    // define terrain type by thresholding with noise 1
    if (noise1>thresh1) {
      noise1 -= thresh1;
      if (noise1<0.0) noise1=0.0;
      zone = 2;
    }
  }

  
  col = vec3(noise0);

  position.y = -noise0 * h0;

  if (zone==0) {
    col = vec3(0,0,1.0);
  }
  else {
    position.y -= (noise2*h2*noise1);
  }
  if (zone==1) {
    col = noise0*0.5 + noise1*vec3(0.1,0.3,0.7);
  }
  if (zone==2) {
    col = noise0*0.5 + noise2*vec3(0.3,1.0,0.3);
  }



/*
  // calculate normal
  vec3 p0 = position.xyz;
  vec3 p1 = vec3(position.x+0.001, calcHeight(position.x+0.001, position.z), position.z);
  vec3 p2 = vec3(position.x, calcHeight(position.x+0.001, position.z), position.z+0.001);

  vec3 v01 = normalize(p0-p1);
  vec3 v02 = normalize(p0-p2);

  // this is passed as varying vec
  norm = normalize(cross(v01,v02));
*/

  // stretch the mesh on user defined dimensions
  position.x *= terrain_w;
  position.z *= terrain_w;
  
  
  // map world coordinate to screen coordinates
  gl_Position = transform * position;


  // this is passed as varying vec
  pos = position.xyz;
}