// basic preset saving and loading

import controlP5.*;


ControlP5 cp5;
float FRAMERATE = 20;

// automated paremters
float phi;

// camera parameter
float R = 0;
float speed = 0;
float Y = 0;

// box parameters
float size = 40;
int nBoxes = 1;
int red = 255;
int green = 0;
int blue = 0;

// preset
int presetSelect = 0;


void setup() {
  frameRate(FRAMERATE);
  size(600, 600, P3D);
 
  cp5 = new ControlP5(this);
  
  // SELECT PRESET TAB
  cp5.addTab("PRESET"); 
  // add button with callback function to select preset   
  cp5.addButton("savePreset")
     .setValue(0)
     .setPosition(0,30)
     .setSize(200,19)
     .moveTo("PRESET")
     ;
     
   cp5.addButton("loadPreset")
     .setValue(0)
     .setPosition(0,50)
     .setSize(200,19)
     .moveTo("PRESET")
     ;
     
  cp5.addSlider("presetSelect")
      .setRange(0, 10)
      .setPosition(0,70)
      .moveTo("PRESET");
      
      
      
  // control box
  cp5.addTab("box"); 
  cp5.addSlider("size")
      .setRange(0, 255)
      .setPosition(0,30)
      .moveTo("box");
      
  cp5.addSlider("nBoxes")
      .setRange(0, 50)
      .setPosition(0,50)
      .moveTo("box");
      
  cp5.addSlider("red")
      .setRange(0, 255)
      .setPosition(0,70)
      .moveTo("box");
      
  cp5.addSlider("green")
      .setRange(0, 255)
      .setPosition(0,90)
      .moveTo("box");
      
  cp5.addSlider("blue")
      .setRange(0, 255)
      .setPosition(0,110)
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


void savePreset() {
  cp5.saveProperties(("boxes"+presetSelect+".properties"));
}

void loadPreset() {
  cp5.loadProperties(("boxes"+presetSelect+".properties"));
}

void button2() {
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
  
  fill (red, green, blue);

  // create array of boxes   
  for (int i=0; i<nBoxes; i++) {
    for (int j=0; j<nBoxes; j++) {
      pushMatrix();
      translate((i-nBoxes/2)*size*1.1, 0, (j-nBoxes/2)*size*1.1);
      box(size,size,size);
      popMatrix();
    }
  }  
  popMatrix();
}

