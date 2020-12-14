// Start with an axiom.
String current = "A";
// Let’s keep track of how many generations.
int count = 0;

void setup() {
  println("Generation " + count + ": " + current);
}

void draw() {
}

void mousePressed() {
  String next = "";
  // Traverse the current String and make the new one.
  for (int i = 0; i < current.length(); i++) {
    char c = current.charAt(i);
    if (c == 'A') {
      next += "AB";
    }  else if (c == 'B') {
      next += "A";
    }
  }
  current = next;
  count++;
  println("Generation " + count + ": " + current);
}
