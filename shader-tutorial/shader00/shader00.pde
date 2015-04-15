/*
* This sketch demonstrates the basic processing shader pipeline. 
* We draw 4 vertices with the SimpleFrag and SimpleVert shader. This gives
* us the exact result 
*/
PShader simpleShader;
PShape mesh;

void setup() {
  size(640, 360, P3D);
  noStroke();
  fill(204);
  
  simpleShader = loadShader("SimpleFrag.glsl", "SimpleVert.glsl");
  
  
  // Create a basic quad. Assign different fill attributes to the vertices.
  // When passing these values from vertex to fragment stage, these values
  // are interpolated.
  mesh = createShape();
  mesh.beginShape(QUADS);
  
  mesh.fill(255,0,0);
  mesh.vertex (0,0,0,0,0);
  mesh.fill(0,255,0);
  mesh.vertex (50,0,0,0,0);
  mesh.vertex (50,50,0,0,0);
  mesh.vertex (0,50,0,0,0);

  mesh.endShape();
}

void draw() {
  
  shader(simpleShader);
  background(0); 

  translate(width/2,height/2);
  strokeWeight(1);
  shape(mesh);
}
