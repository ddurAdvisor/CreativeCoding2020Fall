int row = 8; //x方向的均分数
int col = 8; //y方向的均分数
int unitSize = 100; //图形单元尺寸
float unitAngle = PI/4; //单位旋转角度

void setup() {
  size(800, 800);
  background(153);
  for (int i = 0; i < row; i ++) {
    for (int j = 0; j < col; j ++) {
      float ang1 = map(i, 0, row-1, -PI/2, PI/2);
      float ang2 = map(j, 0, col-1, -PI/2, PI/2);
      float rr = cos(ang1)*unitSize/2 + cos(ang2)*unitSize/2;
      pushMatrix();
      translate(int(width/row*(i + 0.5)), int(height/col*(j + 0.5)));
      int step = floor(TWO_PI/unitAngle);
      int rotateIndex = floor(random(step));
      rotate(unitAngle*rotateIndex);
      drawShape(int(rr));
      popMatrix();
    }
  }
}

void drawShape(int sideLength) {
  noStroke();
  fill(255, 255, 0);
  ellipse(0, 0, sideLength, sideLength);
  rectMode(CENTER);
  rect(0, sideLength/4, sideLength, sideLength/2);
}
