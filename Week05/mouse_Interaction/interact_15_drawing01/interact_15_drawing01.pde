void setup() {
  size(600, 400);
  background(0);
  noStroke();
}

void draw() {
  if (mousePressed == true) {
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, 20, 20);
  }
}
