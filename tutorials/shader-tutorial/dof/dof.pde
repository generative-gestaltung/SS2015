// shader to sample and display pixels from textures

PShader depthMapShader;
PShader bokehShader;

// data textures
PGraphics depthMap;
PGraphics scene;

PVector cameraPos;

int N = 800;
int FPS = 30;

void setup() {
  
  // init display and shader
  size (N, N, P3D);
  frameRate(FPS);
  
  // init textures
  depthMap = createGraphics (N, N, P3D);
  scene = createGraphics (N, N, P3D);
  
  bokehShader    = loadShader ("bokeh_frag.glsl");
  depthMapShader = loadShader ("dof_frag.glsl", "dof_vert.glsl");
  
  cameraPos = new PVector(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0));
  println(cameraPos.z);
}

float time = 0;

void draw() {

  
  time += 1f/FPS;
  
  
  
  depthMap.beginDraw();
  depthMap.background(0,0,0);
  
  depthMap.shader(depthMapShader);
  depthMapShader.set("camera", cameraPos);
  depthMap.noStroke();
  
  
  //translate(200,400+sin(PI/2)*50,0);
  for (int i=0; i<10; i++) {
    for (int j=0; j<10; j++) {
      depthMap.pushMatrix();
      depthMap.translate((i-5)*160+N/2, 400*sin(time)+N/2, -j*150);
      depthMap.rotateZ(time+j*0.2);
      depthMap.fill(170);
      depthMap.box(80,80,80);
      depthMap.popMatrix();    
    }
  }
  
  depthMap.endDraw();
  
  
  scene.beginDraw();
  scene.background(0,0,0);
  scene.stroke(0,100,0);
  
  
  for (int i=0; i<10; i++) {
    for (int j=0; j<10; j++) {
      scene.pushMatrix();
      scene.translate((i-5)*160+N/2, 400*sin(time)+N/2, -j*150);
      scene.rotateZ(time+j*0.2);
      scene.fill(170);
      scene.box(80,80,80);
      scene.popMatrix();    
    }
  }
  
  scene.endDraw();
  
  
  shader(bokehShader);
  bokehShader.set ("bgl_RenderedTexture", scene);
  bokehShader.set ("bgl_DepthTexture", depthMap);
  bokehShader.set ("bgl_RenderedTextureWidth",  (float)N);
  bokehShader.set ("bgl_RenderedTextureHeight", (float)N);
  bokehShader.set ("focalDepth", 10.0);
  
  background(0,0,0);
  rect(0,0,N,N);
  
  resetShader();
}
