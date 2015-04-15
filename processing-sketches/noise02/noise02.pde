
PVector center;
PVector nx;
float size = 5;

PVector noiseValues[][];
int gridSize = 40;

void setup() {
  size(800,600);
  frameRate(24);
  
  noiseValues = new PVector[width/gridSize][height/gridSize];
  
  for (int i=0; i<width/gridSize; i++) {
    for (int j=0; j<height/gridSize; j++) {
     noiseValues[i][j] = new PVector ((float)Math.random(),(float)Math.random(),(float)Math.random()); 
    }
  }
}

void update() {
  
}


void draw() {
  
  update();
  clear();
  
  noStroke();
  //translate(width/2, height/2);
  
  drawGrid(10);
}

void drawGrid (int theGridSize) {
  
    for (int i=0; i<width; i+=theGridSize) {
      for (int j=0; j<height; j+=theGridSize) {
        
        int lookupX = i/gridSize;
        int lookupY = j/gridSize;
        
        float interpolateX = (i%gridSize)/(float)gridSize;
        float interpolateY = (j%gridSize)/(float)gridSize;
        
        // color method 0
        PVector c = noiseValues[lookupX][lookupY].get();
        c.mult(255);
        
        // color method 1
        if (lookupX<width/gridSize-1) {
          c = interpolate(noiseValues[lookupX][lookupY], noiseValues[lookupX+1][lookupY], interpolateX);
        }
        
        if (lookupY<height/gridSize-1) {
          c.add(interpolate(noiseValues[lookupX][lookupY], noiseValues[lookupX][lookupY+1], interpolateY));
        }
        c.mult(127);
        //stroke(0);
        fill(c.x,c.y,c.z);
        
        pushMatrix();
        translate(i, j);
        rect(0,0,theGridSize,theGridSize);
        popMatrix();
      }
    }
}
  

PVector interpolate (PVector p0, PVector p1, float w) {
    PVector out = new PVector(0,0,0);
    out.x = lerp(p0.x, p1.x, w);
    out.y = lerp(p0.y, p1.y, w);
    out.z = lerp(p0.z, p1.z, w);
    
    return out;
}

/*
float lerp(float a0, float a1, float w) {
  return (1f - w)*a0 + w*a1;
}
*/
