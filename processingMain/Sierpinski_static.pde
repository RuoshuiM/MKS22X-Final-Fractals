int Sierpinski_level = 8;
float VISIBLE_LEN = 3.5;

color Sierpinski_fg = color(255, 255, 255);
color Sierpinski_bg = color(255, 0, 0);

/** Wrapper for Sierpinski class so that constructor doesn't directly call itself */
Sierpinski makeSierpinski(int levels, float x1, float y1, float x2, float y2, float x3, float y3) {
  return new Sierpinski(levels, x1, y1, x2, y2, x3, y3);
}

/** Initializes the first gasket, which is the fractal itself */
Sierpinski makeSierpinski(int maxWidth, int maxHeight, int level) {
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

  return new Sierpinski(level, x1, y1, x2, y2, x3, y3);
}

/** 
 * Make three more gaskets for the given coordinates of the parent
 */
Sierpinski[] makeChildren(int level, float x1, float y1, float x2, float y2, float x3, float y3) {
  Sierpinski[] inner = new Sierpinski[3];

  float m12x = ave(x1, x2);
  float m12y = ave(y1, y2);
  float m13x = ave(x1, x3);
  float m13y = ave(y1, y3);
  float m23x = ave(x2, x3);
  float m23y = ave(y2, y3);

  int next = level + 1;
  inner[0] = makeSierpinski(next, x1, y1, m12x, m12y, m13x, m13y);
  inner[1] = makeSierpinski(next, m12x, m12y, x2, y2, m23x, m23y);
  inner[2] = makeSierpinski(next, m13x, m13y, m23x, m23y, x3, y3);

  return inner;
}
