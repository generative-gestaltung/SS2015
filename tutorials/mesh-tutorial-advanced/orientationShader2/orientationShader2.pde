/*
*  In this sketch the host application passes data to the shader
*  using the uniform construct. The fragment shader is the same
*  as in shader00.pde. The vertex shader is used to displace
*  each vertex.
*/

PShader shader;
PShape mesh;

int N = 50;

void setup() {
  
  size(800, 800, P3D);
  noStroke();
  fill(204);
  frameRate(24);
  
  shader = loadShader("orientation_3D_fragment.glsl", "orientation_3D_vertex.glsl");
  
  // create mesh
  mesh = createShape();
  mesh.beginShape(QUADS);
  mesh.fill(255,0,0);
  //mesh.stroke(255);
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      for (int k=0; k<N; k++) {
        
        mesh.normal (0,0,0);
        mesh.vertex (i,j,k);
        mesh.normal (0,1,0);
        mesh.vertex (i,j,k);
        mesh.normal (0,1,1);
        mesh.vertex (i,j,k);
        mesh.normal (0,0,1);
        mesh.vertex (i,j,k);
        
        mesh.normal (1,0,0);
        mesh.vertex (i,j,k);
        mesh.normal (1,1,0);
        mesh.vertex (i,j,k);
        mesh.normal (1,1,1);
        mesh.vertex (i,j,k);
        mesh.normal (1,0,1);
        mesh.vertex (i,j,k);
        
        mesh.normal (2,0,0);
        mesh.vertex (i,j,k);
        mesh.normal (2,1,0);
        mesh.vertex (i,j,k);
        mesh.normal (2,1,1);
        mesh.vertex (i,j,k);
        mesh.normal (2,0,1);
        mesh.vertex (i,j,k);
        
        mesh.normal (3,0,0);
        mesh.vertex (i,j,k);
        mesh.normal (3,1,0);
        mesh.vertex (i,j,k);
        mesh.normal (3,1,1);
        mesh.vertex (i,j,k);
        mesh.normal (3,0,1);
        mesh.vertex (i,j,k);
        
        mesh.normal (4,0,0);
        mesh.vertex (i,j,k);
        mesh.normal (4,1,0);
        mesh.vertex (i,j,k);
        mesh.normal (4,1,1);
        mesh.vertex (i,j,k);
        mesh.normal (4,0,1);
        mesh.vertex (i,j,k);
        
        mesh.normal (5,0,0);
        mesh.vertex (i,j,k);
        mesh.normal (5,1,0);
        mesh.vertex (i,j,k);
        mesh.normal (5,1,1);
        mesh.vertex (i,j,k);
        mesh.normal (5,0,1);
        mesh.vertex (i,j,k);
      }
    }
  }
  mesh.endShape();
}

void draw() {
  
  float time = frameCount / 20;
  camera(width/2, mouseY*2, 220.0, // eyeX, eyeY, eyeZ
         width/2, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
  
  shader.set("time", time);  
  shader.set("N", N);
  shader.set("w", width);
  shader.set("h", height);
  
  shader(shader);
  background(0); 
  shape(mesh);
}
