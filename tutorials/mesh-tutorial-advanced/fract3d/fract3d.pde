PShape can;
float angle;
PShader transformShader;
float time = 0;
float FRAMERATE = 50;


void setup() {
  size(800, 800, P3D);
  frameRate(FRAMERATE);
  
  can = createCan(30, 2000, 32);
  transformShader = loadShader("transform_frag.glsl", "transform_vert.glsl");
  
}


float w = 100;
int N = 300;
  
void draw() {   
 
  
  hint(ENABLE_DEPTH_SORT);
  time += 1/FRAMERATE; 
  background(0);
  translate(width/2, height/2);
  
  int center_x = 0;
  int center_z = 0;
  int R = 5000;
  float SPEED = 0.4;
  
  camera (10000, -2000, -time*4000,
          0, 0, 0,
          0,1,0);
          
          
  perspective(PI/2, 1, 10, 40000);
  
  shader(transformShader);
  transformShader.set("time", time);
  transformShader.set("w",w);
  shape(can);  
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
        
        sh.normal (n*N+m,0,0);
        sh.vertex (x + n*0, 0, z + m*0, u, 0);
        
        sh.normal (n*N+m,0,0);
        sh.vertex (x + n*0, h, z + m*0, u, 1);
     
        x = sin ((i+1) * angle) * r;
        z = cos ((i+1) * angle) * r;   
        sh.normal (n*N+m,0,0);
        sh.vertex (x + n*0, h, z + m*0, u, 0);
        
        sh.normal (n*N+m,0,0);
        sh.vertex (x + n*0, 0, z + m*0, u, 1);    
      }
    }
  }
  sh.endShape(); 
  return sh;
}
