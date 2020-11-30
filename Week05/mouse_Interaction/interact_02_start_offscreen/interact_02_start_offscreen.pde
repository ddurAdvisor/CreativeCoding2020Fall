int d = 50;

void setup() {
  size(600, 400, P2D);
  background(0);
  noStroke();
  mouseX = -d;
  mouseY = -d;
}

void draw() {
  fill(255, 50);
  ellipse(mouseX, mouseY, d, d);
}
