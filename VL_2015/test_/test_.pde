int cnt = 0;
int size = 4;
int N_ELEMENTS = 175;
float[] randomValues = new float[N_ELEMENTS];

void setup() {
  
   for (int i=0; i<N_ELEMENTS; i++) {
    randomValues[i] = random(0,2*PI); 
   }
   
   size(300, 300); 
   frameRate(30);
}


void draw() {
  
  background (0, 0, 0);
  noStroke();
  
  translate(width/2, 0);
  
  for (int i=0; i<175; i++) {
    
   float phase = cnt*2*PI/200.0 + randomValues[i];
   phase = phase%(2*PI);
   
   if (phase<PI/2 || phase>1.5*PI) {
     fill(255,0,0);  
   }
   else {
     fill(255);
   }
   
   
   float x = sin(phase) * 100;
   
   translate(0, size);
   pushMatrix();
   translate(x,0);
   rect(0,0,size,size);
   popMatrix();
  }
  
  cnt += 1;
}
