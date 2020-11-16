class Circle {
  float x, y, r, r2, sp, ysp;
  int id;

  Circle( float px, float py, float pr, float psp, float pysp, int pid ) {
    x = px; //x valne
    y = py; //y value
    r = pr; //radiu of circle
    r2 = r*r; //r^2
    id = pid; //id of circle
    sp = psp; //x speed of circle
    ysp = pysp; //y speed of circle
  }

  void update() {
    for (int i=0; i<numCircle; i++) {
      if (i != id) {
        intersect( this, circles[i] );
      }
    }
  }

  void makepoint() {
    stroke(0);
    strokeWeight(5);
    point(x, y);
  }

  void makeCircle() {
    noFill();
    stroke(105);
    strokeWeight(1);
    ellipse(x, y, r*2, r*2);
  }

  void move() {
    x += sp;
    y += ysp;

    if (sp > 0) {
      if (x > width+r) {
        x = -r;
      }
    } else {
      if (x < -r) {
        x = width+r;
      }
    }
    if (ysp > 0) {
      if (y > height+r) {
        y = -r;
      }
    } else {
      if (y < -r) {
        y = height+r;
      }
    }
  }

  void intersect( Circle cA, Circle cB ) {
    float dx = cA.x - cB.x;
    float dy = cA.y - cB.y;
    float d2 = dx*dx + dy*dy;
    float d = sqrt( d2 );

    if ( d>cA.r+cB.r || d<abs(cA.r-cB.r) ) {
      return; // no solution
    }

    float a = (cA.r2 - cB.r2 + d2) / (2*d);
    float h = sqrt( cA.r2 - a*a );

    //center point
    float x2 = cA.x + a*(cB.x - cA.x)/d;
    float y2 = cA.y + a*(cB.y - cA.y)/d;

    //intersectPoint a
    float paX = x2 + h*(cB.y - cA.y)/d;
    float paY = y2 - h*(cB.x - cA.x)/d;

    //intersectPoint b
    float pbX = x2 - h*(cB.y - cA.y)/d;
    float pbY = y2 + h*(cB.x - cA.x)/d;

    stroke(255-dist(paX, paY, pbX, pbY)*4);
    strokeWeight(1);

    //chord line
    line(paX, paY, pbX, pbY);

    //connection from center to center
    //line(cA.x, cA.y, cB.x, cB.y);
  }
}
