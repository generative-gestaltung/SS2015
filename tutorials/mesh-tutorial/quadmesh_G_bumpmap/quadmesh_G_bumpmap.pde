PImage label;
PShape can;
float angle;

PShader texShader;

void setup() {
  size(640, 360, P3D);  
  label = loadImage("grid.jpg");
  can = createCan(100, 200, 32, label);
  texShader = loadShader("bumpmap_frag.glsl", "bumpmap_vert.glsl");
}

void draw() {    
  
  camera (0,0,0,
          SIZE/2,100,SIZE/2,
          0,1,0);
  background(0);
    
  texShader.set("time", frameCount*0.1f);
  shader(texShader);  
  shape(can);  
}


int SIZE = 500;
PShape createCan(float r, float h, int detail, PImage tex) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUADS);
  sh.noStroke();
  sh.texture(tex);
  
  sh.normal(0,1,0);
  sh.vertex (0,100,0, 0,0);
  
  sh.normal(0,1,0);
  sh.vertex (SIZE,100,0, 1,0);

  sh.normal(0,1,0);  
  sh.vertex (SIZE,100,SIZE, 1,1);
  
  sh.normal(0,1,0);
  sh.vertex (0,100,SIZE, 0,1);    
  
  sh.endShape(); 
  return sh;
}
