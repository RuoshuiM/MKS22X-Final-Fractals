
// tests to ensure parts work
void testRotation() {
    float x1, y1, x2, y2, x3, y3;
    float maxWidth = width;
    float maxHeight = height;
  // do computations to determine the starting vertices of triangles
  float midWidth = maxWidth / 2;
  float midHeight = maxHeight / 2;
  float margin = midHeight * 0.2;

  x1 = midWidth;
  y1 = margin;

  float[] rotatedCoors = rotate(x1, y1, midWidth, midHeight, 120);

  x2 = rotatedCoors[0];
  y2 = rotatedCoors[1];

  rotatedCoors = rotate(x2, y2, midWidth, midHeight, 120);

  x3 = rotatedCoors[0];
  y3 = rotatedCoors[1];
  
  //triangle(x1, y1, x2, y2, x3, y3);
  fill(0);
  ellipse(midWidth, midHeight, (midHeight - margin) * 2, (midHeight - margin) * 2);
  println(height);
  
  fill(255);
  println(x1 + ", " + y1);
  println(x2 + ", " + y2);
  
  text("first pt", x1, y1);
  
  text("second pt", x2, y2);
  text("third pt", x3, y3);
  text("center", midWidth, midHeight);
  
  
  //for (int i = 0; i < 360; i+=10) {
  //  float x, y;
  //  rotatedCoors = rotate(x1, y1, midWidth, midHeight, i);
  //  x = rotatedCoors[0];
  //  y = rotatedCoors[1];
  //  text(i, x, y);
  //}
}