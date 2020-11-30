color c = color(255);

void setup() {
  size(600, 400);
  rectMode(CENTER);
  background(0);
  noStroke();
}

void draw() {
  background(0);
  fill(c);
  rect(width/2, height/2, 200, 200);
}

void mousePressed() {
  c = color(255, 0, 0);
}

void mouseReleased() {
  c = color(255);
}
