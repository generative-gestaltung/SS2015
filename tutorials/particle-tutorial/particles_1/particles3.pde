int N = 20000;
float time;


class Particle {
  PVector pos;
  PVector vel;
  float lifeTime;
  float maxLifeTime;
  
  public Particle (PVector thePos, PVector theVel, float theLifeTime) {
    pos = thePos;
    vel = theVel;
    lifeTime = 0;
    maxLifeTime = theLifeTime;
  }
  
  public boolean isDead() {
      return (lifeTime>maxLifeTime);
  }
  
  public void update (float theDeltaTime) {
    lifeTime += theDeltaTime;
    
    // add forces on velocity
    vel.add(getForce(pos));
    
    // damping 
    vel.mult(0.5);
    
    // update position
    pos.add(vel);  
  }
  
  public void draw() {
    
    strokeWeight(5);
    //stroke(255,255,255,100);
    stroke(255/(1+lifeTime*0.5), 255/(1+lifeTime*0.5), 255/(1+lifeTime*0.5), 50);
    point(pos.x, pos.y, pos.z);  
  }
}



Particle[] particles;


/**
*
* get vectorial force on particle, dependent on position
*/
PVector getForce (PVector pos) {
  
  
  PVector gravity = new PVector (0,-2*exp(pos.y*0.001), 0);
  
  float t = time;
  PVector noise = new PVector (noise(pos.x*0.02+t, pos.y*0.02+t, pos.z*0.02+t)-0.5,
                               noise(pos.x*0.02+t+500, pos.y*0.02+t+500, pos.z*0.02+t+500)-0.5,
                               noise(pos.x*0.02+t+1000, pos.y*0.02+t+1000, pos.z*0.02+t+1000)-0.5);
  noise.mult(4);
  gravity.add(noise);
  return gravity;
}

Particle emit() {
  float x = round(random(1,5))*10-20;
  float z = round(random(1,5))*10-20;
  
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
  float speed = 0.2;
  PVector camPos = new PVector(0,0,0);
  
  camPos.x = R*sin(speed*time);
  camPos.y = -200;
  camPos.z = R*cos(speed*time);
  
  
  camera (camPos.x, camPos.y, camPos.z,
          0,-200,0,
          0,1,0);
}


float sum = 0;

void draw() {
  
  sum = sum + noise(time)-0.5;
  time += 1/frameRate;
  
  updateCamera();
  
  background(0);
  
  for (int i=0; i<N; i++) {
    particles[i].update(1/frameRate);
    if (particles[i].isDead()) {
      particles[i] = emit();
    }
    
    particles[i].draw();
  }
}
