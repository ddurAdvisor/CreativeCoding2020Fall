int d = 50;

void setup() {
  size(600, 400);
  background(0);
  noStroke();
  mouseX = -d;
  mouseX = -d;
  // HAND, ARROW, CROSS, MOVE, TEXT, WAIT
  noCursor();
}

void draw() {
  fill(255, 50);
  ellipse(mouseX, mouseY, d, d);
}
