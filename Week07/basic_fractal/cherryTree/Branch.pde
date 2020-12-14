public class Branch {
  public int generation;
  public int steps;
  private int maxSteps;
  private float stepLength;
  public Position position;
  public float angle;
  public float maxAngleVar = 0.2;
  public boolean active = true;
  Branch(int gen, int mstep, Position p, float ang) {
    this.generation = gen;
    this.maxSteps = mstep;
    this.steps = mstep;
    this.stepLength = 100.0/(this.generation+1);
    this.position = p;
    this.angle = ang;
  }
  public void drawStep() {
    float r = random(-1, 1);
    this.angle = this.angle + this.maxAngleVar*r;
    this.stepLength = this.stepLength - this.stepLength*0.2;
    Position oldPosition = new Position(0.0, 0.0);
    oldPosition.x = this.position.x;
    oldPosition.y = this.position.y;
    this.position.x += this.stepLength*cos(this.angle);
    this.position.y -= this.stepLength*sin(this.angle);
    strokeWeight(floor(20/(this.generation+1)));
    line(oldPosition.x, oldPosition.y, this.position.x, this.position.y);
    this.steps = this.steps - 1;
  }
  public Branch generateChild(int cn) {
    int newGen = this.generation + 1;
    float angleShift = 0.5;
    if (cn == 1) {
      angleShift = angleShift*(-1);
    }
    float childAngle = this.angle+angleShift;
    float px = this.position.x;
    float py = this.position.y;
    Position parentPos = new Position(px, py);
    Branch child = new Branch(newGen, floor(random(1, 4)), parentPos, childAngle);
    return child;
  }
}
