PShape shape;
int N = 40;
PVector[][] positions;
float[][] phases;
float[][] speeds;
float[][] radiuses;


float calcAngle(PVector v1, PVector v2) {
  float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
  if (a < 0) a += TWO_PI;
  return a;
}


void setup() {
  size(600,600,P3D);
  
  positions = new PVector[N][N];
  phases = new float[N][N];
  speeds = new float[N][N];
  radiuses = new float[N][N];
  
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      positions[i][j] = new PVector(i*width/N, j*height/N);
      
      PVector p = positions[i][j].get();
      p.sub(new PVector(width/2, height/2));
      phases[i][j] = calcAngle(p, new PVector(1,0))+PI/2;
      speeds[i][j] = 0; 
      radiuses[i][j] = 20;
    }
  }
  
  shape = createShape();
  shape.beginShape(LINES);
  shape.stroke(255);
  
  int R = 10;
  float phi = 0.1f;
  
    for (int i=0; i<N; i++) {
      for (int j=0; j<N; j++) {
        shape.vertex (0,0);
        shape.vertex (0,0);
      }
    }
  shape.endShape();
}


void update() {

  float Ra = 100;
  float wa = 0.04;
  PVector attractor = new PVector(Ra*sin(wa*frameCount)+width/2, Ra*cos(wa*frameCount)+height/2);  
  
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      
      // update angle
      PVector p = positions[i][j].get();
      p.sub(attractor);
      phases[i][j] = calcAngle(p, new PVector(0,1));
      
      // update radius
      radiuses[i][j] = 1000/(1+attractor.dist(positions[i][j]));
      
      
      float phi = frameCount*speeds[i][j];
      float R = radiuses[i][j];
      
      
      
      PVector v = shape.getVertex (2*(i*N+j));
      v.x = positions[i][j].x + R*sin(phi + phases[i][j]);
      v.y = positions[i][j].y + R*cos(phi + phases[i][j]);
      shape.setVertex (2*(i*N+j), v);
      
      v = shape.getVertex (2*(i*N+j)+1);
      v.x = positions[i][j].x + R*sin(phi + PI + phases[i][j]);
      v.y = positions[i][j].y + R*cos(phi + PI + phases[i][j]);
      shape.setVertex (2*(i*N+j)+1, v);
    }
  }
}

void draw() {
  background(0);
  update();
  shape(shape);
}
