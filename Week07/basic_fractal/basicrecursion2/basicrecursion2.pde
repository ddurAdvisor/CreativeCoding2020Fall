//simple recusion

void setup(){
  size(400,400);
  smooth();
}

void draw(){
  background(255);
  //call drawCircle subroutine
  drawCircle(width/2,height/2,200);
}

//make new subroutine to draw Circle recursively
void drawCircle(float x, float y, float radius){
  noFill();
  ellipse(x,y,radius,radius);
  //make a condition to activate the command if the radius is bigger than 2
  if(radius>2){
    drawCircle(x+radius/2,y,radius/2);
    drawCircle(x-radius/2,y,radius/2);
  }
}
