float angle;

void setup() {
  size(600, 400);
  background(0);
  stroke(255);
  strokeWeight(5);
}

void draw() {
  background(0);
  angle = map(mouseX, 0, width, 0, TWO_PI);
  translate(width/2, height/2);
  rotate(angle);
  triangle(0, -95, 75, 65, -75, 65);
}
