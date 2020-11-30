PImage img;

int row = 40;
int col = 40;
boolean top = false;
boolean bottom = false;
boolean left = false;
boolean right = false;

boolean drawLayout = true;
boolean showDebugInfo = false;
boolean showBlockColor = false;
boolean showGrid = false;

void setup() {
  size(800, 800);
  background(255);
  img = loadImage("portrait.png");
  //image(img, 0, 0);
  //strokeCap(SQUARE);
  strokeCap(PROJECT);
  strokeJoin(MITER);
  //strokeJoin(ROUND);
  grid();
}

void draw() {
  background(255);
  grid();
}

void grid() {
  int sideSize = width/col;
  for (int i = 0; i < row; i ++) {
    for (int j = 0; j < col; j ++) {

      cellDirection(i, j);

      if (showGrid) {
        noFill();
        stroke(0);
        strokeWeight(0.5);
        rect(sideSize*j, sideSize*i, sideSize, sideSize);
      }

      if (drawLayout) {
        stroke(0);
        strokeWeight(4);
        //top
        if (top) line(sideSize*j, sideSize*i, sideSize*(j+1), sideSize*(i));
        //bottom
        if (bottom) line(sideSize*(j), sideSize*(i+1), sideSize*(j+1), sideSize*(i+1));
        //left
        if (left) line(sideSize*j, sideSize*i, sideSize*(j), sideSize*(i+1));
        //right
        if (right) line(sideSize*(j+1), sideSize*i, sideSize*(j+1), sideSize*(i+1));
      }
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    background(255);
    grid();
  }
  if (key == 'l') {
    if (drawLayout) {
      drawLayout = false;
    } else {
      drawLayout = true;
    }
  }
  if (key == 'c') {
    if (showBlockColor) {
      showBlockColor = false;
    } else {
      showBlockColor = true;
    }
  }
  if (key == 'd') {
    if (showDebugInfo) {
      showDebugInfo = false;
    } else {
      showDebugInfo = true;
    }
  }
  if (key == 'g') {
    if (showGrid) {
      showGrid = false;
    } else {
      showGrid = true;
    }
  }
}

void cellDirection(int i, int j) {
  float[] brightnessOfCell = new float[4];
  int blockSize = (width/col)/2;
  int pxlength = blockSize * blockSize;

  for (int f = 0; f < 2; f ++) {
    for (int g = 0; g < 2; g ++) {
      for (int m = 0; m < blockSize; m ++) {
        for (int n = 0; n < blockSize; n ++) {
          brightnessOfCell[f*2+g] += brightness(img.get(blockSize*(2*j+g)+n, blockSize*(2*i+f)+m));
        }
      }
      brightnessOfCell[f*2+g] /= pxlength;

      if (showBlockColor) {
        fill(brightnessOfCell[f*2+g]);
        noStroke();
        //strokeWeight(0.5);
        //stroke(153);
        rect(blockSize*(2*j+g), blockSize*(2*i+f), blockSize, blockSize);
      }
    }
  }

  float brightnessMin = 256;
  int index = -1;
  int indexTmp = -1;

  for (int r = 0; r < brightnessOfCell.length; r ++) {
    if (brightnessOfCell[r]<brightnessMin) {
      brightnessMin = brightnessOfCell[r];
      indexTmp = r;
    }
    if (brightnessMin < 255) {
      index = indexTmp;
    }
  }

  if (index == -1) {
    top = false; 
    bottom = false; 
    left = false; 
    right = false;
  } else if (index == 0) {
    top = true; 
    bottom = false; 
    left = true; 
    right = false;
  } else if (index == 1) {
    top = true; 
    bottom = false; 
    left = false; 
    right = true;
  } else if (index == 2) {
    top = false; 
    bottom = true; 
    left = true; 
    right = false;
  } else {
    top = false; 
    bottom = true; 
    left = false; 
    right = true;
  }

  if (showDebugInfo) {
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(9);
    text(index, blockSize*(2*j) + blockSize, blockSize*(2*i) + blockSize);
  }
}
