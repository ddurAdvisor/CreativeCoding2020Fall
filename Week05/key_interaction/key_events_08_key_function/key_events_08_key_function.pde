void setup() {
  size(600, 400);
  background(0);
  noStroke();
  fill(255, 50);
}

void draw() { }

void keyPressed() {
  float x = map(key, 32, 127, 0, width);
  rect(x, 0, width/127, height);
}
