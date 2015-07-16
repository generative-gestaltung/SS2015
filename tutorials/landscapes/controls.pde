float W = 4000;
float h0 = 0;
float h2 = 0;

float f0 = 0.1;
int oct0 = 1;
float falloff0 = 0.5;

float f1 = 0.1;
int oct1 = 1;
float falloff1 = 0.5;

float f2 = 0.1;
int oct2 = 1;
float falloff2 = 0.5;


int displayMode = 0;
float bottom0 = 0;
float top0;

float thresh1 = 0;

public void setupControls () {
  
  // DEFAILT
  cp5.addSlider("displayMode")
      .setRange(0, 1)
      .setPosition(10,30)
      .moveTo("default");
      
  // DIMENSIONS
  cp5.addSlider("W")
      .setRange(0, 1000)
      .setPosition(10,30)
      .moveTo("dim");
      
  cp5.addSlider("bottom0")
      .setRange(0, 1)
      .setPosition(10,50)
      .moveTo("dim");
      
  cp5.addSlider("top0")
      .setRange(0, 1)
      .setPosition(10,70)
      .moveTo("dim");
      
  cp5.addSlider("thresh1")
      .setRange(0, 1)
      .setPosition(10,90)
      .moveTo("dim");
  
  cp5.addSlider("h0")
      .setRange(0, 500)
      .setPosition(10,110)
      .moveTo("dim");
  
  cp5.addSlider("h2")
      .setRange(0, 500)
      .setPosition(10,130)
      .moveTo("dim");
  
  
  // NOISE
  cp5.addSlider("f0")
      .setRange(0, 0.04)
      .setPosition(10,30)
      .moveTo("noise");
 
  cp5.addSlider("oct0")
      .setRange(0, 10)
      .setPosition(10,50)
      .moveTo("noise");
  
  cp5.addSlider("falloff0")
      .setRange(0, 1)
      .setPosition(10,70)
      .moveTo("noise");
      
  cp5.addSlider("f1")
      .setRange(0, 0.04)
      .setPosition(10,90)
      .moveTo("noise");
 
  cp5.addSlider("oct1")
      .setRange(0, 10)
      .setPosition(10,110)
      .moveTo("noise");
  
  cp5.addSlider("falloff1")
      .setRange(0, 1)
      .setPosition(10,130)
      .moveTo("noise");
      
  cp5.addSlider("f2")
      .setRange(0, 0.04)
      .setPosition(10,150)
      .moveTo("noise");
 
  cp5.addSlider("oct2")
      .setRange(0, 10)
      .setPosition(10,170)
      .moveTo("noise");
  
  cp5.addSlider("falloff2")
      .setRange(0, 1)
      .setPosition(10,190)
      .moveTo("noise");
         
  cp5.addButton("recalcNoise")
     .setValue(0)
     .setPosition(10,210)
     .moveTo("noise")
     ;
     
}
