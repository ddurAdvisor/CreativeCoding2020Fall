int numFrames = 6;
int frame = 0;
PImage[] images = new PImage[numFrames];

void setup() {
  size(600, 400);
  frameRate(15);
  background(255);
  images[0] = loadImage("dove01.png");
  images[1] = loadImage("dove02.png");
  images[2] = loadImage("dove03.png");
  images[3] = loadImage("dove04.png");
  images[4] = loadImage("dove05.png");
  images[5] = loadImage("dove06.png");
}

void draw() {
  background(255);
  frame++;
  if (frame == numFrames) {
    frame = 0;
  }
  image(images[frame], mouseX - 75, mouseY - 108);
}
