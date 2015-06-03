PShape shape;
int N = 100;


PVector[][] positions;
float[][] phaseOffsets;
float[][] velocities;
int[][] brightness;



void setup() {
  size(800,600,P3D);

  positions = new PVector[N][N];
  phaseOffsets = new float[N][N]; 
  velocities = new float[N][N];  
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      positions[i][j] = new PVector(i*width/N, j*height/N);
      phaseOffsets[i][j] = random(0,2*PI);
      velocities[i][j]   = random(-1,1);
    }
  }
  
  shape = createShape();
  shape.beginShape(LINES);
  shape.stroke(255,255,255,120);
  
  int R = 4;
  float phi = 0.1f;
  
    for (int i=0; i<N; i++) {
      for (int j=0; j<N; j++) {
        shape.stroke((int)random(0,255), (int)random(0,255), 0, 120);
        shape.vertex (0,0);
        shape.vertex (0,0);
      }
    }
  shape.endShape();
}

void update() {
  
  int R = 20;
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      
      
      positions[i][j].x += random(-1,1);
      positions[i][j].y += random(-1,1);
      
      float phi = frameCount*0.1f*velocities[i][j];
  
      PVector v = shape.getVertex (2*(i*N+j));
      v.x = positions[i][j].x + R*sin (phi+phaseOffsets[i][j]);
      v.y = positions[i][j].y + R*cos (phi+phaseOffsets[i][j]);
      shape.setVertex (2*(i*N+j), v);
      
      v = shape.getVertex (2*(i*N+j)+1);
      v.x = positions[i][j].x + R*sin(phi+PI+phaseOffsets[i][j]);
      v.y = positions[i][j].y + R*cos(phi+PI+phaseOffsets[i][j]);
      shape.setVertex (2*(i*N+j)+1, v);
    }
  }
}

void draw() {
  background(0);
  update();
  shape(shape);
}
