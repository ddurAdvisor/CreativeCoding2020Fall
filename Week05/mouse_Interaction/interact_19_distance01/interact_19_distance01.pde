void setup() {
  size(600, 400);
  background(0);
  noStroke();
  fill(255, 0, 0);
}

void draw() {
  background(0);
  float d = dist(width/2, height/2, mouseX, mouseY);
  ellipse(width/2, height/2, d*2, d*2);
}
