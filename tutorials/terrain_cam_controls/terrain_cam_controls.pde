import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

/**
*
* This is an advanced example which uses the controlp5 library to
* create a basic gui for user settings. The class creates a seperate window
* and sets up all the gui elements, that we use to control variable values of 
* our app.
* 
* It is much more convenient to render the controls in a seperate window, because in
* one window perspective and camera, which we apply to our scene also be applied to
* the controls. 
*
* The rendered scene is quite simple. The class Terrain holds a simple quadmesh, 
* whith x and z coordinates going from 0 to 1. By calling the draw function, we apply
* a custom displacement shader.
* in the vertex stage vertices are displaced in x-z direction based on the 
* user paremter 'terrain_w'. the y-displacement is simple sin-based function and its 
* scale is set by the user parameter 'terrain_h'.
*
* To apply diffuse lighting, normals are calculated in the vertex stage and passed 
* to the fragment stage. Here the brightness is calculated by the dot product of normal
* and sun position.
*
* The sun position is calculated in the main draw() loop. The sun moves on a circle
* with a radius and speed, that can be set by the user. The sun is rendered as a red box.
*
* The movement of the camera is calculated in the same fashion.
* 
*/

// the controlP5 interface class
ControlP5 cp5;

// the extra window for the gui
ControlFrame cf;

// Terrain class for creating and rendering the scene
Terrain terrain;


float FRAMERATE = 25;


/**
* User parameters, which can be manipulated with the gui.
*/

// global parameters, will be put into the "default tab" of the gui
float cam_speed;
int cam_radius;
int clearColor;

// sun related controls
int sun_radius;
int zPos;
float sun_speed;

// terrain related
float terrain_w;
float terrain_h;
float terrain_sin_f;



void setup() {
  frameRate(FRAMERATE);
  size(800, 600, P3D);
 
  cp5 = new ControlP5(this);
  cf = addControlFrame("controls", 400,400); 
  
  terrain = new Terrain();
}

void draw() {
  
  float time = frameCount / FRAMERATE;
  
  background(clearColor);
  
  
  // calculate sun position
  PVector sunPos = new PVector(0,0,0);
  sunPos.x = sun_radius * sin (time*sun_speed);
  sunPos.y = sun_radius * cos (time*sun_speed);
  sunPos.z = 200;
  
  // roatate camera around middle of terrain and look to center
  PVector camPos = new PVector(0,0,0);
  camPos.x = terrain_w/2 + cam_radius*sin(cam_speed*time);
  camPos.y = -400;
  camPos.z = terrain_w/2 + cam_radius*cos(cam_speed*time);
  
  
  camera (camPos.x, camPos.y, camPos.z, // position
          terrain_w/2,0,terrain_w/2,    // look at
          0,1,0);                       // up
          
  // set fov, aspect ration, far and near plane of camera
  perspective (PI/2.0, 1.0, 10.0, 10000.0);
  
  
  // draw terrain
  terrain.draw (terrain_w, terrain_h, sunPos, camPos);
  
  
  // draw sun
  pushMatrix();
  fill(255,0,0);
  noStroke();
  translate (terrain_w/2, 0, terrain_w/2);
  translate (sunPos.x, sunPos.y, sunPos.z);
  box(100,100,100); 
  popMatrix();
  
}
