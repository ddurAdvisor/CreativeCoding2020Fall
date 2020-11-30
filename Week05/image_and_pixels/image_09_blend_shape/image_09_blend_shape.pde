PImage img;

void setup() {
  size(600, 400);
  background(255);
  noStroke();
  img = loadImage("gate.png");
  // ADD, SUBTRACT, LIGHTEST, DARKEST, MULTIPLY
  fill(0);
  ellipse(width/2, height/2, 300, 300);
  blend(img, 0, 0, width, height, 0, 0, width, height, ADD);
}
