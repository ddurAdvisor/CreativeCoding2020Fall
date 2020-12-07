class Cell {
  float xpos, ypos;
  float dir;
  float state;
  Cell() {
    xpos = random(width);
    ypos = random(height);
    dir = random(2*PI);
    state = 0;
  }
  Cell(Cell c) {
    xpos = c.xpos;
    ypos = c.ypos;
    dir = c.dir;
    state = c.state;
  }
  void draw() {
    if (state > 0.001 && xpos >= 0 && xpos < width && ypos >= 0 && ypos < height) {
      if (inverted) {
        pixels[ int(xpos) + int(ypos) * width ] = color(0, 0, 0);
      } else {
        pixels[ int(xpos) + int(ypos) * width ] = color(255, 255, 255);
      }
    }
  }
  void update(){
    state += feed(int(xpos), int(ypos), 0.3) - 0.295;
    xpos += cos(dir);
    ypos += sin(dir);
    dir += random(-PI/4, PI/4);
    if (state > 0.15 && cells.size() < 100) {
      divide();
    } else
      if (state < 0) {
      xpos += random(-15, +15);
      ypos += random(-15, +15);
      state = 0.001;
    }
  }
  void divide() {
    state /= 2;
    Cell c = new Cell(this);
    float dd = random(PI/4);
    dir += dd;
    c.dir -= dd;
    newcells.add(c);
  }
}
