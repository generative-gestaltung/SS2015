PShader myShader;
PGraphics tex0;
PGraphics tex1;
int N = 800;


float time = 0;
int FPS = 30;

void setup() {
  
  size (800, 800, P3D);
  frameRate(FPS);
  
  myShader = loadShader("SimpleFrag.glsl", "SimpleVert.glsl");
  
  tex0 = createGraphics (N, N, P3D);
  tex1 = createGraphics (N, N, P3D);
  float f0 = 0.005;
  noiseDetail(8,0.3);
  
  tex0.beginDraw();
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      tex0.stroke (noise(i*f0, j*f0)*255, noise(i*f0+N, j*f0)*255, noise(i*f0+2*N, j*f0)*255);
      tex0.point(i,j);    
    }
  }
  tex0.endDraw();

  f0 = 0.3;
  tex1.beginDraw();
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      tex1.stroke(noise(i*f0+500, j*f0+500)*255);
      tex1.point(i,j);    
    }
  }
  tex1.endDraw();


}

void draw() {
  background(0);
  
  
  
  shader(myShader);
  myShader.set("tex0", tex0);
  myShader.set("tex1", tex1);
  myShader.set("time", time);
  
  rect(0,0,N,N);
  
  time += 1f/FPS;
}
