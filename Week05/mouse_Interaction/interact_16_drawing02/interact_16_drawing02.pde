void setup() {
  size(600, 400);
  background(0);
  stroke(255);
  strokeWeight(3);
}

void draw() {
  int x = mouseX;
  int y = mouseY;
  if (mousePressed == true) {
    line(x, y, pmouseX, pmouseY);
  }
}
