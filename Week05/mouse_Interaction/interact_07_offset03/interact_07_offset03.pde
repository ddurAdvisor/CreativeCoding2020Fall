int d = 100;

void setup() {
  size(600, 400);
  background(0);
  noStroke();
  mouseX = -d;
  mouseY = -d;
}

void draw() {
  background(0);
  fill(255, 50);
  ellipse(width - mouseX, height/2, d*4, d*4);
  ellipse(mouseX, height/2, d, d);
}
