// shader to sample and display pixels from textures
PShader myShader;

// data textures
PGraphics tex0;

int N = 800;
int FPS = 30;

void setup() {
  
  // init display and shader
  size (N, N, P3D);
  frameRate(FPS);
  myShader = loadShader("dof_frag.glsl", "dof_vert.glsl");
  
  // init textures
  tex0 = createGraphics (N, N, P3D);
}

float time = 0;

void draw() {
  
  // render scene to texture
  tex0.beginDraw();
  tex0.background(0);
  tex0.noStroke();
  
  tex0.translate(200,400+sin(time)*50,0);
  for (int i=0; i<10; i++) {
    for (int j=0; j<10; j++) {
      tex0.fill(255/(10-j));
      tex0.pushMatrix();
      tex0.translate(i*50,0,j*50);
      tex0.box(20,20,20);
      tex0.popMatrix();    
    }
  }
  
  tex0.endDraw();
  
  time += 1f/FPS;
  
  
  
  shader(myShader);
  myShader.set("tex0", tex0);
  
  
  
  background(0);
  noStroke();
  
  translate(200,400+sin(time)*50,0);
  for (int i=0; i<10; i++) {
    for (int j=0; j<10; j++) {
      pushMatrix();
      translate(i*50,0,j*50);
      fill(255/(10-j));
      box(20,20,20);
      popMatrix();    
    }
  }
}
