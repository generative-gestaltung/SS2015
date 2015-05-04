PVector p0 = new PVector(0,0);
PVector p1 = new PVector(100,0);
PVector p2 = new PVector(100,0);


float r = 100;
float angle = 0;

void setup() {
 size(800,800); 
 frameRate(20);
}


void update() {
  angle = PI/100 * frameCount;   
  
  p2 = p1.get();
  p2.rotate(angle);
}

void draw() {
  
  update();  
  clear();
  stroke(255);
 
  translate(width/2, height/2);
  
  line(p0.x, p0.y, p2.x, p2.y);
  line(p0.x, p0.y, p1.x, p1.y);
}


















// r = 100;
// p2.x = (float)(r*Math.cos(angle));
// p2.y = (float)(r*Math.sin(angle));  

// println(PVector.angleBetween(p1,p2)+" "+calcAngle(p1,p2));

float calcAngle(PVector v1, PVector v2) {
  float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
  if (a < 0) a += TWO_PI;
  return a;
}
