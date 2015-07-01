int N = 100;
float length = 400;

//String cmd = "f+f--f+f";
String cmd = "f[+f]f[-f]f";
String fullCmd;


int cmdSize = 8;
PVector moves[] = new PVector[8];
float rotations[] = new float[8];

void iterate(char cmd) {
  if (cmd=='f') {
    line(0,0,20,0);
    translate(20,0);
  }
  if (cmd=='+') {
    rotate(0.6);
  }
  if (cmd=='-') {
    rotate(-0.6);
  }
  if (cmd=='[') {
    pushMatrix();
  }
  if (cmd==']') {
    popMatrix();
  }
}
void setup() {
  
  size(800,800);
  stroke(255);
  
  fullCmd = new String(cmd);
  
  for (int i=0; i<5; i++) {
    fullCmd = fullCmd.replace("f", cmd); 
  }
  System.out.println(fullCmd);
}

void draw() {
  translate(0,height/2);
  background(0);
  
  for (int i=0; i<fullCmd.length(); i++) {
    iterate(fullCmd.charAt(i));
  }
}
