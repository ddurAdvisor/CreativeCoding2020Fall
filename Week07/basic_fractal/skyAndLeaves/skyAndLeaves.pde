float transparency = 150;
color leafColor = color(5,113,3,transparency);
color veinColor = color(5,113,3,transparency/2);
color branchColor = color(30);
color skyColor = color(211,211,255);

int width = 900;
int height = 500;

//branch controls
int nTrees = 1; //the number of trees
int nSegments = 15;
float totalBranchLength = 400;
float maxBranchThickness = 10;
float minBranchThickness = 2; 
float minSpawnDistance = .2; //this controls how far the branch will grow before splitting
float branchSpawnOdds = .8;   //the odds of a branch growing there
float mindThetaSplit = PI*.1;
float maxdThetaSplit = PI*.3;
float maxdThetaWander = PI/20;


//leaf controls
float minLength = 10; //leaf length
float maxLength = 30; //leaf length
float minWidth = .4;  //leaf width as a factor of length
float maxWidth = .5;  //leaf width as a factor of length
float maxBranchSizeForLeaves = 4;
float leafSpawnOdds = .7;

branch[] branches;

boolean pauseWind = false;
boolean drawWind = false;
boolean drawVeins = false;
boolean blackLeaves = false;

//int width = 1680;
//int height = 1050;

void setup(){
  size(900, 500);
  frameRate(30);
  smooth();
  noStroke();

  
  windDirection = 0;
  windVelocity = 0;
  defineLeafOutline();
  defineVeins();
  
  generateBranches();
}


void draw(){
  background(skyColor);
  
  if(!pauseWind)
    updateWind();

  //draw branches
  stroke(branchColor);
  for(int i = 0; i<nTrees; i++)
    branches[i].drawBranch(new float[]{(1+i)*(width/(1+nTrees)), height});

  noStroke();
  if(blackLeaves)
    fill(0,0,0,transparency);
  else
    fill(leafColor);
  //draw leaves
  for(int i = 0; i<nTrees; i++)
    branches[i].drawLeaves(new float[]{(1+i)*(width/(1+nTrees)), height});
  
  //move in the wind!
  for(int i = 0; i<nTrees; i++)
    branches[i].rotateDueToWind();
  
  //draw the wind line
  if(drawWind){
    stroke(0);
    int dx= 100;
    int dy = 100;
    line(dx,dy,dx+50*windVelocity*cos(windDirection),dy+50*windVelocity*sin(windDirection));
    noStroke();
    fill(0);
    ellipse(dx,dy,3,3);
  }
}
