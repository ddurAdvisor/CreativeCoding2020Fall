import toxi.processing.*;
import toxi.geom.*;

Vec2D start;
Vec2D end;
Vec2D v1;

void setup(){
  size(400,400);
  
  start = new Vec2D(width/2,height/2);
  end = new Vec2D(width/2+100,height/2-50);
  v1 = end.sub(start);
}

void draw(){
  background(0);
  
  Vec2D mouse = new Vec2D(mouseX,mouseY);
  Vec2D v2 = mouse.sub(start);
  
  v1.normalize();
  v2.normalize();
  float vdot = v2.dot(v1);
  
  float rad = acos(vdot);
  println(degrees(rad));
  
  stroke(255);
  line(start.x,start.y,end.x,end.y);
  line(start.x,start.y,mouse.x,mouse.y);
}
