import ddf.minim.*;
import ddf.minim.analysis.*;
import controlP5.*;


Minim minim;
AudioPlayer song;
FFT fft;
ControlP5 cp5;

  
float bass;
float mid;
float high;

float bassThresh = 95;
float midThresh = 10;
float highThresh = 10;

void setup() {
  size(300, 300);
 
  cp5 = new ControlP5(this);
  cp5.addSlider("bassThresh")
      .setRange(0, 150)
      .setPosition(10,10);
  
  cp5.addSlider("midThresh")
      .setRange(0, 150)
      .setPosition(10,30);
      
  cp5.addSlider("highThresh")
      .setRange(0, 150)
      .setPosition(10,50);
    
      
  minim = new Minim(this);
 
  // this loads mysong.wav from the data folder
  song = minim.loadFile("loop2.wav", 512);
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  song.play();
}

void draw() {
  
  bass = 0;
  mid = 0;
  high = 0;
  
  background(0);
  stroke(255);
  
  
  // detect volume above threshold
  float thresh = 0.1f;
  int col = 0;
  for(int i = 0; i < song.bufferSize() - 1; i++) {
    if (abs(song.left.get(i))>thresh) {
      col += 15;    
    }
  }
  /*
  noStroke();
  fill(col);
  rect(40,40,100,100);
  */
  
  // sum amplitude of bands
  fft.forward(song.mix);
  
  int f0 = 0;
  int f1 = 25;
  int f2 = 120;
  int f3 = fft.specSize();
  
  for(int i = f0; i < f1; i++) {
    
    float b = fft.getBand(i)*4;
    if (b>bassThresh) {
      bass += b;
    }
  }
  
  for(int i = f1; i < f2; i++) {
    float m = fft.getBand(i)*4;
    if (m>midThresh) {
      mid += m;
    }
  }
  
  for(int i = f2; i < f3; i++) {
    float h = fft.getBand(i)*4;
    if (h>highThresh) {
      high += h;
    }
  }
  
  fill(bass,0,0);
  noStroke();
  rect(f0,150,f1-f0,150);
  stroke(255);
  noFill();
  rect(f0,150,f1-f0,150-bassThresh);
  
  
  
  fill(0,mid,0);
  noStroke();
  rect(f1,150,f2-f1,150);
  stroke(255);
  noFill();
  rect(f1,150,f2-f1,150-midThresh);
  
  
  
  fill(0,high,high);
  rect(f2,150,f3-f2,150);
  stroke(255);
  noFill();
  rect(f2,150,f3-f2,150-highThresh);
  
  stroke(255);
  for(int i = 0; i < fft.specSize(); i++) {
    line(i*4, height, i*4, height - fft.getBand(i)*4);
  }
}
