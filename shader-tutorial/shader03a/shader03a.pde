PShader simpleShader;
PShape mesh;
PImage texture;

float timePassed = 0f;
float lastTime = 0;

float totalWidth = 400;
float totalHeight = 400;
int N = 10;
int M = 10;


PShape createMesh () {

  textureMode(NORMAL);
    
  PShape sh = createShape();
  float w = totalWidth/N;
  float h = totalHeight/M;
  float z = 0;
  float u,v;  

  sh.beginShape(QUADS);
  sh.texture(texture);
  for (int j=0; j<M; j++) {
    for (int i = 0; i <N; i++) {
      sh.fill(127);  
      u = (float)i / N;
      v = (float)j / M;
      sh.vertex(i*w,j*h,0, u, v);
      u += 1.0/N;
      sh.vertex((i+1)*w,j*h,0, u, v);
      v+=1.0/M;
      sh.vertex((i+1)*w,(j+1)*h,0, u, v);
      u-=1.0/N;
      sh.vertex(i*w,(j+1)*h,0, u, v);
    }
  }
  
  sh.endShape();
  return sh;
}

void setup() {
  size(640, 480, P3D);
  noStroke();
  
  texture = loadImage("volvox.jpg");
  simpleShader = loadShader("SimpleFrag0.glsl", "SimpleVert0.glsl");
  
  mesh = createMesh();
  
  // init time measurement
  lastTime = millis() / 1000.0;
}

void draw() {
  
  float currentTime = millis() / 1000.0;
  timePassed += (currentTime-lastTime);
  lastTime = currentTime;
  
  
  //simpleShader.set("timePassed", timePassed);
  //simpleShader.set("rect_w", totalWidth/N);
  //simpleShader.set("rect_h", totalHeight/M);
  
  
  shader(simpleShader);
  background(0); 


  translate(width/2-totalWidth/2,height/2-totalHeight/2);
  fill(125);
  shape(mesh);
}
