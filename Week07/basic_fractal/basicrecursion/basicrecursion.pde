void setup(){
  size(400,400);
  smooth();
}

void draw(){
  background(255);
  drawCircle(width/2,height/2,200);
}

void drawCircle(int x, int y, float radius){
  fill(map(radius,0,200,0,255),200,100);
  ellipse(x,y,radius*2,radius*2);
  if(radius>2){
    radius *=0.75;
    drawCircle(x,y,radius);
  }
}
