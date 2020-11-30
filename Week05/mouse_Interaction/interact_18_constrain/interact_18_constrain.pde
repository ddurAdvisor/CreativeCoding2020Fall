void setup() {
  size(600, 400);
  background(0);
  noStroke();
}

void draw() {
  float x = constrain(mouseX, 100, 500);
  float y = constrain(mouseY, 100, 300);
  if (mousePressed == true) {
    fill(255, 0, 0);
    ellipse(x, y, 20, 20);
  }
}
