
// LMB = Draw a new tree, with old trees fading away
// MMB = Draw a new tree, on a new background
// RMB = Snapshot


// where should the tree start drawing.  Percentage of resolution:
float treeStartX = .5;
float treeStartY = 1.0;

// TRUNK SETTINGS //

// initial trunk length, as a percentage of screen size:
float[] initTrunkLength = {.05, .1} ;
float initTrunkRotRange = 15;

// random length of new trunks.  Values greater than 1 can cause unpredictable results.
float[] segmentLengthScaleRange = {.85, 1};
// at each split, how many new possible trunks?
int[] randomNewTrunks = {1, 2};
// the range, on either side of zero, that new trunks can be created in
float trunkRotateRange = 90.0;

// test to stop our trunks from growing:
// 32 is the maximum number of trunkSegs, as limited by Processing pushPatrix issues
int maxTrunkSeg = 16;
int minPixelLength = 8;

// how wide should the trunk be to start, as a percentage of resolution, 
// and how quickly should it thin.  The thin is a multiply value, so values less than 1 will
// make it exponentially thinner each step.  It will thin natrually, but this will speed it up
float startWidth = .1;
float widthReduction = .75;

// BRANCH SETTINGS //

// How many times a branch can sprout a new branch?
int branchLevels = 3;

// int maxBranchSeg = 4;
int[] randomNewBranches = {0, 3};
float branchRotateRange = 45;
// for each branchLevel, how much shorter should it be from the previous.  Values greater than .5
// are meaningful.
float shortenBranch = .85;


// LEAF SETTINGS //

int drawTheLeaf = 1;
// define our maximum leaf size, as a percentage of screen size. Leaves get bigger as
// the trunks grow.
float maxLeafsize = .0025;
// how transparent is the leafs?  from 0 to 255
float leafTrans = 16;

// OTHER SETTINGS //

// after each tree is drawn, how much black to apply to fade it out? 0 = no black, 255 = all black.
int transparent = 128;

color randomStrokeCol;
int debug = 0;

//-----------------------------------------------
void setup(){
  size(512,512);
  background(randomColor());
  smooth();

//  frameRate(.5);
}

void draw(){
//  fill(0,0,0,transparent);
  color randomCol = randomColor();
  fill(randomCol, transparent);
  quad(0,0, width,0, height,width, 0, height); 
 
  randomStrokeCol =  randomColor();
  
  int startX = int(width*treeStartX);
  int startY = int(height*treeStartY);
  int bLength = int(height*random(initTrunkLength[0], initTrunkLength[1]));
  
// set our initial tree start location:  
  translate(startX, startY);
  rotate(radians(random(-initTrunkRotRange, initTrunkRotRange)));
  
  drawSegment(bLength, 0, branchLevels);
  noLoop();
}


// SEGMENT CODE  //
// used for drawing trunks and branches.
/*
int segmentLength  :  length of the current trunk
int itter  :  What segment is being drawn?
int trunk  :  if greater than 0, draw branches.  If 0 or less, don't draw branches
*/

void drawSegment(int segmentLength, int itter, int trunk){

  itter++;
  pushMatrix();
    
// define the new width of the segment:
  float initWidth = (startWidth * float(width));

  float it = itter;
  float iw = initWidth;  
  float mb = maxTrunkSeg;
 
  float widthStep = iw / mb;
  float curWidth = initWidth - (it * widthStep);
  float reduce = pow(widthReduction, itter);
  float newWidth = max(1, (curWidth * reduce));    
    
// code to draw the current segment:  
  strokeWeight(newWidth);
  strokeCap(ROUND);


  if(debug == 1){
    if(trunk == 3)
      stroke(255, 0, 0);
    else if(trunk == 2)
      stroke(0, 255, 0);
    else if(trunk == 1)
      stroke(0,0,255);
    else
      stroke(255);
    }
  else
    stroke(randomStrokeCol); 
    
  line(0,0,0,-segmentLength);
    

// test to make sure we can keep drawing trunks:  
  if(segmentLength > minPixelLength && itter < maxTrunkSeg){
 
 // make our branches, if this is a trunk:   
    if(trunk > 0){
      int numNewBranches = int(random(randomNewBranches[0], randomNewBranches[1]));
 
      for(int i=0; i<numNewBranches; i++){
        pushMatrix(); 
        float segLen = -segmentLength;
        float randPos = random(segLen, 0.0);
        translate(0, randPos);  
        
        float randBranchRot = random(0, branchRotateRange);
      // decide if we're branching out on the left or right side:
        float leftRight = random(0, 10);
     
    // rotate the system before we start drawing  
        if(leftRight < 5){
          rotate(radians(-randBranchRot));
        }
        else{
          rotate(radians(randBranchRot)); 
        }
      // now start drawing new branches, but as trunks: 
        int bLength = int(segmentLength * random(segmentLengthScaleRange[0], segmentLengthScaleRange[1]));   
        float newLen = bLength * shortenBranch;   
        int branchLevel = trunk - 1;
        drawSegment(int(newLen), itter, branchLevel);    
        popMatrix(); 
      } 
    } 
   
    translate(0,-segmentLength);
    int numNewTrunks = int(random(randomNewTrunks[0], randomNewTrunks[1]));

    for(int i = 0;i<numNewTrunks;i++){
      int bLength = int(segmentLength * random(segmentLengthScaleRange[0], segmentLengthScaleRange[1]));      
     
     float rotVal = trunkRotateRange;
     if(trunk < 0)
       rotVal = branchRotateRange;
     
    // choose a random rotate range:  
      float randSubRot = random(rotVal);
    // now based on that range, find our random rotation value:
      float trunkRot = random(-randSubRot, randSubRot);   
    // rotate half the range to center it first  
      rotate(-(radians(trunkRot))/2);
    // then do rotation:  
      rotate(radians(trunkRot));
      drawSegment(bLength, itter, trunk);
    }
  }
// if we've come to the end, draw our leaf:
  else{
    if(drawTheLeaf==1){
      translate(0,-segmentLength);   
      drawLeaf(itter);
    }
  }
    
  popMatrix();
}




void drawLeaf(int itter){
  noStroke();
  float i = itter;
  float mb = maxTrunkSeg;
  float alph = (i/mb)*leafTrans;
//  fill(255,255,255, int(alph));
  fill(randomStrokeCol, int(alph));  
  
  float leafVal = height * maxLeafsize;
  float leafSize = itter * leafVal;
  ellipse(0,0, leafSize, leafSize);
}


color randomColor(){
  color newRandomColor = color(random(0,255), random(0,255), random(0,255));
  return newRandomColor;
}

void mousePressed(){
  if(mouseButton == LEFT){
    loop();
  }
  if(mouseButton == CENTER){
    background(randomColor());
    loop();
  }

}
