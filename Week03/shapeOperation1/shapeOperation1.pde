void setup() {
  size(800, 800);
  background(153);
  for (int i = 0; i < 8; i ++) {
    for (int j = 0; j < 8; j ++) {
      float ang1 = map(i, 0, 7, -PI/2, PI/2);
      float ang2 = map(j, 0, 7, -PI/2, PI/2);
      float rr = cos(ang1)*50 + cos(ang2)*50;
      drawShape(int(width/8*(i + 0.5)), int(height/8*(j + 0.5)), int(rr));
    }
  }
}

void drawShape(int posX, int posY, int sideLength) {
  noStroke();
  fill(255, 255, 0);
  ellipse(posX, posY, sideLength, sideLength);
  rectMode(CENTER);
  rect(posX, posY+sideLength/4, sideLength, sideLength/2);
}
