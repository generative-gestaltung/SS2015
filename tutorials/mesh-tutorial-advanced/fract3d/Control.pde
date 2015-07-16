import controlP5.*;



// USER PARAM
public float size = 1f; 
public float speed = 0f;
  
  
public class Control {
  
  ControlP5 cp5;
  
  public Control (ControlP5 theCp5) {
    cp5 = theCp5;
    
    cp5.addSlider("size")
      .setRange(0, 100)
      .setPosition(0,10);
  }  
}


