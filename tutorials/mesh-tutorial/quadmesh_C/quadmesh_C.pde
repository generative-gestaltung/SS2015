/*
* We use the code from quadmesh_B, but change the coordinates of the quads. 
* Again we start with a mesh in the x-z plane.
* We center the mesh to the camera, make the size and the resolution customizable.

*
* We also have the dimensions of each dependent from a user defined total width and 
* mesh resolution. In that way we can control the mesh much easier.
*/


// quad mesh
PShape mesh;
  
  
// USER PARAMETERS
int N = 140;
float MESH_WIDTH = 1900;

float SIN_X_FREQUENCY = 1.0;
float SIN_Z_FREQUENCY = 2.2;

float SIN_X_AMPLITUDE = 0.0;
float SIN_Z_AMPLITUDE = 0.0;

float Y_OFFSET = 200;
  
  

void setup() {
  
  size(600, 600, P3D);  
  mesh = createShape();
  
  // quad mesh means, each subsequent 4 vertices form a quad
  mesh.beginShape(QUADS);
  
  // draw no lines
  mesh.noStroke();
  
  
  // CALCULATED PARAMETERS
  float w = MESH_WIDTH/N;
  float h = MESH_WIDTH/N;
  
  // iterate over grid, create 4 vertices to draw a single quad
  for (int j=0; j < N; j++) {
    for (int i = 0; i < N; i++) {
  
      // color red for all vertices
      mesh.fill(255,0,0);
      
      if ((i+j)%2==0) {
        mesh.fill(0,255,0);
      }
      
      // we calculate the y position of each quad 
      float y =   SIN_X_AMPLITUDE*sin(i*SIN_X_FREQUENCY*PI/N) 
                + SIN_Z_AMPLITUDE*sin(j*SIN_Z_FREQUENCY*PI/N)
                + Y_OFFSET;
  
  
      // create vertices with coordinates
      mesh.vertex(i*w, y, -j*w);
      mesh.vertex((i+1)*w, y, -j*w);
      mesh.vertex((i+1)*w, y, -(j+1)*w);
      mesh.vertex(i*w, y, -(j+1)*w);
    }
  }
  mesh.endShape();
}


void draw() {   
  background(0);
  
  // center mesh to camera
  translate (width/2 - MESH_WIDTH/2, height/2, 0);
  shape(mesh);
}
