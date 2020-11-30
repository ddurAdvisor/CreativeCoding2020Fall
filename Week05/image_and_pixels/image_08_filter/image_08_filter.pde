PImage img;

void setup() {
  size(600, 400);
  background(255);
  img = loadImage("gate.png");
}

void draw() {
  image(img, 0, 0, width, height);
  float l = map(mouseX, 0, width, 0, 20);
  // BLUR, POSTERIZE, THRESHOLD, INVERT, GRAY, ERODE, DILATE
  filter(BLUR, l);
}
