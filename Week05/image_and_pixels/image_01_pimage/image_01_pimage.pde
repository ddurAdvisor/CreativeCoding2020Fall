PImage img;

void setup() {
  size(600, 400);
  background(255);
  img = loadImage("gate.png");
  image(img, 0, 0, width, height);
}
