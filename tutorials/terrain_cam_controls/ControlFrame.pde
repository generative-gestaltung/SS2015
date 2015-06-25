
/**
*  The control frame class.
*/
public class ControlFrame extends PApplet {

  int w, h;
  ControlP5 cp5;
  Object parent;
  
  /**
  *  Constructor
  *
  * @param theParent -
  */
  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    
    
    // create tabs to arrange sliders, default is alwasy there, add another tab for sun related controls and one for terrain
    cp5.addTab("sun")
     .setColorBackground(color(0, 160, 100))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0));
    
    cp5.addTab("terrain")
     .setColorBackground(color(160, 0, 70))
     .setColorLabel(color(255))
     .setColorActive(color(255,128,0));
    
     
     
    // create the gui elements and arrange them inside the tab
    // we need plugTo(parent), to have it accessible in the main window
     
     // this control effects the main app, so we move it to the default tab, which is always there
     cp5.addSlider("clearColor")
      .plugTo(parent, "clearColor")
      .setRange(0, 255)
      .setPosition(10,30)
      .moveTo("default");
      
      cp5.addSlider("cam_speed")
      .plugTo(parent, "cam_speed")
      .setRange(0, 1.0)
      .setPosition(10,50)
      .moveTo("default");
      
      cp5.addSlider("cam_radius")
      .plugTo(parent, "cam_radius")
      .setRange(100, 10000)
      .setPosition(10,70)
      .moveTo("default");
      
    // put the other controls to the sun tab
    cp5.addSlider("sun_radius")
      .plugTo(parent, "sun_radius")
      .setRange(0, 10000)
      .setPosition(10,30)
      .setSize(120,10)
      .moveTo("sun");
    
    cp5.addSlider("sun_speed")
      .plugTo(parent,"sun_speed")
      .setRange(0, 3)
      .setPosition(10,70)
      .moveTo("sun");
    
    cp5.addSlider("zPos")
      .plugTo(parent,"zPos")
      .setRange(0, 10000)
      .setPosition(10,90)
      .moveTo("sun");
    
    // same for terrain controls
    cp5.addSlider("terrain_w")
      .plugTo(parent,"terrain_w")
      .setRange(100, 5000)
      .setPosition(10,30)
      .moveTo("terrain");
      
    cp5.addSlider("terrain_h")
      .plugTo(parent,"terrain_h")
      .setRange(0, 500.0)
      .setPosition(10,50)
      .moveTo("terrain");   
      
      cp5.addSlider("terrain_sin_f")
      .plugTo(parent,"terrain_sin_f")
      .setRange(0, 10.0)
      .setPosition(10,70)
      .moveTo("terrain");   
  }

  public void draw() {
    background(0);
    text("key commands:\n(l)oad settings\n(s)ave settings",0,200);
  }
  
  
  // basic load save routine, could be extended by a text field for savefile name
  void keyPressed() {
  if (key=='s') {
    cp5.saveProperties(("terrain.properties"));
  } 
  else if (key=='l') {
    cp5.loadProperties(("terrain.properties"));
  }
}

  public ControlP5 control() {
    return cp5;
  }
}

/**
* Function to create a control frame instance
*/
ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

