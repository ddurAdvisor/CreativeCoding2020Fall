PVector[] location;
float[] dd;
PVector[] speed;
PVector[] acc;
PVector[] sideForce;
int elliLength = 100;
int frameNum;

void setup() {
  size(2000, 800);
  location = new PVector[elliLength];
  dd = new float[elliLength];
  speed = new PVector[elliLength];
  acc = new PVector[elliLength];
  sideForce = new PVector[2];

  for (int i = 0; i < elliLength; i ++) {
    if (i < elliLength/2) {
      location[i] = new PVector(random(-width, -width/6), random(height/6, height*5/6));
    } else {
      location[i] = new PVector(random(width+width/6, width*2), random(height/6, height*5/6));
    }
    dd[i] = random(30, 60);
    speed[i] = new PVector(random(1, 2), random(1, 2));
    acc[i] = new PVector(0, 0);
  }
}

void zebraStrip() {
  for (int i = 0; i < width/25; i ++) {
    fill(135);
    noStroke();
    rect(i*width/25, 0, width/50, height);
  }
}

void draw() {
  background(255);
  //zebraStrip();
  collision();
  goAcross();
  //connection();
  //edge();
  sideAttraction();

  drawEllipse();
  drawArrow();
  saveFrame("/motionPics/walkAcross-######.png");

  for (int i = 0; i < elliLength; i ++) {
    acc[i] = new PVector(0, 0);
  }
  frameNum++;
  if(frameNum > 1000){
    exit();
  }
}

void collision() {
  for (int i = 0; i < elliLength; i ++) {
    for (int j = 0; j < elliLength; j ++) {
      float ddist = PVector.dist(location[i], location[j]);
      if (ddist > 0 && ddist < (dd[i] + dd[j])) {
        PVector pong = PVector.sub(location[i], location[j]);
        pong.normalize();
        pong.mult(1000/ddist);//dd[i]);
        acc[i].add(pong);
      }
    }
  }
}

void goAcross() {
  for (int i = 0; i < elliLength/2; i ++) {
    for (int j = elliLength/2; j < elliLength; j ++) {
      float ddist = PVector.dist(location[i], location[j]);
      PVector pt2pt = PVector.sub(location[j], location[i]); 
      PVector leftRight = speed[i].cross(pt2pt);
      if (ddist < (dd[i] + dd[j])*5) {
        PVector pong = PVector.sub(location[i], location[j]);
        pong.normalize();
        if (leftRight.z > 0) {
          pong.rotate(HALF_PI);
        } else {
          pong.rotate(-HALF_PI);
        }
        pong.mult(400/ddist);//dd[i]);
        acc[i].add(pong);
        acc[j].sub(pong);
      }
    }
  }
}

void sideAttraction() {
  for (int i = 0; i < elliLength; i ++) {
    PVector sideForce = new PVector(0, 0);
    if (i < elliLength/2) {
      sideForce = new PVector(width*8, height/2);
    } else {
      sideForce = new PVector(-width*7, height/2);
    }
    PVector sideAttraction = PVector.sub(sideForce, location[i]);
    sideAttraction.normalize();
    sideAttraction.mult(500/dd[i]);
    acc[i].add(sideAttraction);
  }
}

void drawArrow() {
  for (int i = 0; i < elliLength; i ++) {
    float ang = speed[i].heading();
    //stroke(#A060CE);
    if (i < elliLength/2) {
      stroke(153);
    } else {
      stroke(0);
    }
    float arrowLength = 15;
    PVector headLocation = new PVector(location[i].x+10*speed[i].mag()*cos(ang), location[i].y+10*speed[i].mag()*sin(ang));
    line(location[i].x, location[i].y, headLocation.x, headLocation.y);
    line(headLocation.x, headLocation.y, headLocation.x + arrowLength*cos(ang + PI*3/4), headLocation.y + arrowLength*sin(ang + PI*3/4));
    line(headLocation.x, headLocation.y, headLocation.x + arrowLength*cos(ang - PI*3/4), headLocation.y + arrowLength*sin(ang - PI*3/4));
  }
}

void drawEllipse() {
  for (int i = 0; i < elliLength; i ++) {
    //fill((int)map(i, 0, elliLength-1, 50, 200));
    if (i < elliLength/2) {
      fill(0);
    } else {
      fill(153);
    }
    noStroke();
    ellipse(location[i].x, location[i].y, dd[i], dd[i]);

    //draw Arrows at the end of each speed vectors
    //float ang = speed[i].heading();
    //stroke(255); //stroke(#9C9AEA);
    //float arrowLength = 10;
    //PVector headLocation = new PVector(location[i].x+10*speed[i].mag()*cos(ang), location[i].y+10*speed[i].mag()*sin(ang));
    //line(location[i].x, location[i].y, headLocation.x, headLocation.y);
    //line(headLocation.x, headLocation.y, headLocation.x + arrowLength*cos(ang + PI*3/4), headLocation.y + arrowLength*sin(ang + PI*3/4));
    //line(headLocation.x, headLocation.y, headLocation.x + arrowLength*cos(ang - PI*3/4), headLocation.y + arrowLength*sin(ang - PI*3/4));
    //fill(0);
    //textAlign(CENTER, CENTER);
    //text(i, location[i].x, location[i].y);

    if (PVector.angleBetween(speed[i], acc[i])>PI/4 || PVector.angleBetween(speed[i], acc[i])< -PI/4) {
      //acc[i] = new PVector(0, 0);
      speed[i] = new PVector(0, 0);
    } else {
      speed[i].add(acc[i]);
      speed[i].limit(5);
      location[i].add(speed[i]);
      acc[i] = new PVector(0, 0);
      //speed[i] = new PVector(0, 0);
    }
  }
}

void connection() {
  for (int i = 0; i < elliLength; i ++) {
    for (int j = 0; j < elliLength; j ++) {
      if (i != j) {
        float ddist = PVector.dist(location[i], location[j]);
        if (ddist < 50) {
          stroke(#9ED12A);
          line(location[i].x, location[i].y, location[j].x, location[j].y);
        }
      }
    }
  }
}

void edge() {
  for (int i = 0; i < elliLength; i ++) {

    if (location[i].x + dd[i]/2 > width*2) {
      location[i].x = width*2 - dd[i]/2;
      speed[i].x = speed[i].x *-1;
    }

    if (location[i].x - dd[i]/2 < -width) {
      location[i].x = dd[i]/2-width;
      speed[i].x = speed[i].x *-1;
    }

    if (location[i].y + dd[i]/2 > height) {
      location[i].y = height - dd[i]/2;
      speed[i].y *=-1;
    }

    if (location[i].y  - dd[i]/2 < 0) {
      location[i].y = dd[i]/2;
      speed[i].y *=-1;
    }
  }
}
