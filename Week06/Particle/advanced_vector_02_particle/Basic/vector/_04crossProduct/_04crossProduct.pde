import toxi.processing.*;
import toxi.geom.*;
import peasy.*;

Vec3D start;
Vec3D end1;
Vec3D end2;
PeasyCam cam;

void setup(){
  size(400,400,P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  start = new Vec3D(0,0,0);
  end1 = new Vec3D(50,0,0);
  end2 = new Vec3D(0,50,0);
  
}

void draw(){
  background(100);
  
  Vec3D v1 = end1.sub(start);
  Vec3D v2 = end2.sub(start);
  Vec3D cro = v1.cross(v2);
  cro.normalize();
  cro.scaleSelf(50);
  
  stroke(255);
  stroke(0,255,0);
  line(start.x,start.y,start.z,end1.x,end1.y,end1.z);
  stroke(0,0,255);
  line(start.x,start.y,start.z,end2.x,end2.y,end2.z);
  stroke(255,0,0);
  line(start.x,start.y,start.z,start.x+cro.x,start.y+cro.y,start.z+cro.z);
}
