PVector p0;
PVector p1 = new PVector(0,0);
int x;

void setup() {
   size(800,800); 
   frameRate(20);
   p0 = new PVector(width/2,height/2);
   x = 0;
}


void draw() {
  
  background(0,0,50);  
  
  lights();
  stroke(0);
  fill(255,100,100);
  
  int N = 20;
  
  for (int i=0; i<width; i+=N) {
    for (int j=0; j<height; j+=N) {
      
      PVector offset = new PVector(i,j);
      //offset.mult(N);
      
      float d = offset.dist(p0)*1f;
      if (d==0) d=0.1f;
      
      g.pushMatrix();
      translate(offset.x, offset.y);
      rect (0,0,d/10,d/10);
      g.popMatrix();
    }
  }
}
