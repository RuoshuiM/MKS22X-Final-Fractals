float ave(float x, float y) {
  return (x + y) / 2;
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

class PtInTriangle {
  private PVector A, B, C, v0, v1;
  private float dot00, dot01, dot11, invDenom;

  public PtInTriangle (float[] vx, float[] vy) {
    A = new PVector(vx[0], vy[0]);
    B = new PVector(vx[1], vy[1]);
    C = new PVector(vx[2], vy[2]);

    v0 = PVector.sub(B, A);
    v1 = PVector.sub(C, A);

    dot00 = PVector.dot(v0, v0);
    dot01 = PVector.dot(v0, v1);
    dot11 = PVector.dot(v1, v1);

    invDenom = 1 / (dot00 * dot11 - dot01 * dot01);
  }

  public boolean containsPt(float x, float y) {

    PVector P = new PVector(x, y);
    PVector v2 = PVector.sub(P, A);
    float dot02 = PVector.dot(v0, v2);
    float dot12 = PVector.dot(v1, v2);

    float u = (dot11 * dot02 - dot01 * dot12) * invDenom;
    float v = (dot00 * dot12 - dot01 * dot02) * invDenom;
    
    return (u >= 0) && (v >= 0) && (u + v < 1);
  }
}

//class Msg {
//  String msg;
//  boolean toDisplay = false;
//  int startTime;
//  float duration;
//  float posX, posY;
  
//  void draw() {
//    if (toDisplay) {
//      text(msg, posX, posY);
//    }
//  }
//}
