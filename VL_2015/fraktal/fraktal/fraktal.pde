int N = 100;
float length = 400;

String cmd = "f+f--f+f"
int cmdSize = 8;
PVector moves[] = new PVector[8];
float rotations[] = new float[8];


void setup() {
  
  moves[0] = new PVector(length/N,0);
  moves[1] = new PVector(0,0);
  moves[2] = new PVector(length/N,0);
  moves[3] = new PVector(0,0);
  moves[4] = new PVector(0,0);
  moves[5] = new PVector(length/N,0);
  moves[6] = new PVector(0,0);
  moves[7] = new PVector(length/N,0);
  
  rotations[0] = 0;
  rotations[1] = 0.1;
  rotations[2] = 0;
  rotations[3] = -0.1;
  rotations[4] = -0.1;
  rotations[5] = 0;
  rotations[6] = 0.1;
  rotations[7] = 0;
  
  
  
  size(400,400);
  stroke(255);
}

void draw() {
  translate(0,height/2);
  background(0);
  
  for (int i=0; i<N; i++) {
    line(0,0,length/N,0);
    rotate(0.1);
    translate(length/N,0);
  }
}
