/*
*  In this sketch the host application passes data to the shader
*  using the uniform construct. The fragment shader is the same
*  as in shader00.pde. The vertex shader is used to displace
*  each vertex.
*/

PShader shader;
PShape mesh;

int N = 100;

void setup() {
  
  size(600, 600, P3D);
  noStroke();
  fill(204);
  
  shader = loadShader("orientation_fragment.glsl", "orientation_vertex.glsl");
  
  // create mesh
  mesh = createShape();
  mesh.beginShape(QUADS);
  mesh.fill(255,0,0);
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      mesh.vertex (i,j,0);
      mesh.vertex (i,j,1);
      mesh.vertex (i,j,2);
      mesh.vertex (i,j,3);
    }
  }
  mesh.endShape();
}

void draw() {
  
  float time = frameCount / frameRate;
  
  shader.set("time", time);
  shader.set("N", N);
  shader.set("w", width);
  shader.set("h", height);
  shader(shader);
  
  
  background(0); 

  // draw mesh
  shape(mesh);
}
