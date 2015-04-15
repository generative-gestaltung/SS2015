/*
* In this example we use the displace function to dynamically 
* change the position of all quads in the mesh.
*/

// texture
PImage img;

// quad mesh
PShape mesh;

// size and resolution of the mesh
int resX = 60;
int resY = 60;
int sizeX = 600;
int sizeY = 400;

/*
* Displace a quad in the mesh, specified by index. Index*4 gets us the first vertex of the quad.
* Iterate over this vertex and the next three, change the z-coordinate and write back to the shape.
* 
* @param shape: the shape to be manipulated
* @param index: index of the quad
* @param z: new z-coordinate of the quad
*/
void displaceQuad (PShape shape, int index, float z) {
  for (int i=0; i<4; i++) {
    PVector v = shape.getVertex(index*4+i);
    v.z = z;
    shape.setVertex(index*4+i,v);  
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
 
  textureMode(NORMAL);
  PShape sh = createShape();
  float w = totalWidth/N;
  float h = totalHeight/M;
  float z = 0;
  
  sh.beginShape(QUADS);
  sh.stroke(255);
  sh.noFill();
  sh.texture(tex);
    
  for (int j=0; j<M; j++) {
    for (int i = 0; i <N; i++) {
      
      // pixelate: use only these
      float u = (float)i / N;
      float v = (float)j / M;
      
      sh.vertex(i*w, j*h, z, u, v);
      
      u = (float)(i+1) / N;
      sh.vertex((i+1)*w, j*h, z, u, v);
      
      v = (float)(j+1) / M;
      sh.vertex((i+1)*w, (j+1)*h, z, u, v);
      
      u = (float)i / N;
      sh.vertex(i*w, (j+1)*h, z, u, v);
    }
  }
  
  sh.endShape();
  return sh;
}


void setup() {
  frameRate(30);
  size(640, 360, P3D);  
  img = loadImage("volvox.jpg");
  mesh = createMesh (sizeX, sizeY, resX, resY, img);
}

int cnt  = 0;


void draw() {    
  background(0);    
  translate(width/2-300, height/2-200, -200);
  
  // iterate over all quads and change the z position with a function of time and x-index
  PVector center = new PVector(resX/2, resY/2);
  
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
        //float z = sin(cnt*0.1f + i*0.5f)*20f;
        float phase = i+j; //center.dist(new PVector(i,j));
        float f = 0.1;
        float amplitude = 40;
        float z = amplitude*sin(phase*f + frameCount*0.1);
        displaceQuad (mesh, i + j*resX, z); 
    }
  }
  
  cnt += 1;
  shape(mesh);
}
