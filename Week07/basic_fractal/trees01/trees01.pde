int width = 900;
int height = 500;

boolean addSnow = false;
boolean addBlur = false;
float maxSnowTheta = HALF_PI*4/5;
 
int nTrees = 2;
tree[] trees;
color backgroundCol = color(200);
//color treeColor = color(0,255,0);
 
//initial tree properties.
float branchWidthInit;
float totalBranchLengthInit;
int nBranchDivisionsInit;
float percentBranchlessInit;
float branchSizeFractionInit;
float dThetaGrowMaxInit;
float dThetaSplitMaxInit; 
float oddsOfBranchingInit;
 
 
void setup(){
  smooth();
  size(900, 500);
  background(backgroundCol);
  noFill();
  initializeTreeValues();
  newTrees();
}
 
void draw(){}
 
void initializeTreeValues(){
  branchWidthInit = 10;
  totalBranchLengthInit = 300;
  nBranchDivisionsInit = 30;
  percentBranchlessInit = .3;
  branchSizeFractionInit = .5;
  dThetaGrowMaxInit = PI/15;
  dThetaSplitMaxInit = PI/6; 
  oddsOfBranchingInit = .3;
}
 
void newTrees(){
/* tree(x, y, theta, branchWidth0,
       totalBranchLength, nBranchDivisions, 
       percentBranchless, branchSizeFraction, 
       dThetaGrowMax, dThetaSplitMax,
       oddsOfBranching, color)
*/
 
//  background(backgroundCol);
//  noFill();
  trees = new tree[nTrees];
  for(int i=0; i<nTrees; i++)
    trees[i] = new tree(random(width), height, -HALF_PI, branchWidthInit,
                   totalBranchLengthInit, nBranchDivisionsInit, 
                   percentBranchlessInit, branchSizeFractionInit, 
                   dThetaGrowMaxInit, dThetaSplitMaxInit,
                   oddsOfBranchingInit, color(random(0,30)));
                   
  for(int i=0; i<nTrees; i++)
    trees[i].draw();
    
  if(addBlur)
    filter(BLUR,1);
}
 
 
 
void blankScreen(){
  fill(backgroundCol);
  noStroke();
  rect(0,0,width,height);
}
 
void fadeScreen(){
  fill(backgroundCol,50);
  noStroke();
  rect(0,0,width,height);
}
 
 
int randomSign(){ //returns +1 or -1
  float num = random(-1,1);
  if(num==0)
    return -1;
  else
    return (int)(num/abs(num));
}
