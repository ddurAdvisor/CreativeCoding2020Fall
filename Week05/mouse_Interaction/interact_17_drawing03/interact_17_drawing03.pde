void setup() {
  size(600, 400);
  background(0);
  stroke(255);
}

void draw() {
  if (mousePressed == true) {
    translate(mouseX, mouseY);
    for(int i = 0; i < 10; i++) {
      strokeWeight(i);
      point(0, i * -10);
    }
  }
}
