PImage img;
int x, y;

void setup() {
  size(600, 400);
  background(255);
  noStroke();
  img = loadImage("gate.png");
}

void draw() {
  x = mouseX;
  y = mouseY;
  image(img, 0, 0, width, height);
  // Get the color of a pixel at the
  // mouse location on the image.
  color c = get(x, y);
  fill(c);
  ellipse(x, y, 100, 100);
}
