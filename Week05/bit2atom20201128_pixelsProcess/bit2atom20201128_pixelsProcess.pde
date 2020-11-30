PImage img;

int row = 20;
int col = 20;
boolean top, bottom, left, right;

void setup() {
  size(800, 800);
  background(255);
  img = loadImage("portrait.png");
  grid();
}

void draw() {
}

void grid() {
  int sideSize = width/row;
  for (int i = 0; i < row; i ++) {
    for (int j = 0; j < col; j ++) {
      cellDirection(i, j);
      //top
      if (top) line(sideSize*i, sideSize*j, sideSize*(i), sideSize*(j+1));
      //bottom
      if (bottom) line(sideSize*(i+1), sideSize*(j), sideSize*(i+1), sideSize*(j+1));
      //left
      if (left) line(sideSize*i, sideSize*j, sideSize*(i+1), sideSize*(j));
      //right
      if (right) line(sideSize*(i+1), sideSize*j, sideSize*(i+1), sideSize*(j+1));
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    background(255);
    grid();
  }
}

void cellDirection(int i, int j) {
  int blockSize = width/col/2;
  int pxlength = blockSize * blockSize;
  float[] brightnessOfCell = new float[4];

  for (int f = 0; f < 2; f ++) {
    for (int g = 0; g < 2; g ++) {
      for (int m = 0; m < blockSize; m ++) {
        for (int n = 0; n < blockSize; n ++) {
          brightnessOfCell[f*2+g] += brightness(img.get(blockSize*(i+f*i/2)+m, blockSize*(j+g*j/2)+n));
        }
      }
      brightnessOfCell[f*2+g] /= pxlength;
    }
  }

  float brightnessMin = 256;
  int index = -1;

  for (int r = 0; r < brightnessOfCell.length; r ++) {
    if (brightnessOfCell[r]<brightnessMin) {
      brightnessMin = brightnessOfCell[r];
      index = r;
    }
  }

  if (index == 0) {
    top = true;
    left = true;
  } else if (index == 1) {
    top = true;
    right = true;
  } else if (index == 2) {
    bottom = true;
    left = true;
  } else {
    bottom = true;
    right = true;
  }

}
