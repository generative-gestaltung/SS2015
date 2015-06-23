/*
* Here we do the same as in quadmesh_C, but calculate the y position
 * inside the vertex shader.
 */


// quad mesh
PShape mesh;

// displacement shader
PShader displaceShader;


// USER PARAMETERS
int N = 240;
float MESH_WIDTH = 5000;
PVector sunPosition = new PVector (1000, 1000, 0);
PVector sunColor    = new PVector (1.0, 0, 0);



float scale0 = 0.001;
float scale1 = 0.002;

float amp0 = 1800 ;
float amp1 = 800 ;

float getHeight (float x, float z) {
  
  noiseDetail(8,0.2);
  float n0 = noise (x*scale0, z*scale0)*amp0;
  
  noiseDetail(5,0.7);
  float factor = (1-n0/amp0)-0.7;
  if (factor<0) factor = 0;
  
  float n1 = noise(x*scale1, z*scale1)*amp1 * factor;
  
  return n0 + n1;
}


void setup() {

  size(1200, 600, P3D);  

  // load shader with fragment-program and vertex-program
  displaceShader = loadShader("displace_frag.glsl", "displace_vert.glsl");
  mesh = createShape();

  // quad mesh means, each subsequent 4 vertices form a quad
  mesh.beginShape(QUADS);

  // draw no lines
  mesh.noStroke();




  // CALCULATED PARAMETERS
  float w = MESH_WIDTH/N;
  float h = MESH_WIDTH/N;

  float x, y, z;

  // iterate over grid, create 4 vertices to draw a single quad
  for (int j=0; j < N; j++) {
    for (int i = 0; i < N; i++) {

      // we calculate the y position of each point of the quad 
      PVector points[] = new PVector[4];
      x = i*w;
      z = j*w;
      y = getHeight(x, z);
      points[0] = new PVector (x, y, z);

      x = (i+1)*w;
      z = j*w;
      y = getHeight(x, z);
      points[1] = new PVector (x, y, z);

      x = (i+1)*w;
      z = (j+1)*w;
      y = getHeight(x, z);
      points[2] = new PVector (x, y, z);

      x = i*w;
      z = (j+1)*w;
      y = getHeight(x, z);
      points[3] = new PVector (x, y, z);

      PVector side0 = points[0].get();
      side0.sub(points[1]);
      
      PVector side1 = points[0].get();
      side1.sub(points[2]);
      
      PVector normal = side0.cross(side1);
      normal.normalize();
      

      for (int k=0; k<4; k++) {
        mesh.normal (normal.x, normal.y, normal.z);
        mesh.vertex (points[k].x, points[k].y, points[k].z);
      }
    }
  }
  mesh.endShape();
}


void draw() {   

  
  float R_camera = 4000;
  float p_camera = frameCount*0.003f;
  
  float fov = 95;
  perspective(fov, float(width)/float(height), 
              10, 10000);
  camera (
    R_camera*sin(p_camera), -1000, R_camera*cos(p_camera)+MESH_WIDTH/2,
    0,0,MESH_WIDTH/2,
    0.0, 1.0, 0.0); // upX, upY, upZ
    
  

  resetShader();

  background(0);
  float p_sun = frameCount*0.005f + PI;
  float R = 8000;
  
  
  sunPosition = new PVector(R_camera*sin(p_sun), -1200, R_camera*cos(p_sun)+MESH_WIDTH/2);
  sunColor = new PVector(1.0, cos(p_sun)*0.5+0.5f, cos(p_sun)*0.5+0.5f);
  
  
  pushMatrix();
  noStroke();
  fill(sunColor.x*255, sunColor.y*255, sunColor.z*255);
  translate(sunPosition.x, sunPosition.y, sunPosition.z);
  box(100, 100, 100);
  popMatrix();


  // enable displace shader
  shader(displaceShader);
  displaceShader.set("sunPosition", sunPosition);
  displaceShader.set("sunColor", sunColor);

  // center mesh to camera
  translate (width/2 - MESH_WIDTH/2, height/2, 0);
  shape(mesh);
}

