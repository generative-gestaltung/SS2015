/*
* In this example we implement a simple particle system.
* We do not edit the positions of the quad directly. Instead, we store the position 
* of each quad in an array. Together with a velocity, we can update the position of 
* each quad relative to the current position. 
* From the initial position, the quads drift away with some randomness.
*/

// texture
PImage img;

// quad mesh
PShape mesh;

// size and resolution of the mesh
int resX = 30;
int resY = 30;
int sizeX = 600;
int sizeY = 400;

// size of a single quad
int w = sizeX / resX;
int h = sizeY / resY;
  
// arrays to store position velocity of each quad
PVector[][] positions;
PVector[][] velocities;

// time between two draw calls = 1/frameRate
float theDeltaTime;

/*
* Simplified createMesh function.
* We only need to assign texture coordinates to vertex with the correct index.
* We call later the diplaceQuad function to put the quads in the correct place.
*/
PShape createMeshSimplified (float totalWidth, float totalHeight, int N, int M, PImage tex) {
  
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
      
      float u = (float)i / N;
      float v = (float)j / M;
      
      sh.vertex(0,0, 0, u, v);
      
      u = (float)(i+1) / N;
      sh.vertex(0,0,0, u, v);
      
      v = (float)(j+1) / M;
      sh.vertex(0,0, 0, u, v);
      
      u = (float)i / N;
      sh.vertex(0,0,0, u, v);
    }
  }
  
  sh.endShape();
  return sh;
}

/*
* Initialize the positions and velocities array. 
*/
void initParticles() {
  
  positions = new PVector[resX][resY];
  velocities = new PVector[resX][resY];
  
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
      positions[i][j]  = new PVector(i*w,j*h,0);
      
      if (i<resX/2) {
        velocities[i][j] = new PVector(-random(0,14),random(-4f,4f),0);      
      }
      else {
        velocities[i][j] = new PVector(random(0,14),random(-4f,4f),0);      
      }
    }
  }
}

/*
* Iterate thru all positions and add velocity.
*
* @param theDeltaTime: update time step
*/
void update (float theDeltaTime) {
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
      PVector v = velocities[i][j].get();
      v.mult(theDeltaTime);
      positions[i][j].add(v);
    }
  }  
}

/*
* Displace quad to pos. 
*
* @param shape: the quadmesh
* @param index: index of quad
* @param pos: vector to determine position of vertex 0 of the quad. Other vertices
*             are displaced relatively to this point according to quad size.
*/
void displaceQuad (PShape shape, int index, PVector pos) {
  
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

float lastTime = 0f;

void setup() {
  
  frameRate(50);
  size(640, 360, P3D);


  initParticles();
  theDeltaTime = 1/frameRate;
  img = loadImage("volvox.jpg");
    
  mesh = createMeshSimplified (sizeX, sizeY, resX, resY, img);
  
}

void draw() {    
  background(0);
  
  theDeltaTime = 1/frameRate;
  // update positions based on current velocities
  
  /*
  float currentTime = millis() / 100;
  theDeltaTime = currentTime - lastTime;
  lastTime = currentTime;
  */
  update(theDeltaTime);
    
  
  // iterate thru all quads and put to position
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
      displaceQuad (mesh, i + j*resX, positions[i][j]);
    }
  }
 
  translate(width/2-300, height/2-200, -200);
  shape(mesh);
}
