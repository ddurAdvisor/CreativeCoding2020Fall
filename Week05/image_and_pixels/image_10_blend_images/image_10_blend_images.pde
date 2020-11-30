PImage img1, img2;

void setup() {
  size(600, 400);
  background(255);
  noStroke();
  img1 = loadImage("gate.png");
  img2 = loadImage("hibiscus.jpg");
  // ADD, SUBTRACT, LIGHTEST, DARKEST, MULTIPLY
  img1.blend(img2, 0, 0, width, height, 0, 0, width, height, ADD);
  image(img1, 0, 0);
}
