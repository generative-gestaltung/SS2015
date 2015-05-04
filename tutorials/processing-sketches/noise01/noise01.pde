
PVector center;
PVector nx;
float size = 5;
int gridSize = 10;

void setup() {
  size(800,600);
  frameRate(24);
  
  center = new PVector(0,0);
}

void update() {
  
}


void draw() {
  
  update();
  clear();
  
  noStroke();
  //translate(width/2, height/2);
  
  
  
  for (int i=0; i<width/gridSize; i++) {
    for (int j=0; j<height/gridSize; j++) {
      
      PVector c = new PVector ((float)Math.random(),(float)Math.random(),(float)Math.random());
      c.mult(255);
      fill(c.x,c.y,c.z);
      
      pushMatrix();
      translate(i*gridSize, j*gridSize);
      rect(0,0,gridSize,gridSize);
      popMatrix();
    }
  }
}


/*
float lerp(float a0, float a1, float w) {
  return (1f - w)*a0 + w*a1;
}
*/
