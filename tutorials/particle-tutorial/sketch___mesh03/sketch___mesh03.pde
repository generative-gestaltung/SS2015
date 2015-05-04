PImage img;
PShape mesh;

int resX = 200;
int resY = 200;

int sizeX = 600;
int sizeY = 400;

int w = sizeX / resX;
int h = sizeY / resY;
  
PVector[][] targetsA;
PVector[][] targetsB;

void initParticles() {
 
  
  targetsA   = new PVector[resX][resY];
  targetsB   = new PVector[resX][resY];
  
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
      
      // calculate starting position on grid as targetA
      PVector pos = new PVector(i*w,j*h,0);
      targetsA [i][j] = pos;
      //targetsB [i][j] = new PVector(pos.x+random(-20,20), pos.y+random(-20,20), pos.z+random(-4,4));      
      
      // calculate random position as targetB
      //targetsB [i][j] = new PVector(random(0,sizeX),random(0,sizeY),0);      
      targetsB [i][j] = new PVector(-i*w+random(100,400),(resY-j)*h,random(0,100));
    }
  }
}


void setup() {
  
  initParticles();
  
  frameRate(30);
  size(640, 360, P3D);  
  img = loadImage("volvox.jpg");
  mesh = createStrip (sizeX, sizeY, resX, resY, img);
}


int cnt  = 0;

void draw() {    
  background(0);
    
  translate(width/2-300, height/2-200, -200);
  
  int w = sizeX / resX;
  int h = sizeY / resY;
  
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
      
      // interpolate between two target, use shifted sin function [0...1] as interpolation value
      PVector newPos = interpolate(targetsA[i][j].get(), targetsB[i][j].get(), sin(1.5*PI+cnt*0.04f)*0.5f+0.5f);
      displaceRect (mesh, i + j*resX, newPos);
    }
  }
  cnt += 1;
  shape(mesh);
}

PVector interpolate (PVector v0, PVector v1, float w) {
  PVector ret = new PVector(0,0,0);
  v0.mult(1-w);
  v1.mult(w);
  ret.add(v0);
  ret.add(v1);
  
  return ret;
}


void displaceRect (PShape shape, int index, PVector pos) {
  
  PVector newPosition = pos.get();
  for (int i=0; i<4; i++) {
    shape.setVertex(index*4,newPosition); 
    newPosition.add(new PVector(w,0,0));
    shape.setVertex(index*4+1,newPosition); 
    newPosition.add(new PVector(0,h,0));
    shape.setVertex(index*4+2,newPosition);
    newPosition.add(new PVector(-w,0,0)); 
    shape.setVertex(index*4+3,newPosition); 
  }
}

PShape createStrip (float totalWidth, float totalHeight, int N, int M, PImage tex) {
  
  
  textureMode(NORMAL);
  PShape sh = createShape();
  float w = totalWidth/N;
  float h = totalHeight/M;
  float z = 0;
  
  sh.beginShape(QUADS);
  sh.noStroke();
  sh.noFill();
  sh.texture(tex);
    
  for (int j=0; j<M; j++) {
    for (int i = 0; i <N; i++) {
      
      // pixelate: use only these
      float u = (float)i / N;
      float v = (float)j / M;
      
      sh.vertex(i*w, j*h, z, u, v);
      
      u = (float)(i+1) / N;
      sh.vertex((i+1)*w, j*h, z, u, v);
      
      v = (float)(j+1) / M;
      sh.vertex((i+1)*w, (j+1)*h, z, u, v);
      
      u = (float)i / N;
      sh.vertex(i*w, (j+1)*h, z, u, v);
    }
  }
  
  sh.endShape();
  return sh;
}
