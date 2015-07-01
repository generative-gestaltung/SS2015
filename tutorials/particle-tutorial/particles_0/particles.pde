// number of particles
int N = 20000;

class Particle {
  PVector pos;
  PVector vel;
  float lifeTime;
  
  /**
  * create new particle
  * thePos: start position
  * theVel: start velocity
  * theLifeTime: init lifetime
  *
  */
  public Particle (PVector thePos, PVector theVel, float theLifeTime) {
    pos = thePos;
    vel = theVel;
    lifeTime = theLifeTime;
  }
  
  /**
  * count down lifetime and update position
  */
  public void update (float theDeltaTime) {
    lifeTime -= theDeltaTime;
    pos.add(vel);  
  }
  
  public void draw() {
    point(pos.x, pos.y, pos.z);  
  }
}



Particle emit() {
  PVector pos = new PVector(width/2, height/2, 100);
  PVector vel = new PVector(random(-1,1), random(-1,1), 0);
  return new Particle(pos, vel, random(1,5));
}



Particle[] particles;


void setup() {  
  size(600,600,P3D);
  
  // init array
  particles = new Particle[N];
 
  // fill array with particles
  for (int i=0; i<N; i++) {  
    particles[i] = emit();
  }
}


void draw() {
  
  background(0);
  strokeWeight(2);
  stroke(255, 255, 255, 100);
  
  // update and draw particles
  
  for (int i=0; i<N; i++) {
    particles[i].update(1/frameRate);
    
    // if particle dead, emit new particle
    if (particles[i].lifeTime<0) {
      particles[i] = emit();
    }
    
    particles[i].draw();
  }
}
