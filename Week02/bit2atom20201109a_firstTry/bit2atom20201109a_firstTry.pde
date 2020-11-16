int sw = 1;
int step = 1;

void setup(){
  size(600,900);//width, height
  background(51);
  
  //fill(102);
  //strokeWeight(sw);
  //stroke(255);
  //ellipse(width/2,height/2,100,100);
}

void draw(){
  fill(102);
  strokeWeight(sw);
  stroke(255);
  ellipse(width/2,height/2,100,100);
  sw = sw + step;
  
  if(sw > 50 || sw < 1){
    step = step *-1;
  }
}
