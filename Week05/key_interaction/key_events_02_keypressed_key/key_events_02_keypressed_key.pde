void setup() {
  size(600, 400);
  rectMode(CENTER);
  background(0);
  noStroke();
  fill(255);
}

void draw() {
  background(0);
  if (keyPressed && (key == 'a' || key == 'A')) {
    ellipse(width/2, height/2, 200, 200);
  } else {
    rect(width/2, height/2, 200, 200);
  }
}
