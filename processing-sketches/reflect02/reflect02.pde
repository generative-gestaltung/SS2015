
PVector[] positions;
PVector[] velocities;
PVector[][] planes = {{new PVector(0,0), new PVector(1,0)},
                      {new PVector(width,0), new PVector(-1,0)},
                      {new PVector(0,0), new PVector(0,1)},
                      {new PVector(0,height), new PVector(0,-1)}};;

int N = 1;


void setup() {
 size(800,800); 
 frameRate(20);
 
 positions = new PVector[N];
 velocities = new PVector[N];
 
 
 for (int i=0; i<N; i++) {
   positions[i] = new PVector(random(0,width), random(0,height));
   velocities[i] = new PVector(random(5,5), random(0,0));
 }
}

PVector reflect (PVector velocity, PVector normal) {
  float resilience = 1f;
  
  PVector newVelocity = velocity.get();
  PVector normalForce = normal.get();

  float dot = normal.dot(velocity);
  normalForce.mult(2*dot);
  newVelocity.sub(normalForce);
  newVelocity.mult(resilience);

  return newVelocity;  
}

int signum (float v) {
  if (v<0) return -1;
  else if (v>0) return 1;
  else return 0;
}

float distanceToPlane (PVector point, PVector planePoint, PVector planeNormal) {
  
  PVector diff = point.get();
  diff.sub(planePoint);
  return planeNormal.dot(diff);
}

boolean collideWithPlane (PVector point0, PVector point1, PVector planePoint, PVector planeNormal) {
  float d0 = distanceToPlane(point0, planePoint, planeNormal);
  float d1 = distanceToPlane(point1, planePoint, planeNormal);
   
  println(d0+" "+d1);
  return (signum(d0) != signum(d1)); 
}


void update() {
 for (int i=0; i<N; i++) {
   PVector oldPosition = positions[i].get();
   PVector newPosition = positions[i].get();
   newPosition.add(velocities[i]);
   
   for (int j=0; j<1; j++) {
     if (collideWithPlane(oldPosition, newPosition, planes[j][0], planes[j][1])) {
      velocities[i] = reflect(velocities[i], planes[j][1]);
     }       
   } 
   positions[i].add(velocities[i]);
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
