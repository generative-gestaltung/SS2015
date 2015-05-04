/*
* In this sketch we have 4 vertex shader variants.
*
*/
PShader simpleShader;
PShape mesh;

float timePassed = 0f;
float lastTime = 0;

float totalWidth = 400;
float totalHeight = 400;
int N = 10;
int M = 10;

PShape createMesh () {
  
  PShape sh = createShape();
  float w = totalWidth/N;
  float h = totalHeight/M;
  float z = 0;
  
  sh.beginShape(QUADS);
  float u,v;  
  
  for (int j=0; j<M; j++) {
    for (int i = 0; i <N; i++) {
      sh.fill(255*i/M,255*j/N,0);  
      u = -0.5;
      v = -0.5;
      sh.vertex(i*w,j*h,0, u, v);
      u += 1;
      sh.vertex((i+1)*w,j*h,0, u, v);
      v += 1;
      sh.vertex((i+1)*w,(j+1)*h,0, u, v);
      u -= 1;
      sh.vertex(i*w,(j+1)*h,0, u, v);
    }
  }
  
  sh.endShape();
  return sh;
}

void setup() {
  size(640, 480, P3D);
  noStroke();
  fill(204);
  
  simpleShader = loadShader("SimpleFrag0.glsl", "SimpleVert0.glsl");
  
  mesh = createMesh();
  
  // init time measurement
  lastTime = millis() / 1000.0;
}

void draw() {
  
  float currentTime = millis() / 1000.0;
  timePassed += (currentTime-lastTime);
  lastTime = currentTime;
  
  
  simpleShader.set("timePassed", timePassed);
  simpleShader.set("rect_w", totalWidth/N);
  simpleShader.set("rect_h", totalHeight/M);
  
  
  shader(simpleShader);
  background(0); 


  translate(width/2-totalWidth/2,height/2-totalHeight/2);
  strokeWeight(1);
  shape(mesh);
}
