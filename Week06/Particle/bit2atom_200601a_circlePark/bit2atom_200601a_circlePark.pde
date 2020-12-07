import processing.svg.*;

ArrayList<Circle> cirls;
int num = 1000;
int index = 0;
float initRadiu = 4;
boolean saveSVG = false;

void setup() {
  size(1200, 1200);
  cirls = new ArrayList<Circle>();
  //PVector p = new PVector(random(initRadiu, width-initRadiu), random(initRadiu, height-initRadiu));
  //PVector p = new PVector(random(width/3, width*2/3), random(initRadiu, height-initRadiu));

  PVector p = PVector.random2D();
  p.mult(random(width/6, width/3));
  p.add(new PVector(width/2, height/2));

  cirls.add(new Circle(p));
}

void initiate() {
  cirls = new ArrayList<Circle>();
  //PVector p = new PVector(random(initRadiu, width-initRadiu), random(initRadiu, height-initRadiu));
  //PVector p = new PVector(random(width/3, width*2/3), random(initRadiu, height-initRadiu));

  PVector p = PVector.random2D();
  p.mult(random(width/6, width/3));
  p.add(new PVector(width/2, height/2));

  cirls.add(new Circle(p));
}

void draw() {
  background(255);

  if (index <= num) {
    //PVector p = new PVector(random(initRadiu, width-initRadiu), random(initRadiu, height-initRadiu));
    //PVector p = new PVector(random(width/3, width*2/3), random(initRadiu, height-initRadiu));
    PVector p = PVector.random2D();
    p.mult(random(width/6, width/3));
    p.add(new PVector(width/2, height/2));

    int inside = 0;
    for (Circle c : cirls ) {
      float dd = PVector.dist(c.pos, p);
      if (dd < c.rr + initRadiu) {
        inside ++;
      }
    }
    if (inside < 1) {
      cirls.add(new Circle(p));
      index++;
    }
  }

  if (saveSVG) {
    beginRecord(SVG, "output/circlePark"+hour()+minute()+second()+".svg");
  }

  for (Circle c : cirls ) {
    c.update();
  }

  if (saveSVG) {
    endRecord();
    saveSVG = false;
    reset();
  }

  println(cirls.size());
}

void keyPressed() {
  if (key == 's') {
    save("output/circlePark"+hour()+minute()+second()+".png");
  }
  if (key == 'p') {
    saveSVG = true;
  }
  if (key == 'r') {
    reset();
  }
}

void reset() {
  cirls.clear();
  index = 0;
  initiate();
}
