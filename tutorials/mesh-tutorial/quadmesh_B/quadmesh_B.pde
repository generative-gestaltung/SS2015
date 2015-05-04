/*
* We use the code from quadmesh_A, but change the coordinates of the quads. 
* Now we have the mesh lying in the x-z axis. Note, that negative values for 
* z-coordinate are leading in the view direction.
* We use the function PShape.fill to apply varying colors to the quads.
*/


// quad mesh
PShape mesh;


void setup() {
  
  size(600, 600, P3D);  
  mesh = createShape();
  
  // quad mesh means, each subsequent 4 vertices form a quad
  mesh.beginShape(QUADS);
  
  // connect vertices with white lines
  mesh.stroke(255);
  
  
  // quad width
  float w = 100;
  
  // quad height
  float h = 100;
  
  
  // y position of the quads
  float y = 600;
  
  // number of quads per axis
  int N = 20;
  
  // iterate over grid, create 4 vertices to draw a single quad
  for (int j=0; j < N; j++) {
    for (int i = 0; i < N; i++) {
  
      // color red for all vertices
      mesh.fill(255,0,0);
      
      if ((i+j)%2==0) {
        mesh.fill(0,255,0);
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
  
  // tranlate and draw the mesh
  translate (-600,0,0);
  shape(mesh);
}
