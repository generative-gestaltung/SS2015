import controlP5.*;

ControlP5 cp5;
PShader displaceShader;
PShape mesh;
float FRAMERATE = 30.0;
PGraphics noise0;
PGraphics heightMap;


void recalcNoise() {

  int SIZE = 1000;
  if (noise0==null) return;
  float[][][] c = new float[3][SIZE][SIZE];
  
  noiseDetail(oct0, falloff0);
  for (int i=0; i<SIZE; i++) {
    for (int j=0; j<SIZE; j++) {
      c[0][i][j] = noise(i*f0, j*f0)*255;
    }
  }
  
  noiseDetail(oct1, falloff1);
  for (int i=0; i<SIZE; i++) {
    for (int j=0; j<SIZE; j++) {
      c[1][i][j] = noise(i*f1, j*f1)*255;
    }
  }
  
  noiseDetail(oct2, falloff2);
  for (int i=0; i<SIZE; i++) {
    for (int j=0; j<SIZE; j++) {
      c[2][i][j] = noise(i*f2, j*f2)*255;
    }
  }
  
  noise0.beginDraw();
  for (int i=0; i<SIZE; i++) {
    for (int j=0; j<SIZE; j++) {
      noise0.stroke(c[0][i][j], c[1][i][j], c[2][i][j]);
      noise0.point(i,j);
    }
  }
  noise0.endDraw();
  
  for (int i=0; i<SIZE; i++) {
    for (int j=0; j<SIZE; j++) {
      
      
      float h = 0;
      noiseDetail(oct0, falloff0);
      
      h += noise(i*f0, j*f0)*50;
      
      noiseDetail(oct1, falloff1);
      h += noise(i*f1, j*f1)*20;
      
      heightMap.fill(h,h,h);
      heightMap.point(i,j);
    }
  }
}

void setup() {
  
  size(1000, 600, P3D);
  
  cp5 = new ControlP5(this);
  setupControls();
  
  noise0 = createGraphics(1000,1000,P3D);
  
  
  noStroke();
  frameRate(FRAMERATE);
  fill(204);
  
  displaceShader = loadShader("displace_frag.glsl", "displace_vert.glsl");
 
  mesh = createShape();
  mesh.beginShape(QUADS);
  mesh.fill(255,0,0);
  int W = width/4;
  int H = height/4;
  int Z = 130;
  
  float N = 1000;
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      
      float y = random(0,100);
      mesh.vertex (i/N, y, j/N, 0, 0);
      mesh.vertex ((i+1)/N, y, j/N, 1.0,0);
      mesh.vertex ((i+1)/N, y, (j+1)/N, 1.0,1.0);
      mesh.vertex (i/N, y, (j+1)/N, 0, 1.0);
    }
  }  
  mesh.endShape();
  
  recalcNoise();
}



PVector camPos = new PVector (0, 0, 0);
PVector target = new PVector (0, 0, 1000);

void draw() {
  
  if (displayMode==0) {
    camPos = new PVector (W/2, -200, 0);
    target = new PVector (W/2, 0, W/2);
    
    background(0,0,0);
    pushMatrix();
    camera (camPos.x, camPos.y, camPos.z,
            target.x, target.y, target.z,
            0, 1, 0 );
  
    shader (displaceShader);
    displaceShader.set("terrain_w", W);
    displaceShader.set("h0", h0);
    displaceShader.set("h2", h2);
    displaceShader.set("noise", noise0);
    
    displaceShader.set("heightMap", heightMap);
    
    displaceShader.set("bottom0", bottom0);
    displaceShader.set("top0", top0);
    displaceShader.set("thresh1", thresh1);
    displaceShader.set("sunPos", new PVector(1000*sin(frameCount*0.01), 1000, 1000*cos(frameCount*0.01)));
    
    shape(mesh);
    
    
    
    shader (objectShader);
    objectShader.set("heightMap", heightMap);
    shape(objectsMesh);
    
    popMatrix();
    resetShader();
  }
  
  else {
    background(0,0,0);
    image(noise0,0,0);
  }
}
