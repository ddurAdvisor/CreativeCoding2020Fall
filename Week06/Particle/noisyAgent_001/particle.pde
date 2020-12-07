class Particle{
  PVector pos;
  float speed;
  color c;
  ArrayList path;
  int t=0;
 
  Particle(){
    c=color(random(155),random(50,255),random(150,255),50);
    pos=new PVector(random(-400,400),random(-400,400),0);
    sc=0.007;
    speed=random(10,50);
    path=new ArrayList();
  }
 
  void behave(){
    if(t<100){
    pos.x+=(noise(i,pos.x*sc,pos.y*sc)-.5)*speed;
    pos.y+=(noise(i+2,pos.x*sc,pos.z*sc)-.5)*speed;
    pos.z+=(noise(i+3,pos.x*sc,pos.y*sc)-.5)*speed;
    path.add(new PVector(pos.x,pos.y,pos.z));
    t++;
    }
  }
 
  void display(){
    stroke(c);
    strokeWeight(5);
    for(int i=1;i<path.size();i++){
      PVector c=(PVector)path.get(i-1);
      PVector p=(PVector)path.get(i);
      line(p.x,p.y,p.z,c.x,c.y,c.z);
    }
  }
}

