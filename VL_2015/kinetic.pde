int N = 11;
int w = 40;

int ceil[][] = new int[N][N];
float v[][] = new float[N][N];
Player player = new Player();


float timePassed = 0f;
float theDeltaTime = 0f;  
  
class Player {
  
  
  PVector position = new PVector(0,0);
  PVector velocity = new PVector(random(-1,1), random(-1,1));
  PVector boundsX = new PVector(0, N*w);
  PVector boundsZ = new PVector(0, N*w);
  float timePassedInternal = 0f;
  
  public void update (float theDeltaTime) {
   
    
    position.x += velocity.x / theDeltaTime;
    position.y += velocity.y / theDeltaTime;
    
    if (position.x<boundsX.x || position.x>boundsX.y) {
      velocity.x *= -1;
    }
    
    if (position.y<boundsZ.x || position.y>boundsZ.y) {
      velocity.y *= -1;
    }
    
    timePassedInternal += theDeltaTime;
    if (timePassedInternal>2f) {
      timePassedInternal -= 2f;
      velocity = new PVector(random(-1,1), random(-1,1));
    }    
  }
  
  
  public void draw() {
    pushMatrix();
    translate(position.x, -300, position.y);
    box(30,100,10);
    popMatrix();  
  }
}

public void updateCeil() {
  
  int h = 0;
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      h = (int)PVector.dist (player.position, new PVector(i*w,j*w));
      h = (int)(10000/(h+30));
      
      float lastC = ceil[i][j];
      if (i==0 || i==N-1 || j==0 || j==N-1) {
        ceil[i][j] = (int)(680*noise(i*0.1 + timePassed*0.2, 100+j*0.1 + timePassed*0.1)) + h;
      }
      else if (i==1 || i==N-1 || j==1 || j==N-2) {
        ceil[i][j] = (int)(680*noise(i*0.5 + timePassed*0.2, 100+j*0.5 + timePassed*0.1)) + h;
      }
      else ceil[i][j] = 0;
      v[i][j] = abs(ceil[i][j] - lastC);
    }
  }
}

public void setup() {
  
  size(1200, 800, P3D);  
  frameRate(30);
}

public void draw() {
  clear();
  translate (width/2-300, height/2-200, -600);
  
  fill(255);
  updateCeil();
  drawCeil();  
  
  theDeltaTime = 1/frameRate;
  timePassed += theDeltaTime;
  
  player.update(theDeltaTime);
  //player.draw();
  
  fill(129);
  stroke(255);
  pushMatrix();
  translate(400,100,400);
  box(1000,480,2200);
  
  fill(40);
  translate(0,250,0);
  box(1000,2,1200);
  
  popMatrix();
}

public void drawCeil() {
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      pushMatrix();
      //fill(2*ceil[i][j],40,40);
      fill(5*v[i][j]);
      //if (ceil[i][j]<40) fill(50,0,0);
      translate(i*w,-140+ceil[i][j]/2, j*w);
      box(w-4,40,w-4);
      popMatrix();
    }
  }
}
