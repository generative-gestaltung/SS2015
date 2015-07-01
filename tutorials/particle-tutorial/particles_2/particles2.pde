int N = 20000;
float time;


class Particle {
  PVector pos;
  PVector vel;
  float lifeTime;
  
  public Particle (PVector thePos, PVector theVel, float theLifeTime) {
    pos = thePos;
    vel = theVel;
    lifeTime = theLifeTime;
  }
  
  public void update (float theDeltaTime) {
    lifeTime -= theDeltaTime;
    vel.add(getForce(pos));
    vel.mult(0.6);
    pos.add(vel);  
  }
  
  public void draw() {
    
    strokeWeight(1);
    stroke(255,255,255,100);
    point(pos.x, pos.y, pos.z);  
  }
}



Particle[] particles;

PVector getForce (PVector pos) {
  
  PVector gravity = new PVector (0,-50/(-1-pos.y), 0);
  PVector noise = new PVector (noise(pos.x*0.03, pos.y*0.01, pos.z*0.03+time)-0.5,
                               noise(pos.x*0.03, pos.y*0.01, pos.z*0.03+time+500)-0.5,
                               0);
  noise.mult(0);
  gravity.add(noise);
  return gravity;
}

Particle emit() {
  float x = round(random(1,6))*20-60;
  float z = round(random(1,6))*20-60;
  
  PVector pos = new PVector(x,0,z);
  PVector vel = new PVector(0, -2, 0);
  return new Particle(pos, vel, random(4,8));
}


void setup() {  
  
  
  noiseDetail(3,0.7);
  
  size(600,600,P3D);
  particles = new Particle[N];
 
  for (int i=0; i<N; i++) {  
    particles[i] = emit();
  }
}


void updateCamera () {
  
  float R = 500;
  float speed = 0.4;
  PVector camPos = new PVector(0,0,0);
  
  camPos.x = R*sin(speed*time);
  camPos.y = 200;
  camPos.z = R*cos(speed*time);
  
  
  camera (camPos.x, camPos.y, camPos.z,
          0,0,0,
          0,1,0);
}


float sum = 0;

void draw() {
  
  sum = sum + noise(time)-0.5;
  time += 1/frameRate;
  
  updateCamera();
  
  background(0);
  strokeWeight(2);
  stroke(255);
  
  
  for (int i=0; i<N; i++) {
    particles[i].update(1/frameRate);
    if (particles[i].lifeTime<0) {
      particles[i] = emit();
    }
    
    particles[i].draw();
  }
}
