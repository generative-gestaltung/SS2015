float R = 10;

void setup() {
  size(300,300);
  frameRate(20);  
}


void draw () {
  background(0);
  
  float time = frameCount / frameRate;
  
  
  for (int i=0; i<10; i++) {
  
    pushMatrix();
    
    float x = width/2  + R*i*sin(time);
    float y = height/2 + R*i*cos(time);
  
    //translate(x,y);
    rect(x,y,10,10);
    
    popMatrix();
  }
}
