/*
* Same as quadmesh_C but introducing the displace_quad function
* to real-time move quads in y-direction.
*/


// quad mesh
PShape mesh;
  
  
// USER PARAMETERS
int N = 20;
float MESH_WIDTH = 500;

float Y_OFFSET = 200;
  
  
/*
* This function finds the quad on indexed position xi, zi and sets the y-coordinate.
* xi and zi are not the xz-world coordinates but the indices of row and column of the mesh.
* (N/2, N/2) would be the quad in the middle.
*/
void displaceQuad (PShape shape, int x, int z, float y) {
  
  // find the start vertex of the quad on position xi, zi
  int index = x*4 + z*N*4;
  for (int i=0; i<4; i++) {
    PVector v = shape.getVertex(index+i);
    v.y = y;
    shape.setVertex(index+i,v);  
  }
}

void displaceVertex (PShape shape, int index, float y) {
    PVector v = shape.getVertex(index);
    v.y = y;
    shape.setVertex(index,v);  
}



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
  for (int i=0; i < N; i++) {
    for (int j = 0; j < N; j++) {
  
      // we calculate the y position of each quad 
      float y = Y_OFFSET;
  
  
  
      // color red for all vertices
      mesh.fill(200,0,0);
      
      if ((i+j)%2==0) {
        mesh.fill(0,200,0);
      }
      
          
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
  
  // move the middle quad in y-direction
  displaceQuad (mesh, N/2, N/2, sin(frameCount*0.1)*150+200);
  
  shape(mesh);
}
