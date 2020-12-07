class  Ball {
  PVector position;
  PVector speed;
  PVector acc;

  float maxSpeed = 5;
  float diamater = random(20, 80);

  Ball(PVector pos) {
    position = pos;
    speed = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }

  void update() {
    //process approach 1:
    //applyForce(collision()); //very slow    
    
    //process approach 2:
    //acc.add(collision()); //very slow    
    
    //process approach 3:
    collisionProcess(); //very qucik    
    
    speed.add(acc);
    speed.limit(maxSpeed);
    position.add(speed);
    acc = new PVector(0, 0);
    speed = new PVector(0, 0);
  }
  
  //process approach 3:
  void collisionProcess() {    
    PVector steer = new PVector();
    for (Ball b : balls) {
      float sq_d = sq(position.x - b.position.x) + sq(position.y - b.position.y);
      if (sq_d > 0 && sq_d < sq((diamater + b.diamater)/2)) {
        PVector dif = PVector.sub(position, b.position);
        dif.normalize().div(sqrt(sq_d));
        steer.add(dif);
      }
      acc.add(steer); //process acc by the end of each loop
    }
  }
  
  //process approach 1 and 2:
  PVector collision(){
    PVector steer = new PVector();
    for(Ball b : balls){
      float sq_d = sq(position.x - b.position.x) + sq(position.y - b.position.y);
      if(sq_d > 0 && sq_d < sq(diamater + b.diamater)/2){
        PVector dif = PVector.sub(position, b.position);
        dif.normalize().div(sqrt(sq_d));
        steer.add(dif);
      }
    }
    return steer;
  }

  void drawBall() {
    noFill();
    stroke(0);
    strokeWeight(1);
    ellipse(position.x, position.y, diamater, diamater);
  }
}
