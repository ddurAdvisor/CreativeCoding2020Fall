import java.util.Iterator;

ArrayList cells;
ArrayList newcells;
PImage img;
float food[][];

String filename = "darkvador.jpeg";
boolean inverted = false; // true -> white background

void settings() {
  img = loadImage("george.png");//("einstain1280.png");
  size(img.width, img.height);
}

void setup() {
  food = new float[width][height];
  for (int x = 0; x < width; ++x)
    for (int y = 0; y < height; ++y) {
      food[x][y] = ((img.pixels[(x+y*width)] >> 8) & 0xFF)/255.0;
      if (inverted) food[x][y] = 1-food[x][y];
    }
  if (inverted) {
    background(255);
  } else {
    background(0);
  }
  cells = new ArrayList();
  newcells = new ArrayList();
  Cell c = new Cell();
  c.xpos = width/2;
  c.ypos = height/4;
  cells.add(c);
}

void keyPressed() {
  saveFrame("images/export/" + filename+"/e-#####.png");
}

void draw() {
  loadPixels();
  newcells.clear();
  Iterator<Cell> itr = cells.iterator();
  while (itr.hasNext ()) {
    Cell c = itr.next();
    c.draw();
    c.update();
  }

  cells.addAll(newcells);
  updatePixels();
}

float feed(int x, int y, float thresh) {
  float r = 0.0;
  if (x >= 0 && x < width && y >= 0 && y < height) {
    if (food[x][y] > thresh) {
      r = thresh;
      food[x][y] -= thresh;
    } else {
      r = food[x][y];
      food[x][y] = 0.0;
    }
  }
  return r;
}
