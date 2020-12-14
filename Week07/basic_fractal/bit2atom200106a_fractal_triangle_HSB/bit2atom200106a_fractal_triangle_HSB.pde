PVector[] points;
int numPoint = 3;
int maxPoint = 200000;
int frameNum = 0;
int batch = 100;
float bias = 0.5;
float rotAng = PI/32;

PVector seed;
boolean fractal = false;

void setup() {
  size(800, 800);
  colorMode(HSB, maxPoint, 100, 100);
  initiatePoints();
}

void initiatePoints() {
  frameNum = 0;

  points = new PVector[numPoint];

  //for (int i = 0; i < points.length; i ++) {
  //  points[i] = new PVector(random(width), random(height));
  //}

  for (int i = 0; i < points.length; i ++) {
    float ang = TWO_PI/numPoint;
    float radiu = random(width/3, width/2);
    points[i] = new PVector(width/2 + radiu * cos(ang*i), height/2 + radiu * sin(ang*i));
  }

  seed = new PVector(random(width), random(height));
  
  background(0, 0, 100);
  showPoints();
  showSeed(0);
}

void draw() {
  for (int i = 0; i < batch; i ++) {
    if (frameNum < maxPoint) {
      if (fractal) {
        int index = (int)random(numPoint);
        fractal(index);
        showSeed(frameNum);
        frameNum ++;
      }
    }
  }
  println(frameNum);
}

void showPoints() {
  for (int i = 0; i < points.length; i ++) {
    strokeWeight(10);
    stroke(153);
    point(points[i].x, points[i].y);
  }
}

void showSeed(int indexNum) {
  strokeWeight(0.5);
  stroke(indexNum, 100, 100);
  point(seed.x, seed.y);
}

void fractal(int k) {
  PVector tmp = PVector.sub(points[k], seed);
  tmp.rotate(rotAng);
  tmp.mult(bias);
  seed.add(tmp);
}

void keyPressed() {
  if (key == 'r') {
    initiatePoints();
  }
  if (key == 'f') {
    fractal = true;
  }
  if (key == 'a') {
    numPoint ++;
    initiatePoints();
  }
  if (key == 'z') {
    if (numPoint>2) {
      numPoint --;
      initiatePoints();
    }
  }
}
