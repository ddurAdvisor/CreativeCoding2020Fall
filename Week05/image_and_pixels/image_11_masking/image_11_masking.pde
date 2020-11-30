PImage img, maskImg;

void setup() {
  size(600, 400);
  background(255);
  noStroke();
  img = loadImage("gate.png");
  maskImg = loadImage("mask.jpg");
  img.mask(maskImg);
  image(img, 0, 0);
}
