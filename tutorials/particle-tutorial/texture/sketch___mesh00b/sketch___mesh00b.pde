/*
* In this example we add a function to access vertices in the shape and displace them.
*/

// texture
PImage img;

// quad mesh
PShape mesh;

/*
* Displace a quad in the mesh, specified by index. Index*4 gets us the first vertex of the quad.
* Iterate over this vertex and the next three, change the z-coordinate and write back to the shape.
* @param shape: the shape to be manipulated
* @param index: index of the quad
*/
void displaceQuad (PShape shape, int index) {
  for (int i=0; i<4; i++) {
    PVector v = shape.getVertex(index+i);
    v.z = 50;
    shape.setVertex(index+i,v);  
  }
}

/* Create a quadmesh with N*M quads. each vertex gets a position and texture coordinates.
   4 vertices form a quad.
   
   @param totalWidth: display width of the mesh in world coordinates
   @param totalHeight: display height of the mesh in world coordinates
   @param N: horizontal resolution of the mesh
   @param M: vertical resolution of the mesh
   @param tex: texture to be drawn on the mesh
*/
PShape createMesh (float totalWidth, float totalHeight, int N, int M, PImage tex) {

  // calculate size of a single quad
  float w = totalWidth/N;
  float h = totalHeight/M;
  float z = 0;
    
  // create a pshape and add vertices, xyz: world coordinates, uv: texture coordinates
  textureMode(NORMAL);
  PShape sh = createShape();
  
  // quad mesh means, each subsequent 4 vertices form a quad
  sh.beginShape(QUADS);
  
  // connect vertices with white lines
  sh.stroke(255);
  
  // attach texture to shape
  sh.texture(tex);
    
  // create rects line by line
  for (int j=0; j<M; j++) {
    for (int i = 0; i < N; i++) {
      
      float u = (float)i / N;
      float v = (float)j / M;
      sh.vertex(i*w, j*h, z, u, v);
      
      u = (float)(i+1) / N;
      v = (float)j / M;
      sh.vertex((i+1)*w, j*h, z, u, v);
      
      u = (float)(i+1) / N;
      v = (float)(j+1) / M;
      sh.vertex((i+1)*w, (j+1)*h, z, u, v);
      
      u = (float)i / N;
      v = (float)(j+1) / M;
      sh.vertex(i*w, (j+1)*h, z, u, v);
    }
  }
  sh.endShape();
  return sh;
}


void setup() {
  
  // init
  size(640, 360, P3D);  
  img = loadImage("volvox.jpg");
  
  // create a mesh of size 400x200 with 500 quads
  mesh = createMesh (400, 200, 50, 10, img);
}


void draw() {    
  background(0);
  translate(width/2-200, height/2-100);

  // change position of a single quad
  displaceQuad(mesh,100);
 
  shape(mesh);
}
