
// quad mesh
PShape mesh;

PGraphics positions0;
PGraphics positions1;
PGraphics swap;

PGraphics velocities;

// displacement shader
PShader positionShader;
PShader displaceShader;
  
  
// USER PARAMETERS
int N = 1000;



void setup() {
  
  size(600, 600, P3D);  
  frameRate(1);
  
  positions0 = createGraphics (N, N, P3D);
  positions1 = createGraphics (N, N, P3D);
  
  
  positions0.beginDraw();
  positions0.background(0,0,0);
  positions0.endDraw();
  
  positions1.beginDraw();
  positions1.background(0,0,0);
  positions1.endDraw();
  
  
  velocities = createGraphics (N, N, P3D);
  
  
  // load shader with fragment-program and vertex-program
  displaceShader = loadShader("render_frag.glsl", "render_vert.glsl");
  positionShader = loadShader("positions_frag.glsl");
  
  
  mesh = createShape();
  
  // quad mesh means, each subsequent 4 vertices form a quad
  mesh.beginShape(QUADS);
  
  // draw no lines
  mesh.noStroke();
  
  
  
  // iterate over grid, create 4 vertices to draw a single quad
  for (int j=0; j < N; j++) {
    for (int i = 0; i < N; i++) {
      mesh.vertex(i/(float)N, j/(float)N, -100, 0, 0);
      mesh.vertex(i/(float)N, j/(float)N, -100, 1, 0);
      mesh.vertex(i/(float)N, j/(float)N, -100, 1, 1);
      mesh.vertex(i/(float)N, j/(float)N, -100, 0, 1);
    }
  }
  mesh.endShape();
}

int cnt = 1;

void draw() {   
  
  PGraphics pos0;
  PGraphics pos1;
  
  if (cnt%2==0) {
    pos0 = positions0;
    pos1 = positions1;
  }
  else {
    pos0 = positions1;
    pos1 = positions0;
  }
  
  
  pos0.beginDraw();
  pos0.noStroke();
  
  positionShader.set("positions", pos1);
  positionShader.set("velocities", velocities);
  positionShader.set("width",  (float)width);
  positionShader.set("height", (float)height);
  
  pos0.shader(positionShader);
   
  pos0.rect(0,0,N,N);
  pos0.endDraw();
  pos0.resetShader();
  
  
  
  cnt+=1;
  
  
  
/*  
  swap.beginDraw();
  swap.image(positions0,0,0);
  swap.endDraw();
  
  positions0.beginDraw();
  positions0.image(positions1,0,0);
  positions0.endDraw();
  
  positions1.beginDraw();
  positions1.image(swap,0,0);
  positions1.endDraw();
  */
  
  
  background(0);
  image(pos0,0,0);
  
  // enable displace shader
  
  shader(displaceShader);
  displaceShader.set ("width", (float)width);
  displaceShader.set ("height", (float)height);
  
  
  
  // center mesh to camera
  //translate (width/2 - MESH_WIDTH/2, height/2, 0);
  shape(mesh);
  resetShader();
}
