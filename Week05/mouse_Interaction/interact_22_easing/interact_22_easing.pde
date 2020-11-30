float x = 0;
float y = 0;
float easing = 0.07;

void setup() {
  size(600, 400);
  background(0);
  noStroke();
}

void draw() {
  background(0);
  fill(255);
  float targetX = mouseX;
  x += (targetX - x) * easing;
  float targetY = mouseY;
  y += (targetY - y) * easing;
  ellipse(x, y, 40, 40);
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 20, 20);
}
