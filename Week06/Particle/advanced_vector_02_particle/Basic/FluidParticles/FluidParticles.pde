import java.util.*;

NavierStokesSolver fluidSolver;
double visc, diff, limitVelocity, vScale, velocityScale;
int oldMouseX = 1, oldMouseY = 1;
int numParticles;
Particle[] particles;
Random rnd = new Random();

public void setup() {
  fluidSolver = new NavierStokesSolver();
  frameRate(60);

  size(800, 800);

  numParticles = 10000;
  particles = new Particle[numParticles];
  visc = 0.0008f;
  diff = 0.25f;
  velocityScale = 16;

  limitVelocity = 200;

  stroke(color(0));
  fill(color(0));
  smooth();

  initParticles();
}

private void initParticles() {
  for (int i = 0; i < numParticles - 1; i++) {
    particles[i] = new Particle();
    particles[i].x = rnd.nextFloat() * width;
    particles[i].y = rnd.nextFloat() * height;
  }
}

public void draw() {

  background(color(0));

  handleMouseMotion();

  double dt = 1 / frameRate;
  fluidSolver.tick(dt, visc, diff);

  stroke(color(64));
  paintGrid();
  stroke(color(96));
  paintMotionVector((float) vScale * 2);
  vScale = velocityScale * 60/ frameRate;
  paintParticles();
}

private void paintParticles() {

  int n = NavierStokesSolver.N;
  float cellHeight = height / n;
  float cellWidth = width / n;

  int c = color(255);
  for (Particle p : particles) {
    if (p != null) {
      int cellX = floor(p.x / cellWidth);
      int cellY = floor(p.y / cellHeight);
      float dx = (float) fluidSolver.getDx(cellX, cellY);
      float dy = (float) fluidSolver.getDy(cellX, cellY);

      float lX = p.x - cellX * cellWidth - cellWidth / 2;
      float lY = p.y - cellY * cellHeight - cellHeight / 2;

      int v, h, vf, hf;

      if (lX > 0) {
        v = Math.min(n, cellX + 1);
        vf = 1;
      } else {
        v = Math.min(n, cellX - 1);
        vf = -1;
      }

      if (lY > 0) {
        h = Math.min(n, cellY + 1);
        hf = 1;
      } else {
        h = Math.min(n, cellY - 1);
        hf = -1;
      }

      float dxv = (float) fluidSolver.getDx(v, cellY);
      float dxh = (float) fluidSolver.getDx(cellX, h);
      float dxvh = (float) fluidSolver.getDx(v, h);

      float dyv = (float) fluidSolver.getDy(v, cellY);
      float dyh = (float) fluidSolver.getDy(cellX, h);
      float dyvh = (float) fluidSolver.getDy(v, h);

      dx = lerp(lerp(dx, dxv, hf * lY / cellWidth), lerp(dxh, dxvh, hf * lY / cellWidth), vf * lX / cellHeight);

      dy = lerp(lerp(dy, dyv, hf * lY / cellWidth), lerp(dyh, dyvh, hf * lY / cellWidth), vf * lX / cellHeight);

      p.x += dx * vScale;
      p.y += dy * vScale;

      if (p.x < 0 || p.x >= width) {
        p.x = random(width);
      }
      if (p.y < 0 || p.y >= height) {
        p.y = random(height);
      }

      set((int) p.x, (int) p.y, c);
    }
  }
}

private void handleMouseMotion() {
  mouseX = max(1, mouseX);
  mouseY = max(1, mouseY);

  int n = NavierStokesSolver.N;
  float cellHeight = height / n;
  float cellWidth = width / n;

  double mouseDx = mouseX - oldMouseX;
  double mouseDy = mouseY - oldMouseY;
  int cellX = floor(mouseX / cellWidth);
  int cellY = floor(mouseY / cellHeight);

  mouseDx = (abs((float) mouseDx) > limitVelocity) ? Math.signum(mouseDx) * limitVelocity : mouseDx;
  mouseDy = (abs((float) mouseDy) > limitVelocity) ? Math.signum(mouseDy) * limitVelocity : mouseDy;

  fluidSolver.applyForce(cellX, cellY, mouseDx, mouseDy);

  oldMouseX = mouseX;
  oldMouseY = mouseY;
}

private void paintMotionVector(float scale) {
  int n = NavierStokesSolver.N;
  float cellHeight = height / n;
  float cellWidth = width / n;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      float dx = (float) fluidSolver.getDx(i, j);
      float dy = (float) fluidSolver.getDy(i, j);

      float x = cellWidth / 2 + cellWidth * i;
      float y = cellHeight / 2 + cellHeight * j;
      dx *= scale;
      dy *= scale;

      line(x, y, x + dx, y + dy);
    }
  }
}

private void paintGrid() {
  int n = NavierStokesSolver.N;
  float cellHeight = height / n;
  float cellWidth = width / n;
  for (int i = 1; i < n; i++) {
    line(0, cellHeight * i, width, cellHeight * i);
    line(cellWidth * i, 0, cellWidth * i, height);
  }
}

public class Particle {
  public float x;
  public float y;
}
