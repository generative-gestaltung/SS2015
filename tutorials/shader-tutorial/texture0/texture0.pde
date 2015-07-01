// shader to sample and display pixels from textures
PShader myShader;

// data textures
PGraphics tex0;
PGraphics tex1;

int N = 800;
int FPS = 30;

void setup() {
  
  // init display and shader
  size (N, N, P3D);
  frameRate(FPS);
  myShader = loadShader("SimpleFrag.glsl", "SimpleVert.glsl");
  
  // init textures
  tex0 = createGraphics (N, N, P3D);
  tex1 = createGraphics (N, N, P3D);
  
  
  // init noise
  noiseDetail (4,0.5);
  
  
  // set pixels to brightness based on noise function
  float f0 = 0.03;
  tex0.beginDraw();
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      tex0.stroke(noise(i*f0, j*f0)*255);
      tex0.point(i,j);    
    }
  }
  tex0.endDraw();

  f0 = 0.3;
  tex1.beginDraw();
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      
      tex1.stroke(noise(i*f0+500, j*f0+500)*255);

      if (i>N/2 && i<(N/2+20)) {
        tex1.stroke(255,0,0);
      }
      
      tex1.point(i,j);
    }
  }
  tex1.endDraw();


}

float scale=0;
float time;

void draw() {
  background(0);
  
  shader(myShader);
  myShader.set("tex0", tex0);
  myShader.set("tex1", tex1);
  myShader.set("scale", scale);
    
  beginShape(QUADS);
  
  vertex(0, 0,0, 0,0);
  vertex(400, 0,0, 1,0);
  vertex(400, 400,0, 1,1);
  vertex(0, 400,0, 0,1);
  
  endShape();
  scale = sin(time)*0.5+0.5;
  scale *= 0.004;
  System.out.println(scale);
  time += 1f/FPS;
}
