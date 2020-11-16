//测试一下中文字体的显示效果

void setup(){
  size(600, 600);
  background(255);
  int num = 60;
  int sw = 10;
  for(int i = 0; i < num; i ++){
    //drawLine(0, sw*i, width, sw*i, sw, 255/num*i);
    drawRectangle(0, sw*i, sw, 255/num*i); //10*(i%10));
  }
}

void drawLine(int startX, int startY, int endX, int endY, int strokeW, color strokeC){
  strokeWeight(strokeW);
  stroke(strokeC);
  line(startX, startY, endX, endY);
}

void drawRectangle(int startX, int startY, int strokeW, color strokeC){
  fill(strokeC);
  noStroke();
  rect(startX, startY, width, strokeW);
}
