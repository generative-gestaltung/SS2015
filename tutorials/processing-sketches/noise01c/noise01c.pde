
PVector center;
PVector nx;
float size = 5;

PVector noiseValues[][];

int downSample = 40;
int nTimeSteps = 10;
float timePassed = 0f;


void setup() {
  size(800,600);
  frameRate(24);
  
  noiseValues = new PVector[width/downSample][nTimeSteps];  
  for (int i=0; i<width/downSample; i++) {
    for (int t=0; t<nTimeSteps; t++) {
      noiseValues[i][t] = new PVector(random(0f,1f),random(0f,1f), random(0f,1f ));
    }
  }
}




PVector getRandomValueInterpolated (float x, float t) {
  int lookup0 = floor(x / downSample);
  int lookup1 = ceil(x / downSample);
  
  int t0 = floor(t);
  int t1 = ceil(t);
  if (lookup1==width/downSample) lookup1 -= 1;
  
  float interpolate = (x%downSample)/(float)downSample;
  
  PVector ret = new PVector(0,0,0);
  ret.x = lerp(noiseValues[lookup0][0].x, noiseValues[lookup1][0].x, interpolate);
  ret.y = lerp(noiseValues[lookup0][0].y, noiseValues[lookup1][0].y, interpolate);
  ret.z = lerp(noiseValues[lookup0][0].z, noiseValues[lookup1][0].z, interpolate);
  
  return ret;
}


void draw() {
  
  timePassed = (timePassed + 0.01f)%nTimeSteps;
  clear();
  
  // DRAW COLOR BAR
  noStroke();
  for (int i=0; i<width; i++) {
    pushMatrix();
    PVector c = getRandomValueInterpolated((float)i,timePassed);
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
    point(i,getRandomValueInterpolated((float)i,timePassed).x*100);
  }
}






/*
float lerp(float a0, float a1, float w) {
  return (1f - w)*a0 + w*a1;
}
*/
