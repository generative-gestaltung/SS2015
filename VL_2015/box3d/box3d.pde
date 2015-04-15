void setup() {
  size (400, 400, P3D);
}

void draw() {
  clear();
  //noStroke();
  translate(0, 0, -2*frameCount);
  
  pushMatrix();
  translate(200, 0, 10);
  //box(50,50,50);
  sphere(150);
  popMatrix();
  
  pushMatrix();
  translate(-200, 0, 0); 
  box(50,50,50);
  popMatrix();
}
