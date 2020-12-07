class Mover {
  PVector location;
  PVector velo;
  float speed;

  Mover () {
    location = new PVector(random(width), random(height));
    velo = new PVector(random(-1, 1), random(-1, 1));
    velo.normalize();

    speed = random (1, 3);
  }

  void setVelo (float posX, float posY, float stength) {

    float angle, fAngle;

    float dis;
    float mm = map (posX, 0, width, -1.2, 1.2);
    if (mm == 0) mm = 0.0001;
    float maxDis = mm*dist (0, 0, width/2, height/2);


    dis = dist (location.x, location.y, width/2, height/2);
    fAngle = map (dis, 0, maxDis, posY, 0);
    angle = map (dis, 0, maxDis, PI, 0) +  random (-PI/4*fAngle, PI/4*fAngle);

    velo.x += cos (angle)*stength;
    velo.y += sin (angle)*stength;

    velo.normalize();
  }


  void move () {

    location.add (multi (velo, speed));
  }

  void checkEdges () {
    if (location.x < 0 || location.x > width || location.y < 0 || location.y > height)
    {
      location.x = random (width);
      location.y = random (height);
    }
  }

  PVector multi (PVector v, float m) {
    return new PVector (v.x*m, v.y*m);
  }

  void display () {
    //strokeWeight (0.5);
    //fill(#b1c999, 255);
    stroke(247);
    point (location.x, location.y);
  }
}
