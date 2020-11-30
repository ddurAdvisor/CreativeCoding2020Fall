int d = 20;

void setup() {
  size(600, 400, P2D);
  background(0);
  noStroke();
  mouseX = -d*2;
  mouseY = -d*2;
}

void draw() {
  fill(255, 50);
  ellipse(mouseX + d, mouseY, d, d);
  ellipse(mouseX - d, mouseY, d, d);
  ellipse(mouseX, mouseY + d, d, d);
  ellipse(mouseX, mouseY - d, d, d);
}
