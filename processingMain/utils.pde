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