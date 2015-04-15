/*
* We add a forces array to the particle system. The force which acts on
* each particle is a 2D perlin noise field, which changes with time.
*
*/

// texture
PImage img;

// quad mesh
PShape mesh;

// size and resolution of the mesh
int resX = 250;
int resY = 250;
int sizeX = 600;
int sizeY = 400;

// size of a single quad
int w = sizeX / resX;
int h = sizeY / resY;
  
// arrays to store position, velocity and force of each quad
PVector[][] positions;
PVector[][] velocities;
PVector[][] forces;

// time between two draw calls = 1/frameRate
float theDeltaTime;


/*
* Set the positions to default 2D grid positions. Init forces and velocities zero.
*/
void initParticles() {
  
  positions  = new PVector[resX][resY];
  velocities = new PVector[resX][resY];
  forces     = new PVector[resX][resY];
    
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
      positions[i][j]  = new PVector(i*w,j*h,0);
      velocities[i][j] = new PVector(0,0,0);   
      forces[i][j] = new PVector(0,0,0);      
    }
  }
}

/*
* Get the force at position of particle.
*/
void updateForces (float theDeltaTime) {
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
      
      PVector pos = positions[i][j].get();
      pos.sub(new PVector(0,0,0));
      forces[i][j] = new PVector(noise(pos.x*0.1f, pos.y*0.1f)-0.5f, noise(100+pos.x*0.1f, 100+pos.y*0.1f)-0.5f, 0);
      forces[i][j].mult(0.4);
      //forces[i][j] = new PVector(-sin ((i-resX/2)*0.01),0,0);  
  }
  }  
}

/*
* Add velocity multiplied by time on position of particle.
*/
void updatePositions (float theDeltaTime) {
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {
      velocities[i][j].add(forces[i][j]);
      PVector v = velocities[i][j].get();
      v.mult(theDeltaTime);
      positions[i][j].add(v);
    }
  }
}


void setup() {
 
  frameRate(30);
  size(640, 360, P3D);  
  
  theDeltaTime = 1/frameRate;
  img = loadImage("volvox.jpg");
  
  initParticles();
  mesh = createMesh (sizeX, sizeY, resX, resY, img);
}


void draw() {    
  background(0);
  
  // update forces, velocities and positions
  updateForces (theDeltaTime);
  updatePositions (theDeltaTime);
    
  // displace quads
  for (int i=0; i<resX; i++) {
    for (int j=0; j<resY; j++) {   
      displaceQuad (mesh, i + j*resX, positions[i][j]);
    }
  }
  
  // draw
  translate(width/2-300, height/2-200, -200);
  shape(mesh);
}

/*
*
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

PShape createMesh (float totalWidth, float totalHeight, int N, int M, PImage tex) {
  
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
