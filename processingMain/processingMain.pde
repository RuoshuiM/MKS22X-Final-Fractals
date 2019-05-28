import java.util.List;
import java.util.LinkedList;

Sierpinski gasket;

void setup() {
  size(500, 500);

  //gasket = makeSierpinski(width, height, 9);
  surface.setResizable(true);

  //noLoop();
}

void draw() { 
  background(50);  

  fill(255);
  text("Click the mouse to increase levels, press a key to decrease levles", 20, 20);

  
  //gasket.display(0, height - 10, width, height - 10, width / 2, 10);
  gasket = makeSierpinski(width, height, 9); //<>//
  gasket.display();
  //testRotation();
  //koch(levels,width-10, height/2,10, height/3 ); 
  //other fractal you can do! This requires a bit more math, or you can look up the coordinates.
}

void subKock() {
  // coordinates
  // https://stackoverflow.com/a/15368026
}

//public void mouseClicked() {
//  gasket.addLevel();
//  redraw();
//}

//public void keyPressed() {
//  gasket.minusLevel();
//  redraw();
//}


Sierpinski makeSierpinski(int levels, float x1, float y1, float x2, float y2, float x3, float y3) {
  return new Sierpinski(levels, x1, y1, x2, y2, x3, y3);
}


Sierpinski makeSierpinski(int maxWidth, int maxHeight, int defaultLevel) {
  float x1, y1, x2, y2, x3, y3;
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
  
  return new Sierpinski(defaultLevel, x1, y1, x2, y2, x3, y3);
}

/**
 Helper function to determing rotation of a point about another point, given a specific angle
 Rotates (x, y) around (cx, cy) for angle degrees
 */
float[] rotate(float x, float y, float cx, float cy, float angle) {
  // See https://academo.org/demos/rotation-about-point/
  float rangle = radians(angle);

  // declare tmp values to work with so not messing with original arguments
  float nx, ny, tmpx;

  // translate all pts so that cx cy are at origin
  nx = tmpx = x - cx;
  ny = y - cy;
  
  //ny = -ny;
  
  // apply rotation
  nx = nx * cos(rangle) - ny * sin(rangle);
  
  // Here nx is changed already, so use the tmp variable
  ny = ny * cos(rangle) + tmpx * sin(rangle);

  // translate back
  //ny = -ny;
  
  nx += cx;
  ny += cy;

  return new float[] {nx, ny};
}



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
