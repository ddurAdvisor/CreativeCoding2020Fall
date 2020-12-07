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
double limitVelocity = 200;
double velocityScale = 16;
double vScale;
int oldMouseX = 1, oldMouseY = 1;

//set variables for controlling parameters
public int fluidmode=0;
public boolean setGravity=false;
public boolean setAttractor=false;
public boolean setSeparation = false;
public boolean setFluid = false;
public int numParticles = 500;
public float boxSize = 800;
public float envSize = boxSize/2;
public float attStrength = 0.3;
public float sepDist = 100;
public float sepVal = 1;
public float grav = 1;

int weight = 3;

void setup(){
  size(800,800,P3D);
  
  //initializing fluid solver
  fluidSolver = new NavierStokesSolver();
  frameRate(60);
  
  //initializing camera
  cam = new PeasyCam(this, 1500);
  cam.setMinimumDistance(1000);
  cam.setMaximumDistance(2000);
  
  //initializing toxiclibcore class
  gfx=new ToxiclibsSupport(this);
  
  //initializing controlling panel
  panel = new Panel4P(this);
  panel.addLabel("p","Switch");
  panel.addButton("resetParticles","Reset");
  panel.addButton("setGravity","Gravity", 0);
  panel.addButton("setAttractor","Attractor",0);
  panel.addButton("setSeparation","Separation",0);
  panel.addButton("setFluid","Fluid",0);
  panel.addLabel("q","Fluid Control");
  String[] e = {"Mouse","Random"};
  panel.addButtonGroup("fluidmode",e,0);
  panel.addLabel("c","Parameter Sliders");
  panel.addSlider("numParticles","Number of Particles",0,1000,numParticles,4);
  panel.addSlider("attStrength","Attractor Strength",0,1.5,attStrength);
  panel.addSlider("sepDist","Separation Distance",10,300,sepDist);
  panel.addSlider("sepVal","Separation Factor",1,5,sepVal);
  panel.addSlider("grav","Gravity",0,3,grav);
  panel.autoSize();
  
  //initialize wondering agent
  agent = new vAgent(new Vec3D(random(-boxSize/2,boxSize/2),random(-boxSize/2,boxSize/2),random(-boxSize/2,boxSize/2)),
                     new Vec3D(random(-1,1),random(-1,1),random(-1,1)), 10, 0.8);
  agent2D = new vAgent(new Vec3D(random(-boxSize/2,boxSize/2),random(-boxSize/2,boxSize/2),boxSize/2),
                     new Vec3D(random(-1,1),random(-1,1),0), 10, 0.8);
  
  //setup physics field
  physics = new VerletPhysics();
  //setup drag
  physics.setDrag(0.75);
  //physics.setDrag(0.05f);
  //setup the boundary box
  physics.setWorldBounds(new AABB(boxSize/2));
  //adding pariticles to physics field
  addParticles();
  
  
}


void draw(){
  background(50);
  
  //fluid related
  updateFluid();
  
  //agent related
  updateAgent();
  
  //particle physics related
  addParticleBehaviors();
  changeParticles();
  updateParticles();
  physics.update();
  
  drawBox();
}

//___________________________FLUID FUNCTIONS_________________________//
void updateFluid(){
  if(setFluid){
    handleMouseMotion();
    double dt = 1/frameRate;
    fluidSolver.tick(dt,visc,diff);
    paintMotionVector((float) vScale*2);
    
    vScale = velocityScale * 60/frameRate;
    paintParticles();
  }
}

void paintMotionVector(float scale) {
  int n = NavierStokesSolver.N;
  float cellHeight = boxSize / n;
  float cellWidth = boxSize / n;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      float dx = (float) fluidSolver.getDx(i, j);
      float dy = (float) fluidSolver.getDy(i, j);

      float x = -boxSize/2 + cellWidth / 2 + cellWidth * i;
      float y = -boxSize/2 + cellHeight / 2 + cellHeight * j;
      dx *= scale;
      dy *= scale;
      stroke(100,150,255);
      strokeWeight(1);
      line(x, y,boxSize/2, x + dx, y + dy,boxSize/2);
    }
  }
}

void paintParticles() {
  int n = NavierStokesSolver.N;
  float cellHeight = boxSize / n;
  float cellWidth = boxSize / n;

  int c = color(255);
  for (int i = 0; i<physics.particles.size(); i++) {
    VerletParticle p = (VerletParticle)physics.particles.get(i);
    if (p != null) {
      int cellX = floor((boxSize/2+p.x) / cellWidth);
      int cellY = floor((boxSize/2+p.y)/ cellHeight);
      float dx = (float) fluidSolver.getDx(cellX, cellY);
      float dy = (float) fluidSolver.getDy(cellX, cellY);

      float lX = (boxSize/2+p.x) - cellX * cellWidth - cellWidth / 2;
      float lY = (boxSize/2+p.y) - cellY * cellHeight - cellHeight / 2;

      int v, h, vf, hf;

      if (lX > 0) {
	v = Math.min(n, cellX + 1);
	vf = 1;
      } else {
	v = Math.min(n, cellX - 1);
	vf = -1;
      }

      if (lY > 0) {
        h = Math.min(n, cellY + 1);
        hf = 1;
      } else {
        h = Math.min(n, cellY - 1);
        hf = -1;
      }

      float dxv = (float) fluidSolver.getDx(v, cellY);
      float dxh = (float) fluidSolver.getDx(cellX, h);
      float dxvh = (float) fluidSolver.getDx(v, h);

      float dyv = (float) fluidSolver.getDy(v, cellY);
      float dyh = (float) fluidSolver.getDy(cellX, h);
      float dyvh = (float) fluidSolver.getDy(v, h);

      dx = lerp(lerp(dx, dxv, hf * lY / cellWidth), lerp(dxh, dxvh, hf * lY / cellWidth), vf * lX / cellHeight);
      dy = lerp(lerp(dy, dyv, hf * lY / cellWidth), lerp(dyh, dyvh, hf * lY / cellWidth), vf * lX / cellHeight);
      
      double dblDx = dx*vScale;
      double dblDy = dy*vScale;
      float flDx = (float)dblDx;
      float flDy = (float)dblDy;
      
      double newPx = p.x+dblDx;
      double newPy = p.y+dblDy;
      
      //p.x += dx * vScale;
      //p.y += dy * vScale;
      
      if (p.x < -boxSize/2 || p.x > boxSize/2) {
        p.x = random(-boxSize/2,boxSize/2);
      }
      if (p.y < -boxSize/2 || p.y > boxSize/2) {
        p.y = random(-boxSize/2,boxSize/2);
      }
      
      
      p.addSelf(new Vec3D(flDx,flDy,0));
      //p.set((float)newPx,(float)newPy,0);
      //stroke(255);
      //point((int)p.x,(int)p.y,0);

    }
  }
}

void handleMouseMotion() {
  int mx;
  int my;
  if(fluidmode == 0){
        mx = int(map(mouseX,0,width,0,boxSize));
        my = int(map(mouseY,0,height,0,boxSize));
  }else{
    agent2D.selfWander2D();
    mx = int(boxSize/2+agent2D.pos.x);
    my = int(boxSize/2+agent2D.pos.y);
  }
        
    mx = max(1, mx);
    my = max(1, my);

    int n = NavierStokesSolver.N;
    float cellHeight = boxSize / n;
    float cellWidth = boxSize / n;

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

//___________________________PARTICLE PHYSICS FUNCTIONS_________________________//

void addParticleBehaviors(){
  physics.behaviors.clear();
  addSepCoh();
  addGravity();
  addAttractor();
}

//adding gravity behavior
void addGravity(){
  gravity = new GravityBehavior(new Vec3D(0, 0,-grav));
  if(setGravity){
    physics.removeBehavior(gravity);
    physics.addBehavior(gravity);
  }else{
    physics.removeBehavior(gravity);
  }
}

void addSepCoh(){
  if(setSeparation){
    for(int i = 0; i<physics.particles.size(); i++){
      VerletParticle p = (VerletParticle)physics.particles.get(i);
      float w = p.getWeight();
      AttractionBehavior separationAttractor = new AttractionBehavior(p, sepDist, -.10-.2*w*sepVal, 0.00f);
      AttractionBehavior cohesionAttractor = new AttractionBehavior(p, 1000, 0.001f, 0.00f);
      
      physics.addBehavior(separationAttractor);
    }
  }else{
    physics.behaviors.clear();
  }
}

//add attractor behavior
void addAttractor(){
  if(setAttractor){
    physics.removeBehavior(agentAttractor);
    agentAttractor = new AttractionBehavior(agent.pos,1500,attStrength);
    physics.addBehavior(agentAttractor);
  }else{
    physics.removeBehavior(agentAttractor);
  }
}

//adding particles inside the box at random position
void addParticles(){
  for(int i = 0; i<numParticles; i++){
    VerletParticle p = new VerletParticle(random(-boxSize/2,boxSize/2),random(-boxSize/2,boxSize/2),random(-boxSize/2,boxSize/2),weight);
    physics.addParticle(p);
  }
}

//changing the population of particles
void changeParticles(){
  if(numParticles == 0){
    physics.particles.clear();
  }else{
    if(physics.particles.size() != numParticles){
      int n = numParticles - physics.particles.size();
      while(n<0 && physics.particles.size()>0){
          physics.particles.remove(0);
          n = numParticles - physics.particles.size();
      }
      if(n>0){
        for(int i = 0; i<abs(n); i++){
          VerletParticle p = new VerletParticle(random(-boxSize/2,boxSize/2),random(-boxSize/2,boxSize/2),random(-boxSize/2,boxSize/2),weight);
          physics.addParticle(p);
        }
      }
    }
  }
}

//reset the particles
void resetParticles(){
  physics.particles.clear();
  addParticles();
}

//render particles
void updateParticles(){
  for(int i = 0; i<physics.particles.size();i++){
    VerletParticle p = (VerletParticle)physics.particles.get(i);
    strokeWeight(2);
    stroke(255);
    point(p.x,p.y,p.z);
  }
}


//__________________________AGENT FUNCTIONS_________________________//

//update agent position
void updateAgent(){
  if(setAttractor){
    agent.selfWander();
  }
}


//___________________________OTHER FUNCTIONS_________________________//

//draw box
void drawBox(){
  stroke(150);
  strokeWeight(1);
  noFill();
  box(boxSize);
  fill(100);
  pushMatrix();
  translate(0,0,-boxSize/2);
  rect(-boxSize/2,-boxSize/2,boxSize,boxSize);
  popMatrix();
}








