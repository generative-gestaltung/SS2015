// USER DRIVEN EVENTS


import controlP5.*;

ControlP5 cp5;
float FRAMERATE = 20;

// automated paremters
float phi;

// gui parameter
float size = 40;
float R = 0;
float speed = 0;
float Y = 0;

// the current preset
int preset = 0;

// preset DATA
int N_BOXES[] = {1,4,10};
PVector[] COLORS = {new PVector(255,0,0),
                    new PVector(0,255,0),
                    new PVector(0,0,255)};

void setup() {
  frameRate(FRAMERATE);
  size(600, 600, P3D);
 
  cp5 = new ControlP5(this);
  
  // SELECT PRESET TAB
  cp5.addTab("PRESET"); 
  // add button with callback function to select preset   
  cp5.addButton("button0")
     .setValue(0)
     .setPosition(0,30)
     .setSize(200,19)
     .moveTo("PRESET")
     ;
     
   cp5.addButton("button1")
     .setValue(0)
     .setPosition(0,50)
     .setSize(200,19)
     .moveTo("PRESET")
     ;
     
   cp5.addButton("button2")
     .setValue(0)
     .setPosition(0,70)
     .setSize(200,19)
     .moveTo("PRESET")
     ;
      
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
      
  cp5.addSlider("Y")
      .setRange(-100, 100)
      .setPosition(0,50)
      .moveTo("camera");
      
  cp5.addSlider("speed")
      .setRange(0, 0.4f)
      .setPosition(0,70)
      .moveTo("camera");
}


void button0() {
  preset = 0;  
}

void button1() {
  preset = 1;  
}

void button2() {
  preset = 2;  
}


void draw() {
  
  
  background(0);
  pushMatrix();
  
  // move camera on circle in x-z-plane
  // camera orientation: y-direction
  // and look at center
  
  
  phi = frameCount*speed;
  camera (R*sin(phi), Y, R*cos(phi),
          0,0,0,
          0,1,0);
  
  
  // color and number of boxes value from current 
  // preset
  int n = N_BOXES[preset];
  PVector c = COLORS[preset];
  fill(c.x, c.y, c.z);

  // create array of boxes   
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      pushMatrix();
      translate((i-n/2)*size*1.1, 0, (j-n/2)*size*1.1);
      box(size,size,size);
      popMatrix();
    }
  }  
  popMatrix();
}

