public class Terrain {
  
  // the base mesh
  PShape mesh;
  int N = 100;
  
  // displacement shader
  PShader displaceShader;
  
  /**
  * do all the setup stuff in the constructor
  */
  public Terrain() {
    
    
    
    // build the base mesh with x = 0...1 and z=0...1
    mesh = createShape();
    float y = 100;
    
    mesh.beginShape(QUADS);
    mesh.noStroke();
    
    for (int i=0; i<N; i++) {
      for (int j=0; j<N; j++) {
    
        float x = i / (float)N;
        float z = j / (float)N;
        mesh.vertex (x,y,z);
    
        x = (i+1) / (float) N;
        mesh.vertex (x,y,z);
    
        z = (j+1) / (float)N;
        mesh.vertex (x,y,z);
    
        x = i / (float)N;
        mesh.vertex (x,y,z);
      }
    }
    mesh.endShape();
    
    
    // load the shader
    displaceShader = loadShader("displace_frag.glsl", "displace_vert.glsl");
  }
  
  
  /**
  * apply the shader and draw the mesh
  * we need to pass the control variables from our main draw
  */
  public void draw (float terrain_w, float terrain_h, PVector sunPos, PVector camPos) {
    
    shader(displaceShader);
    
    displaceShader.set("terrain_w", terrain_w);
    displaceShader.set("terrain_h", terrain_h);
    displaceShader.set("sunPos", sunPos);
    displaceShader.set("camPos", camPos);
    displaceShader.set("terrain_sin_f", terrain_sin_f);
    
    shape(mesh);
    resetShader();
  }
}

