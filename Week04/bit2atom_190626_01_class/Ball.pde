class Ball{
  PVector location;
  float dd;
  
  Ball(PVector loc, float d){
    location = loc;
    dd = d;
  }
  
  void show(){
    ellipse(location.x, location.y, dd, dd);
  }

}
