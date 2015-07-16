import processing.video.*;

PShader simpleShader;
PShape mesh;
float FRAMERATE = 30.0;
PImage texture;
Movie myMovie;

void setup() {
  
  size(1920, 1080, P3D);
  
  
  noStroke();
  frameRate(FRAMERATE);
  fill(204);
  
  simpleShader = loadShader("ray_frag.glsl", "ray_vert.glsl");
  texture = loadImage("nurnberg.jpg");  
 
  mesh = createShape();
  mesh.beginShape(QUADS);
  mesh.fill(255,0,0);
  int W = width/4;
  int H = height/4;
  int Z = 130;
  mesh.vertex (-W/2, H/2, Z, 0, 0);
  mesh.vertex ( W/2, H/2, Z, 1.0,0);
  mesh.vertex ( W/2,-H/2, Z, 1.0,1.0);
  mesh.vertex (-W/2,-H/2, Z, 0, 1.0);
  mesh.endShape();
  
  myMovie = new Movie (this, "/Users/maxg/prj/video/lara.mov");
  myMovie.loop();
}



PVector camPos = new PVector (0, 0, 0);
PVector target = new PVector (0, 0, 1000);

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  
  
  tint(255, 20);
  //image(myMovie, 0, 0);
  
  camera (camPos.x, camPos.y, camPos.z,
          target.x, target.y, target.z,
          0, 1, 0 );
  shader(simpleShader);
  
  
  simpleShader.set ("time", frameCount/FRAMERATE);
  simpleShader.set ("camPos", camPos);
  simpleShader.set ("near", (float)  Z);
  simpleShader.set ("W", width+0.0);
  simpleShader.set ("H", height+0.0);
  simpleShader.set ("texture", texture);
  
  
  background(0,0,0);
  shape(mesh);
}
