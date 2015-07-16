import controlP5.*;

PShape can;
float angle;
PShader transformShader;
float time = 0;
float FRAMERATE = 50;

Control control;


void setup() {
  size(600, 600, P3D);
  frameRate(FRAMERATE);
  
  can = createCan(100, 2000, 32);
  transformShader = loadShader("transform_frag.glsl", "transform_vert.glsl");
  
  control = new Control (new ControlP5(this));
}


float w = 100;
int N = 300;
  
void draw() {   
 
   
  background(0);
  
  
  pushMatrix();
  
  time += 1/FRAMERATE;
  translate(width/2, height/2);
  
  
  
  int center_x = 0;
  int center_z = 0;
  int R = 5000;
  float SPEED = 0.4;
  
  camera (10000, -2000, -time*4000,
          0, 0, 0,
          0, 1, 0);
          
  perspective (45, float(width)/float(height), 
               10, 10000.0);
          
          
  shader(transformShader);
  transformShader.set("time", time);
  transformShader.set("w", 500f);
  transformShader.set("SIZE", 1500f);
  shape(can);  
  
  popMatrix();
}

PShape createCan(float r, float h, int detail) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUADS);
  sh.noStroke();
  
  
  for (int n=0; n<N; n++) {
    for (int m=0; m<N; m++) {
      for (int i = 0; i <= detail; i++) {
        float angle = TWO_PI / detail;
        float x = sin(i * angle) * r;
        float z = cos(i * angle) * r;
        float u = float(i) / detail;
        
        sh.normal (n,m,i*4);
        sh.vertex (x + n*0, 0, z + m*0, u, 0);
        
        sh.normal (n,m,i*4+1);
        sh.vertex (x + n*0, h, z + m*0, u, 1);
     
        x = sin ((i+1) * angle) * r;
        z = cos ((i+1) * angle) * r;   
        sh.normal (n,m,i*4+2);
        sh.vertex (x + n*0, h, z + m*0, u, 0);
        
        sh.normal (n,m,i*4+3);
        sh.vertex (x + n*0, 0, z + m*0, u, 1);    
      }
    }
  }
  sh.endShape(); 
  return sh;
}
