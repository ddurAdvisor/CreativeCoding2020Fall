int frame = 0;
int d = 100;

void setup() {
  size(600, 400);
  background(255);
  noStroke();
}

void draw() {
  if (frame > 100) {
    noLoop();
  } else {
    fill(255, 0, 0, 50);
    ellipse(random(width), random(height), d, d);
    frame++;
  }
}

void mousePressed() {
  loop();
  frame = 0;
  background(255);
}
