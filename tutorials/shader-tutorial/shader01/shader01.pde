/*
*  In this sketch the host application passes data to the shader
*  using the uniform construct. The fragment shader is the same
*  as in shader00.pde. The vertex shader is used to displace
*  each vertex.
*/

PShader simpleShader;
PShape mesh;

float timePassed = 0f;
float lastTime = 0;


void setup() {
  size(640, 360, P3D);
  noStroke();
  fill(204);
  
  // load shader
  simpleShader = loadShader("SimpleFrag.glsl", "SimpleVertDisplace.glsl");
  
  // create mesh
  mesh = createShape();
  mesh.beginShape(QUADS);
  
  mesh.vertex (0,0,0,0,0);
  mesh.vertex (50,0,0,0,0);
  mesh.vertex (50,50,0,0,0);
  mesh.vertex (0,50,0,0,0);

  mesh.endShape();
  
  // init time measurement
  lastTime = millis() / 1000.0;
}

void draw() {
  
  // measure the passed time
  float currentTime = millis() / 1000.0;
  timePassed += (currentTime-lastTime);
  lastTime = currentTime;
  
  // pass the value to the shader 
  simpleShader.set("timePassed", timePassed);
  
  // enable shader
  shader(simpleShader);
  background(0); 

  // draw mesh
  translate(width/2,height/2);
  strokeWeight(1);
  shape(mesh);
}
