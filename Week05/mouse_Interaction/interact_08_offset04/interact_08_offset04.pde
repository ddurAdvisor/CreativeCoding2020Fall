int d = 80;

void setup() {
  size(600, 400);
  background(0);
  noStroke();
}

void draw() {
  background(0);
  fill(255);
  float normX = mouseX / float(width);
  ellipse(mouseX, 100, d, d);
  ellipse(pow(normX, 4) * width, 200, d, d);
  ellipse(pow(normX, 8) * width, 300, d, d);
}
