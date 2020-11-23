class Ball {
  float xx ;
  float yy ;
  float dd ;
  float speedX = random(5);
  float speedY = random(5);

  Ball(float x, float y, float d) {
    xx = x;
    yy = y;
    dd = d;
  }

  void update() {
    run();
    connection();
    edge();
  }

  void edge() {
    if ((xx + dd/2)>width) {
      xx = width-dd/2;
      speedX *= -1;
    }
    if ((yy + dd/2)>height) {
      yy = height-dd/2;
      speedY *= -1;
    }
    if ((xx - dd/2)<0) {
      xx = dd/2;
      speedX *= -1;
    }
    if ((yy - dd/2)<0) {
      yy = dd/2;
      speedY *= -1;
    }
  }

  void run() {
    xx += speedX;
    yy += speedY;
  }

  void show(int index) {
    fill(255);
    ellipse(xx, yy, dd, dd);
    fill(0);
    textAlign(CENTER, CENTER);
    text(index, xx, yy);
  }

  void connection() {
    for (Ball b : myBalls) {
      float dd = sqrt((xx - b.xx)*(xx - b.xx) + 
        (yy - b.yy)*(yy - b.yy));
      if (dd < 100 && b!=this) {
        stroke(153);
        strokeWeight(1);
        line(xx, yy, b.xx, b.yy);
      }
    }
  }
}
