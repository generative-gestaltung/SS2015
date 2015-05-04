PVector p0 = new PVector(0,0);
PVector p1 = new PVector(0,0);

final PVector nx = new PVector(1,0);
final PVector ny = new PVector(0,1);

void setup() {
 size(800,800); 
 frameRate(20);
}

float calcAngle(PVector v1, PVector v2) {
  float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
  if (a < 0) a += TWO_PI;
  return a;
}


void update() {
}

void draw() {
  
  update();  
  clear();
  stroke(255);
 
  translate(width/2, height/2);
  
  PVector offset = new PVector(0,0);
  for (int i=-20; i<20; i++) {
    for (int j=-20; j<20; j++) {
      offset = new PVector(i,j);
      offset.mult(15);
      
      p1 = nx.get();
      float angle = PVector.angleBetween(offset, ny);//calcAngle(nx,offset);
      p1.rotate(angle);
      p1.mult(10);
      line(p0.x+offset.x, p0.y+offset.y, p1.x+offset.x, p1.y+offset.y);
    }
  }
}
