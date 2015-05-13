PShape[] channels;
int N = 400;
int NCHANNELS = 3;

// timebase
float t = 0;


void setup () {
 
  size (800,600,P3D);
  
 
  // create pshape for each channel
  channels = new PShape [NCHANNELS];
  
  // iterate over channels
  for (int i=0; i<NCHANNELS; i++) {
    
    // pshape creation code from signal1
    channels[i] = createShape(); 
    channels[i].beginShape(LINES);
    channels[i].stroke(255);
    channels[i].strokeWeight(1);
 
    for (int j=0; j<N; j++) {  
      channels[i].vertex (j*width/N,0,0);
      channels[i].vertex ((j+1)*width/N,0,0);
    }
    channels[i].endShape();
  }
}

void displacePoint (int theChannel, int index, float value) {
  
  int i = (index*2) % (N*2);
  PVector v = channels[theChannel].getVertex(i);
  v.y = value;
  channels[theChannel].setVertex(i,v);
  
  i = (index*2 + 2*N -1) % (N*2);
  v = channels[theChannel].getVertex(i);
  v.y = value;
  channels[theChannel].setVertex(i,v);
}

// pulse wave function
float pulse (float t, float theshold) {
  float v = sin(t);
  if (v<theshold) return -1;
  else return 1;  
}

float saw (float t) {
  float v = t % TWO_PI;
  v = v*2/TWO_PI - 1;
  
  return v;
}


void draw() {
  
  // increment time
  t += 1/frameRate;
  
  background(0);
  
  // amplitude
  float A = 50;

  // frequencies for signals 0 + 1
  float f0 = 0.4;
  float f1 = 2.5;
  
  // calculate signal with values [-1,1]
  //float signal0 = pulse (TWO_PI * f0 * t, 0.9);
  float signal0 = 0.5 + 0.5*saw (TWO_PI * f0 * t);
  float signal1 = sin (TWO_PI * f1 * t);
  
  // amplitude modulation
  float signal2 = signal0 * signal1;
  
  
  
  // frequency modulation f1 - base freq
  float f2 = f1 + 2*signal0;
  signal2 = sin (TWO_PI * f2 * t);
  
  // addition
  //signal2 = signal0 + 0.1*signal1;
  
  // amplitude
  signal0 *= A;
  signal1 *= A;
  signal2 *= A;
  
  //float signal2 = signal0 * signal1;
  //signal2 = noise(timePassed*100)*0.2 + noise(timePassed*2)*3;
  
  
  displacePoint (0, frameCount, signal0);
  displacePoint (1, frameCount, signal1);
  displacePoint (2, frameCount, signal2);
  
  
  
  translate (0, 150, 0);
  shape(channels[0]);
  
  translate (0, 150, 0);
  shape(channels[1]);
  
  translate (0, 150, 0);
  shape(channels[2]);
}
