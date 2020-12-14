
void setup(){
  size(600,600);
  smooth();
}

void draw(){
  background(0);
  PVector a = new PVector(0,height/2);
  PVector b = new PVector(width,height/2);
  recursion(a,b,10);
}

void recursion( PVector v1, PVector v2, int iter){
  if(iter>0){
    PVector mp = PVector.add(v1,v2);
    mp.mult(0.5);
    PVector dd = PVector.sub(v2,v1);
    float distance = dd.mag();
    noFill();
    stroke(255);
    //strokeWeight(iter);
    ellipse(mp.x,mp.y,distance,distance);
    
    recursion(v1,mp,iter-1);
    recursion(v2,mp,iter-1);
  }
}
