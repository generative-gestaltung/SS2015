/*
* Same as quadmesh_C but introducing the displace_quad function
* to real-time move quads in y-direction.
*/


// quad mesh
PShape mesh;
  
  
// USER PARAMETERS
int N = 400;
float MESH_WIDTH = 1000;

float Y_OFFSET = 200;
  
  
/*
* This function finds the quad on indexed position xi, zi and sets the y-coordinate.
* xi and zi are not the xz-world coordinates but the indices of row and column of the mesh.
* (N/2, N/2) would be the quad in the middle.
*/
void displaceQuadY (PShape shape, int x, int z, float y) {
  // find the start vertex of the quad on position xi, zi
  int index = z*4 + x*N*4;

  for (int i=0; i<4; i++) {
    PVector v = shape.getVertex(index+i);
    v.y = y;
    shape.setVertex(index+i,v);  
  }
}

void displaceVertex (PShape shape, int x, int z, float y) {
    // TODO: not implemented yet
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
  
      // noise freq
      float wx = 0.01;
      float wz = 0.01;
      
      // calculate 2D noise-value, dependant on x,z coordinate
      // noise (w*x, w*z);
      float b = noise (wx*i, wz*j)*255;
      mesh.fill (b);
      mesh.vertex(i*w, b, -j*w);
      
      b = noise (wx*(i+1), wz*j)*255;
      mesh.fill (b);
      mesh.vertex((i+1)*w, b, -j*w);
      
      b = noise(wx*(i+1), wz*(j+1))*255;
      mesh.fill (b);
      mesh.vertex((i+1)*w, b, -(j+1)*w);
      
      b = noise(wx*i,wz*(j+1))*255;
      mesh.fill (b);
      mesh.vertex(i*w, b, -(j+1)*w);
    }
  }
  mesh.endShape();
}

float calcY_0 (int x, int z, int frameCount) {
  float A = 100.0;
  float w = 2*PI*0.001;
  return sin(z)*A+200;
} 
  
  
int lod = 1;

void draw() {   

  lod = 1 + frameCount/40;
  background(0);
  
  // center mesh to camera
  translate (width/2 - MESH_WIDTH/2, height/2, 0);
  
  // move the middle quad in y-direction
  
  
  float wx = 0.01;
  float wz = 0;
  float t = frameCount*0.01;
 
  for (int x=0; x<N; x++) {
    for (int z=0; z<N; z++) {
    
      float y = 0;
      noiseDetail(lod,0.7);
      y += 255 * noise(0.01*x, 0);
      //y += 50 * noise(0.1*x+t*10, 0);
      
      
      displaceVertex (mesh, x, z, y);
    }
  }
  
  shape(mesh);
}
