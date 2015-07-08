// interpolate between keyframes

import controlP5.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.nio.charset.Charset;


final int PLAY = 0;
final int RECORD = 1;
int mode = PLAY;
PVector camPos;

ControlP5 cp5;
float FRAMERATE = 20;


// control camera with keyframes
int NKEYFRAMES = 10;
int selectKeyFrame = 0;
PVector[] keyFrames = new PVector[NKEYFRAMES];
int[] times = {0,50,100,150,200,250,300,350,400,450}; //new int[NKEYFRAMES];

// control camera with gui
int R = 0;
float phi = 0;
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
 
 
  // init keyFrames
  for (int i=0; i<NKEYFRAMES-1; i++) {
    keyFrames[i] = new PVector(random(-500,500), random(-500,500), 0);
  }
  cp5 = new ControlP5(this);
 
 
  // open file and iterate thru lines
  // create position keyframe from line data
  
  
  
  // file has to be located in data subfolder
  String lines[] = loadStrings("keyframes.txt");
  for (int i=0; i<lines.length; i++) {
    String[] values = lines[i].split(" ");  
    PVector keyframe = new PVector (Float.parseFloat(values[0]), 
                                    Float.parseFloat(values[1]),
                                    Float.parseFloat(values[2]));
    if (i<keyFrames.length) {
      keyFrames[i].set(keyframe);
    }
  }
    
  cp5.addButton("reset")
     .setValue(0)
     .setPosition(0,30)
     .setSize(200,19)
     .moveTo("default")
     ;
  cp5.addButton("record")
     .setValue(0)
     .setPosition(0,50)
     .setSize(200,19)
     .moveTo("default")
     ;
  
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
      .setRange(0, 5000)
      .setPosition(0,30)
      .moveTo("camera");
      
  cp5.addSlider("phi")
      .setRange(0, 2*PI)
      .setPosition(0,50)
      .moveTo("camera");
      
  cp5.addSlider("Y")
      .setRange(-5000,5000)
      .setPosition(0,70)
      .moveTo("camera");
  
  cp5.addSlider("selectKeyFrame")
      .setRange(0, NKEYFRAMES-1)
      .setPosition(0,90)
      .moveTo("camera");
 
  cp5.addButton("saveKeyFrame")
     .setValue(0)
     .setPosition(0,110)
     .setSize(200,19)
     .moveTo("camera")
     ;
  
}


void savePreset() {
  cp5.saveProperties(("boxes"+presetSelect+".properties"));
}

void loadPreset() {
  cp5.loadProperties(("boxes"+presetSelect+".properties"));
}

void saveKeyFrame() {
    //keyFrames[selectKeyFrame].set(camPos);
}


void reset() {
  frameCount = 0;
  mode = PLAY;
}

void record() {
  mode = RECORD;
}

float blend (float x0, float x1, float t) {
  return (1-t)*x0 + t*x1;
}

PVector blend (PVector v0, PVector v1, float t) {
  return new PVector(blend(v0.x, v1.x, t), blend(v0.y, v1.y, t), blend (v0.z, v1.z, t)); 
}


void draw() {
  
  
  background(0);
  pushMatrix();
  
  camPos = new PVector();
  
  // PLAYMODE get camera postion keyframe data
  if (mode==PLAY) {
    // look thru times array and find current slot
    int cnt=0;
    for (cnt=0; cnt<NKEYFRAMES; cnt++) {
      if (frameCount<times[cnt]) break; 
    }
    // get current keyframe and move camera to that position
    int current = cnt-1;
    int next = cnt;
    
    float t = (float)(frameCount-times[current]) / (float)(times[next]-times[current]);
    camPos = blend (keyFrames[current], keyFrames[next], t);
  }
  
  // use gui control to define and record camera position
  else if (mode==RECORD) {
    camPos.x = R*cos(phi);
    camPos.y = Y;
    camPos.z = R*sin(phi);
    
    
  }
  camera (camPos.x, camPos.y, camPos.z,
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

