float size = 5;

PVector noiseValues[];

int N = 200;
int downSample = 80;

void setup() {
  size(800,600);
  frameRate(24);
  
  noiseValues = new PVector[width/downSample];  
  for (int i=0; i<width/downSample; i++) {
    noiseValues[i] = new PVector(random(0f,1f),random(0f,1f), random(0f,1f ));
  }
}


PVector getRandomValue (float x) {
  int lookup = floor(x / downSample);
  return noiseValues[lookup].get();
}

void draw() {
  
  clear();
  
  // DRAW COLOR BAR
  noStroke();
  for (int i=0; i<width; i++) {
    pushMatrix();
    PVector c = getRandomValue(i);
    c.mult(255);
    fill(c.x, c.y, c.z);
    translate(i, 200);
    rect(0,0,1,100);
    popMatrix();
  }
  
  // DROW SIGNAL GRAPH
  translate(0, 400);
  scale(1,-1);
  stroke(255);
  for (int i=0; i<width; i++) {
    //point(i,getRandomValue(i).x*100);
    point(i,getRandomValueInterpolated(i).x*100);
  }
}











PVector getRandomValueInterpolated (int x) {
  int lookup0 = floor(x / (float)downSample);
  int lookup1 = ceil(x / (float)downSample);
  if (lookup1==width/downSample) lookup1 -= 1;
  
  float interpolate = (x%downSample)/(float)downSample;
  
  PVector ret = new PVector(0,0,0);
  ret.x = lerpCos(noiseValues[lookup0].x, noiseValues[lookup1].x, interpolate);
  ret.y = lerpCos(noiseValues[lookup0].y, noiseValues[lookup1].y, interpolate);
  ret.z = lerpCos(noiseValues[lookup0].z, noiseValues[lookup1].z, interpolate);
  
  return ret;
}

/*
float lerp(float a0, float a1, float w) {
  return (1f - w)*a0 + w*a1;
}
*/

float lerpCos (float a0, float a1, float w) {
  float w2;
  w2 = (1-cos(w*PI))/2;
  return(a0*(1-w2)+a1*w2);
}
