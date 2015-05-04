PShader simpleShader;
PShape mesh;
PImage texture;

float timePassed = 0f;
float lastTime = 0;

float totalWidth = 400;
float totalHeight = 400;
int N = 20;
int M = 20;


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
      sh.fill(255*i/M,255*j/N,0);  
      u = 0;
      v = 0;
      sh.vertex(i*w,j*h,0, u, v);
      u += 1;
      sh.vertex((i+1)*w,j*h,0, u, v);
      v+=1;
      sh.vertex((i+1)*w,(j+1)*h,0, u, v);
      u-=1;
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
  
  texture = loadImage("heightmap.jpg");
  simpleShader = loadShader("SimpleFrag0.glsl", "SimpleVert0.glsl");
  
  mesh = createMesh();
  
  // init time measurement
  lastTime = millis() / 1000.0;
}

void draw() {
  
  camera(200.0, mouseY, 420.0, // eyeX, eyeY, eyeZ
         200, 200, 200, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
         
  float currentTime = millis() / 1000.0;
  timePassed += (currentTime-lastTime);
  lastTime = currentTime;
  
  simpleShader.set("timePassed", timePassed);
  simpleShader.set("total_w", totalWidth);
  simpleShader.set("total_h", totalHeight);
  
  
  shader(simpleShader);
  background(0); 


  translate(width/2-totalWidth/2,height/2-totalHeight/2);
  strokeWeight(1);
  shape(mesh);
}
