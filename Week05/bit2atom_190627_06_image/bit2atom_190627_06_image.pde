PImage img;
PImage reference;
int sectionNum = 9;

void setup() {
  size(630, 630);
  img = createImage(width, height, RGB);
  reference = loadImage("tulip630630.png");
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
  //image(reference, 0, 0);
}

void fillBlock(int x, int y, int size) {
  int rr = 0;
  int gg = 0;
  int bb = 0;
  color blockColr;

  for (int i = 0; i < size; i ++) {
    for (int j = 0; j < size; j ++) {
      int loc = (x*size + i) + (y*size + j)* width;
      rr += red(reference.pixels[loc]);
      gg += green(reference.pixels[loc]);
      bb += blue(reference.pixels[loc]);
    }
  }
  
  blockColr = color(rr/(size*size), gg/(size*size), bb/(size*size));

  for (int i = 0; i < size; i ++) {
    for (int j = 0; j < size; j ++) {
      int loc = (x*size + i) + (y*size + j)* width;
      img.pixels[loc] = blockColr;
    }
  }
}
