int step = 36;//旋转一周分为36步
float r = 200;//旋转半径
float ang = 0;//旋转角，这个变量是每一次迭代都在改变的，每次改变增加PI*2/36，PI*2为一个圆周（弧度）

void setup() {
  size(800, 600);//设置画面尺寸，宽800像素，高600像素
}

void draw() {
  background(0);//设置底色为黑色
  float xx = width/2 + r*cos(ang);//xx为旋转点的x轴坐标值,width/2是环绕的圆心x轴坐标值
  float yy = height/2 + r*sin(ang);//yy为旋转点的y轴坐标值，height/2是环绕的圆心y轴坐标值
  ang  = ang + PI*2/step;//每迭代一次，ang增加PI*2/step个角度
  fill(255, 0, 255);//旋转圆的填充颜色
  stroke(255);//旋转圆的轮廓颜色
  ellipse(xx, yy, 10, 10);//绘制旋转圆，直径为10个像素
  stroke(255, 0, 0);//中心圆的颜色
  ellipse(width/2, height/2, 20, 20);//绘制中心圆
  stroke(255);//连线的颜色
  line(width/2, height/2, xx, yy);//绘制旋转圆和中心圆之间的连线
}
