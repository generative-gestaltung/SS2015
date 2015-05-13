// linestrip
PShape scope;

// x resolution
int N = 200;

// timeBase
float t = 0;


void setup () {
 
  size (800,600,P3D);
  frameRate(40);
  
  scope = createShape(); 
  scope.beginShape(LINES);
  scope.stroke(255);
  scope.strokeWeight(1);
 
  // init base-line
  for (int i=0; i<N; i++) {  
    scope.vertex (i*width/N,0,0);
    scope.vertex ((i+1)*width/N,0,0);
  }
  scope.endShape();
}



// find endpoint of line index-1 and startpoint of line index
void displacePoint (int index, float value) {
  
  int i = (index*2) % (N*2);
  PVector v = scope.getVertex(i);
  v.y = value;
  scope.setVertex(i,v);
  
  i = (index*2 + 2*N -1) % (N*2);
  v = scope.getVertex(i);
  v.y = value;
  scope.setVertex(i,v);
}


void draw() {
  
  t += 1/frameRate;
  
  background(0);
  
  
  float A = 50;
  float f0 = 1;
  
  float signal0 = A * sin (TWO_PI*f0*t);
  
  
  displacePoint (frameCount, signal0);
  
  translate (0, height/2, 0);
  shape(scope);
}
