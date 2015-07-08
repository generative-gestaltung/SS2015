import controlP5.*;


ControlP5 cp5;
float t;
int val0;


void setup() {
  size(640,480,P3D);
  cp5 = new ControlP5(this);
  
  cp5.addSlider("val0")
    .setPosition(10,10)
    .setRange(0,255);
}


void draw() {
  hint(ENABLE_DEPTH_TEST);
  
  background(0);
  pushMatrix();
  
  
  camera (0,0,0,
          0,0,1000,
          0,1,0);
          
  translate(width/2,height/2,mouseX);
  rotateY(t+=0.1);
  fill(255);
  rect(-50,-50,100,100);
  popMatrix();
  hint(DISABLE_DEPTH_TEST);
}
