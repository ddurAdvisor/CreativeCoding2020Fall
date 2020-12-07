class Particle {
   
  PVector pos;
  float angle;
  float dRange;
  float dAngle;
  float rr = 10;
  color c;
//  PVector pos;
   
  Particle() {
    pos = new PVector(0,0);
    angle  = random(TWO_PI);
    dRange = 0.01;
    dAngle = 0;   
    c = color(random(255),random(255),random(255));
  }
   
  void update() {
    float cor = dRange*atan(15*dAngle)/PI;
    float randNum = (random(2)-1)*dRange-cor;  //Random number from (-dRange, dRange)
    dAngle+=randNum;                       //We don't change the angle directly
                                           //but its differential - source of the smoothness!
     
    angle+=dAngle;                         //new angle is angle+dAngle
   
    pos.x+=posStep*cos(angle);            //just move on step
    pos.y+=posStep*sin(angle);
  }
   
  void show() {
    fill(c);
    noStroke();
    ellipse(pos.x,pos.y,rr,rr);
    //ellipse(frameCount/10-100,10*angle,rr,rr);
  }
}
