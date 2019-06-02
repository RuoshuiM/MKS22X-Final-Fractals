

void setup() {

  size(800, 600);
}

//float[] vx = new float[] {300, 500, 700};
//float[] vy = new float[] {100, 400, 231};

float[] vx = new float[] {random(width), random(width), random(width)};
float[] vy = new float[] {random(height), random(height), random(height)};

PVector A = new PVector(vx[0], vy[0]);
PVector B = new PVector(vx[1], vy[1]);
PVector C = new PVector(vx[2], vy[2]);

PVector v0 = PVector.sub(B, A);
PVector v1 = PVector.sub(C, A);

float dot00 = PVector.dot(v0, v0);
float dot01 = PVector.dot(v0, v1);
float dot11 = PVector.dot(v1, v1);

float invDenom = 1 / (dot00 * dot11 - dot01 * dot01);

boolean inside = false;
/*
// Compute vectors        
 v0 = C - A
 v1 = B - A
 v2 = P - A
 
 // Compute dot products
 dot00 = dot(v0, v0)
 dot01 = dot(v0, v1)
 dot02 = dot(v0, v2)
 dot11 = dot(v1, v1)
 dot12 = dot(v1, v2)
 
 // Compute barycentric coordinates
 invDenom = 1 / (dot00 * dot11 - dot01 * dot01)
 u = (dot11 * dot02 - dot01 * dot12) * invDenom
 v = (dot00 * dot12 - dot01 * dot02) * invDenom
 
 // Check if point is in triangle
 return (u >= 0) && (v >= 0) && (u + v < 1)
 */
void draw() {
  background(0);
  triangle(vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);
  
  PVector P = new PVector(mouseX, mouseY);
  PVector v2 = PVector.sub(P, A);
  float dot02 = PVector.dot(v0, v2);
  float dot12 = PVector.dot(v1, v2);

  float u = (dot11 * dot02 - dot01 * dot12) * invDenom;
  float v = (dot00 * dot12 - dot01 * dot02) * invDenom;
  inside = (u >= 0) && (v >= 0) && (u + v < 1);
  text(inside? "inside" : "outside", 20, 20);
}

void mousePressed() {
  point(mouseX, mouseY);
}
