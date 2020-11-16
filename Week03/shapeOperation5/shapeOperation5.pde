int row = 10; //x方向的均分数
int col = 10; //y方向的均分数
int unitSize = 100; //图形单元尺寸
float unitAngle = PI/4; //单位旋转角度
int cellSize;
int cellStroke;

void setup() {
  size(800, 800);
  background(0);
  cellSize = width/row;
  cellStroke = cellSize/8;
  drawPattern();
}

void reset() {
  background(0);
  drawPattern();
}

void draw(){
}

void drawPattern() {
  for (int i = 0; i < row; i ++) {
    for (int j = 0; j < col; j ++) {
      pushMatrix();
      translate(i*cellSize+cellSize/2, j*cellSize+cellSize/2);
      rotate(PI/2*floor(random(4)));
      int choice = floor(random(3));
      println(choice);
      switch(choice) {
      case 0:
        shapeA();
        break;
      case 1:
        shapeB();
        break;
      case 2:
        shapeC();
        break;
      }
      popMatrix();
    }
  }
}

void shapeA() {
  stroke(102);
  strokeWeight(0.5);
  noFill();
  rectMode(CENTER);
  rect(0, 0, cellSize, cellSize);
  stroke(255);
  strokeWeight(cellStroke);
  strokeCap(SQUARE);
  line(-cellSize/2, 0, cellSize/2, 0);
}

void shapeB() {
  stroke(102);
  strokeWeight(0.5);
  noFill();
  rectMode(CENTER);
  rect(0, 0, cellSize, cellSize);
  stroke(255);
  strokeWeight(cellStroke);
  strokeCap(SQUARE);
  line(-cellSize/2, 0, cellSize/2, 0);
  line(0, -cellSize/2, 0, cellSize/2);
}

void shapeC() {
  stroke(102);
  strokeWeight(0.5);
  noFill();
  rectMode(CENTER);
  rect(0, 0, cellSize, cellSize);
  stroke(255);
  strokeWeight(cellStroke);
  strokeCap(SQUARE);
  arc(-cellSize/2, -cellSize/2, cellSize, cellSize, 0, PI/2);
}

void keyPressed() {
  if (key == 'r') {
    reset();
  }
}
