float L = 30;
float I;
float gravity = 0.05;
float spring = 0.15;
float damping = 0.001;
ArrayList blocks;

void setup(){
  size(600,800);
  I = L*L/6;
  stroke(0);
  smooth();
  noFill();
  blocks = new ArrayList();
  
  for(int i=0;i<200;i++){
    blocks.add(new block());
  }
  
}

void draw(){
  if(frameCount%60==1){println(frameRate);}
  background(#FFFFFF);
  
  for(int i=1;i<blocks.size();i++){
    block blk = (block) blocks.get(i);
    for(int j=0;j<i;j++){
      block blk2 = (block) blocks.get(j);
      PVector dx = PVector.sub(blk2.location,blk.location);
      if((abs(dx.x)<L*1.5)&&(abs(dx.y)<L*1.5)){
        if(dx.mag()<L*0.8){
          float restore = 3*spring*(L-dx.mag());
          dx.normalize();
          dx.mult(restore);
          blk2.forceSum.add(dx);
          blk.forceSum.sub(dx);
          blk2.pressure += dx.mag();
          blk.pressure += dx.mag();
        }else if(dx.mag()<L*1.5){
          blk.testPoints(blk2);
          blk2.testPoints(blk);
        }
      }
    }
  }
  
  PVector mouseLocation = new PVector(mouseX,mouseY);
  PVector mouseVelocity = PVector.sub(mouseLocation,new PVector(pmouseX,pmouseY));
  
  for(int i=0;i<blocks.size();i++){
    block blk = (block) blocks.get(i);
    if(mousePressed){
      PVector dx = PVector.sub(blk.location,mouseLocation);
      if(dx.mag()<L*0.75){
        blk.forceSum.add(PVector.mult(PVector.sub(
          mouseVelocity,blk.velocity),0.8));
      }
    }
    blk.testWalls();
    blk.update();
    blk.draw();
  }
  
}