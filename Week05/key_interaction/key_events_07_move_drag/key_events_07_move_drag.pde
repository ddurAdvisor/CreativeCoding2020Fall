color dragX, dragY, moveX, moveY;

void setup() {
  size(600, 400);
  rectMode(CENTER);
  background(0);
  noStroke();
}

void draw() {
  background(0);
  fill(255, 0, 0);
  rect(dragX, dragY, 100, 100);
  fill(255);
  ellipse(moveX, moveY, 100, 100);
}

void mouseMoved() { // White ellipse
  moveX = mouseX;
  moveY = mouseY;
}

void mouseDragged() { // Red rectangle
  dragX = mouseX;
  dragY = mouseY;
}
