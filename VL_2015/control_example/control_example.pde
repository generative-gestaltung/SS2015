// GUI CONTROLLED PARAMETERS


import controlP5.*;

ControlP5 cp5;
float FRAMERATE = 20;

// box parameter
float size = 40;

// camera parameter
float R = 0;
float phi = 0;

void setup() {
  frameRate(FRAMERATE);
  size(600, 600, P3D);
 
  cp5 = new ControlP5(this);
  
  // control box
  cp5.addTab("box"); 
  cp5.addSlider("size")
      .setRange(0, 255)
      .setPosition(0,30)
      .moveTo("box");
      
  // control camera
  cp5.addTab("camera"); 
  cp5.addSlider("R")
      .setRange(0, 255)
      .setPosition(0,30)
      .moveTo("camera");
      
      
  cp5.addSlider("phi")
      .setRange(0, 2*PI)
      .setPosition(0,50)
      .moveTo("camera");
}


void draw() {
  background(0);
  pushMatrix();
  
  // move camera on circle in x-z-plane
  // camera orientation: y-direction
  // and look at center
  
  
  camera (R*sin(phi), 0, R*cos(phi),
          0,0,0,
          0,1,0);
  
  // set box to position (0,0,0)        
  box(size,size,size);
  popMatrix();
}

