float angle = 0;

void setup() {
  size(600, 400);
  rectMode(CENTER);
  background(0);
  noStroke();
  fill(255);
}

void draw() {
  background(0);
  // ASCII Table (www.asciitable.com)
  // ASCII 49 - 57 is 1 - 9 on your keyboard
  if (keyPressed && (key >= 49 && key <= 57)) {
    angle = map(key, 49, 57, 0, 360);
  }
  translate(width/2, height/2);
  rotate(radians(angle));
  rect(0, -100, 20, 20);
}
