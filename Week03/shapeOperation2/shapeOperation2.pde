void setup() {
  size(800, 800);
  background(153);
  for (int i = 0; i < 8; i ++) {
    for (int j = 0; j < 8; j ++) {
      float ang1 = map(i, 0, 7, -PI/2, PI/2);
      float ang2 = map(j, 0, 7, -PI/2, PI/2);
      float rr = cos(ang1)*50 + cos(ang2)*50;
      pushMatrix();
      translate(int(width/8*(i + 0.5)), int(height/8*(j + 0.5)));
      int rotateIndex = floor(random(4));
      rotate(PI/2*rotateIndex);
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
