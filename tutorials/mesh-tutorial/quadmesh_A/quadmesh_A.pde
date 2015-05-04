/*
* In this example we use the class PShape to create a quad mesh. We apply colors 
* to the vertices;
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
  // color red for all vertices
  mesh.fill(255,0,0);
  
  // iterate over grid, create 4 vertices to draw a single quad
  for (int j=0; j < 4; j++) {
    for (int i = 0; i < 4; i++) {
      
      mesh.vertex(i*w, j*h, 0);
      mesh.vertex((i+1)*w, j*h, 0);
      mesh.vertex((i+1)*w, (j+1)*h, 0);
      mesh.vertex(i*w, (j+1)*h, 0);
    }
  }
  mesh.endShape();
}


void draw() {   
  background(0);
  
  // draw the mesh
  shape(mesh);
}
