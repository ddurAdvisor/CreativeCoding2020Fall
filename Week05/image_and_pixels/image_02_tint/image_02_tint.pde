PImage img;

void setup() {
  size(600, 400);
  background(255);
  img = loadImage("gate.png");
  tint(255, 0, 0);
  image(img, 0, 0, width, height);
}
