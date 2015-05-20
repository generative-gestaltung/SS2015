PShape surface;

int N_BOXES = 10000;
PVector[] positions;
PVector[] velocities;


void setup() {
  
    positions = new PVector[N_BOXES];
    velocities = new PVector[N_BOXES];
    for (int i=0; i<N_BOXES; i++) {
      
      float xoffset = random(-1000,1000);
      float yoffset = random(-1000,1000);
      float zoffset = random(-100,100);
      
      
      positions[i] = new PVector(width/2 + xoffset, height/2 + yoffset,-500+zoffset);
       
       
       float r = 1;
       float phi = random(0, 2*PI);
       velocities[i] = new PVector(0, 0, 0);
    }
    
    
    size (800,600, P3D); 
    surface = createShape();
    surface.beginShape(QUADS);
  
  
  // quad width
  float w = 10000;
  
  // quad height
  float h = 10000;
  
  
  // color red for all vertices
  surface.fill(255,0,0);
 
 float Y = 400;
  surface.vertex(-w, Y, 0);
  surface.vertex(w, Y, 0);
  surface.vertex( w, Y, h);
  surface.vertex(-w, Y, h);
 
  surface.endShape();
}


PVector v_att = new PVector(width/2, height/2,-500);


void updateVelocities() {
  for (int i=0; i<N_BOXES; i++) {
    float r = 0.01;
    float phi = (float)i / N_BOXES * 2*PI;
    
    //PVector force = new PVector(0, 0.02, 0);//new PVector(r*cos(phi), r*sin(phi), 0);
    float d = positions[i].dist(v_att);
    if (d<0.01) d=0.01;
    
    PVector force = positions[i].get();
    force.sub(v_att);
    force.normalize();
    force.mult(1/d);
    
    velocities[i].add(force);
  }  
}


void updatePositions() {
  for (int i=0; i<N_BOXES; i++) {
    positions[i].add(velocities[i]);
  }  
}


void drawBoxes() {
  
  stroke(127);
  for (int i=0; i<N_BOXES; i++) {
    
    pushMatrix();
    
    translate(positions[i].x, positions[i].y, positions[i].z);  
    box(20,20,20);
    
    popMatrix();
  }
}


void draw() {
  background(0);
  
  //shape(surface);
  
  updateVelocities();
  updatePositions();
  drawBoxes();
}
