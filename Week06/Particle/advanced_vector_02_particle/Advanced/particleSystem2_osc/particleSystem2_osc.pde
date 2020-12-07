import toxi.processing.*;
import toxi.geom.*;
import toxi.physics.*;
import toxi.physics.behaviors.*;
import peasy.*;
import volatileprototypes.Panel4P.*;

PeasyCam cam;
Panel4P panel;
VerletPhysics physics;
GravityBehavior gravity;
AttractionBehavior agentAttractor;
vAgent agent;
vAgent agent2D;
ToxiclibsSupport gfx;
NavierStokesSolver fluidSolver;
Random rnd = new Random();

//variables for fluid
double visc = 0.0008f;
double diff = 0.25f;
//double limitVelocity = 200;
double velocityScale = 16;
double vScale;
int oldMouseX = 1, oldMouseY = 1;

//set variables for controlling parameters
public int fluidmode=0;
public boolean setFluid =true;
public float boxSize = 800;
public float envSize = boxSize/2;
public float limitVelocity = 200;

void setup(){
  size(800,800,P3D);
  
  //initializing fluid solver
  fluidSolver = new NavierStokesSolver();
  frameRate(60);
  
  //initializing camera
  //cam = new PeasyCam(this, 1500);
  //cam.setMinimumDistance(1000);
  //cam.setMaximumDistance(2000);
 
  
  //initializing controlling panel
  panel = new Panel4P(this);
  panel.addLabel("p","Switch");
  panel.addButton("setFluid","Fluid",0);
  panel.addLabel("q","Fluid Control");
  String[] e = {"Mouse","Random"};
  panel.addButtonGroup("fluidmode",e,0);
  panel.addLabel("c","Parameter Sliders");
  panel.addSlider("limitVelocity","Velocity Limit",100,900,limitVelocity);
  panel.autoSize();
  
  //initialize wondering agent
  agent2D = new vAgent(new Vec3D(random(-boxSize/2,boxSize/2),random(-boxSize/2,boxSize/2),boxSize/2),
                     new Vec3D(random(-1,1),random(-1,1),0), 30, 5);
  
}


void draw(){
  background(50);
  
  //fluid related
  updateFluid();
  
}

//___________________________FLUID FUNCTIONS_________________________//
void updateFluid(){
  if(setFluid){
    handleMouseMotion();
    double dt = 1/frameRate;
    fluidSolver.tick(dt,visc,diff);
    paintMotionVector((float) vScale*2);
    
    vScale = velocityScale * 60/frameRate;
  }
}

void paintMotionVector(float scale) {
  int n = NavierStokesSolver.N;
  float cellHeight = height / n;
  float cellWidth = width / n;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      float dx = (float) fluidSolver.getDx(i, j);
      float dy = (float) fluidSolver.getDy(i, j);

      float x = cellWidth / 2 + cellWidth * i;
      float y = cellHeight / 2 + cellHeight * j;
      dx *= scale;
      dy *= scale;
      stroke(100,150,255);
      strokeWeight(1);
      line(x, y, x + dx, y + dy);
    }
  }
}



void handleMouseMotion() {
  int mx;
  int my;
  if(fluidmode == 0){
        mx = mouseX;
        my = mouseY;
  }else{
    agent2D.selfWander2D();
    mx = int(agent2D.pos.x);
    my = int(agent2D.pos.y);
  }
        
    mx = max(1, mx);
    my = max(1, my);

    int n = NavierStokesSolver.N;
    float cellHeight = height / n;
    float cellWidth = width / n;

    double mouseDx = mx - oldMouseX;
    double mouseDy = my - oldMouseY;
    int cellX = floor(mx / cellWidth);
    int cellY = floor(my / cellHeight);

    mouseDx = (abs((float) mouseDx) > limitVelocity) ? Math.signum(mouseDx) * limitVelocity : mouseDx;
    mouseDy = (abs((float) mouseDy) > limitVelocity) ? Math.signum(mouseDy) * limitVelocity : mouseDy;

    fluidSolver.applyForce(cellX, cellY, mouseDx, mouseDy);

    oldMouseX = mx;
    oldMouseY = my;
}
