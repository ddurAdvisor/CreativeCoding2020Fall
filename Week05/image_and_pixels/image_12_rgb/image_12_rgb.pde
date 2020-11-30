PImage img, maskImg;

void setup() {
  size(600, 400);
  noStroke();
  img = loadImage("gate.png");
}

void draw() {
  background(img);
  loadPixels();
  float x = map(mouseX, 0, width, 0, 255);
  float y = map(mouseY, 0, width, 0, 255);
  for (int i = 0; i < width*height; i++) {
    color p = pixels[i];
    float r = x;
    float g = green(p);
    float b = y;
    pixels[i] = color(r, g, b);
  }
  updatePixels();
}
