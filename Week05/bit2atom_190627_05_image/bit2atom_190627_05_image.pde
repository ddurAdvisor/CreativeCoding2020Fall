PImage img;
int sectionNum = 9;

void setup() {
  size(630, 630);
  img = createImage(width, height, RGB);
  img.loadPixels();
  for (int i = 0; i < sectionNum; i ++) {
    for (int j = 0; j < sectionNum; j ++) {
      fillBlock(i, j, width / sectionNum);
    }
  }
  img.updatePixels();
}

void draw() {
  background(0);
  image(img, 0, 0);
}

void fillBlock(int x, int y, int size) {
  for (int i = 0; i < size; i ++) {
    for (int j = 0; j < size; j ++) {
      int loc = (x*size + i) + (y*size + j)* width;
      if (x%2 == y%2) {
        img.pixels[loc] = color(255, 255, 255);
      } else {
        img.pixels[loc] = color(0, 0, 0);
      }
    }
  }
}
