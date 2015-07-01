int N = 200;
float w = 2000;
float time;

Particle[][] particles;


class Particle {
  PVector pos;
  PVector vel;
  float lifeTime;
  int i, j;
  
  public Particle (PVector thePos, int theI, int theJ, float theLifeTime) {
    pos = thePos;
    i = theI;
    j = theJ;
    vel = new PVector(0,0,0);
  }
  
  public void update (PVector theForce) {
    vel.add(theForce);
  }
  
  public void updateVel() {

    if (i==0 || i==N-1 || j==0 || j==N-1) return;
  
    PVector f0 = particles[i+1][j].pos.get();
    PVector f1 = particles[i-1][j].pos.get();
    PVector f2 = particles[i][j+1].pos.get();
    PVector f3 = particles[i][j-1].pos.get();
    
    PVector force = pos.get();
    force.mult(4);
    
    force.sub(f0);
    force.sub(f1);
    force.sub(f2);
    force.sub(f3);
    
    force.mult(-0.5);
    update(force); 
  }
  
  public void updatePos() {
    vel.mult(0.9);
    pos.add(vel);  
  }
  
  public void draw() {
    
    strokeWeight(2);
    stroke(255);
    point(pos.x, pos.y, pos.z);  
  }
}



void setup() {  
  
  noiseDetail(3,0.7);
  size(600,600,P3D);
  particles = new Particle[N][N];
 
  for (int i=0; i<N; i++) {  
    for (int j=0; j<N; j++) {
      
      PVector pos = new PVector(i*w/N, 0, j*w/N);
      
      /*
      if (i==N/2 && j==N/2) {
        pos.y = 50;  
      }
      */
      particles[i][j] = new Particle (pos, i, j, 100);
    }
  }
}


void updateCamera () {
  
  float R = 500;
  float speed = 0;
  PVector camPos = new PVector(0,0,0);
  
  camPos.x = w/2; //R*sin(speed*time);
  camPos.y = 500;
  camPos.z = w; //R*cos(speed*time);
  
  
  camera (camPos.x, camPos.y, camPos.z,
          w/2,0,w/2,
          0,0,1);
}


void updateCenter() {
 
  
  PVector force = new PVector(0,sin(time*4)*180,0);
  particles[20][20].update(force);
  
  force = new PVector(0,sin(time*4+PI)*180,0);
  particles[N-20][20].update(force);
  
  particles[N/2][N/2].pos.y = 400;
  
  
}

void draw() {
  
  
  time += 1/frameRate;
  
  updateCamera();
  
  background(0);
  strokeWeight(2);
  stroke(255);
  
  updateCenter();
  
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      particles[i][j].updateVel();
    }
  }
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      particles[i][j].updatePos();
      particles[i][j].draw();
    }
  }
}
