PVector p0 = new PVector(0,0);
PVector[] positions;
PVector[] velocities;

// acceleration m/s^2
PVector gravity = new PVector(0,0.1);

int N = 10;

void setup() {
 size(800,500); 
 frameRate(20);
 
 positions = new PVector[N];
 velocities = new PVector[N];
 
 for (int i=0; i<N; i++) {
   positions[i] = new PVector(random(0,width), random(0,height));
   velocities[i] = new PVector(0,0); //new PVector(random(-12,12), random(-12,12));   
 }
}

PVector reflect (PVector velocity, PVector normal) {
  float resilience = 0.7f;
  
  PVector newVelocity = velocity.get();
  PVector normalForce = normal.get();

  float dot = normal.dot(velocity);
  normalForce.mult(2*dot);
  newVelocity.sub(normalForce);
  newVelocity.mult(resilience);

  return newVelocity;  
}


void update() {
 for (int i=0; i<N; i++) {
   
    
    // add force to velocity
    velocities[i].add(gravity);


   // if collide with border, set velocity to reflected vector
    if (positions[i].x + velocities[i].x < 0 ) {
      velocities[i] = reflect(velocities[i], new PVector(-1,0));
    }
    if (positions[i].x + velocities[i].x > width ) {
      velocities[i] = reflect(velocities[i], new PVector(1,0));
    }
    if (positions[i].y + velocities[i].y < 0 ) {
      velocities[i] = reflect(velocities[i], new PVector(0,-1));
    }
    if (positions[i].y + velocities[i].y > height ) {
      velocities[i] = reflect(velocities[i], new PVector(0,1));
    }    
    // update position vel = vel + acc*dt
    positions[i].add(velocities[i]); 
 
     
    // dampl movement
    velocities[i].mult(0.99f);

 }
}

void draw() {
  
  update();
  clear();
  stroke(255);
  strokeWeight(10);
  for (int i=0; i<N; i++) {
    point(positions[i].x, positions[i].y);
  }
}
