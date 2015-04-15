PVector p0 = new PVector(0,0,10);
PVector p1 = new PVector(0,0,0);

PVector nx = new PVector(1,0,0);
PVector ny = new PVector(0,1,0);
PVector nz = new PVector(0,0,1);

void setup() {
 size(800,800,P3D); 
 frameRate(20);
}


void update() {
}

void draw() {
  
  update();
  background(0,0,50);  
  
  lights();
  stroke(0);
  fill(255,100,100);
 // noFill();
  
  
  translate(width/2, height/2,0);
  camera(20.0, mouseY, 220.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
  
  for (int i=-40; i<40; i++) {
    for (int j=-40; j<40; j++) {
      
      PVector offset = new PVector(i,j,0);
      offset.mult(10);
      
      float d = offset.dist(p0);
      if (d<0.1) d = 0.1;
      
      float h = 100 / (d*0.04);
      PVector size = new PVector(4,4,h);
      offset.z += h/2;
      
      g.pushMatrix();
      translate(offset.x, offset.y, offset.z);
      box (size.x,size.y,size.z);
      g.popMatrix();
    }
  }
}
