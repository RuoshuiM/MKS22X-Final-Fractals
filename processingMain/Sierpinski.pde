public class Sierpinski {

  /** how many levels of sub-gaskets should this one make */
  int levels;

  /** color of triangle and background */
  int bg, fg;

  {
    bg = color(255, 255, 255);
    fg = color(255, 0, 0);
  }

  /** 
   vertices of this gasket 
   format: x1, y1, x2, y2, x3, y3
   */
  float[] v;

  /** inner gaskets */
  Sierpinski[] inner;

  /*
   Constructors:
   - Defualt contructor: set level to 10
   - level
   - vertices
   */

  public Sierpinski(int levels, float x1, float y1, float x2, float y2, float x3, float y3) {
    this.levels = levels;
    v = new float[] {x1, y1, x2, y2, x3, y3};
    if (levels > 0) {
      float m12x = ave(x1, x2);
      float m12y = ave(y1, y2);
      float m13x = ave(x1, x3);
      float m13y = ave(y1, y3);
      float m23x = ave(x2, x3);
      float m23y = ave(y2, y3);


      triangle(m12x, m12y, m13x, m13y, m23x, m23y);

      int next = levels - 1;
      if (next > 0) {
        makeSierpinski(next, x1, y1, m12x, m12y, m13x, m13y);
        makeSierpinski(next, x2, y2, m12x, m12y, m23x, m23y);
        makeSierpinski(next, x3, y3, m13x, m13y, m23x, m23y);
      }
    }
  }

  public void display() {
    triangle(v[0], v[1], v[2], v[3], v[4], v[5]);
    if (inner != null) {
      for (Sierpinski i : inner) {
        i.display();
      }
    }
  }

  //public void draw(float v1x, float v1y, float v2x, float v2y, float v3x, float v3y) {
  //  gasket(10, v1x, v1y, v2x, v2y, v3x, v3y);
  //}




  /**
   * Create Sierpiski's Gasket (google an image of this) The outer triangle are
   * the vertices: (v1x, v1y), (v2x,v2y), (v3x, v3y) levels: 0 = regular triangle
   * 1 = triforce (looks like 3 triangles) 2 = each of the 3 triangles will be cut
   * into 3 triangles. etc.
   */
  public void gasket(int levels, float v1x, float v1y, float v2x, float v2y, float v3x, float v3y) {
    if (levels < 0)
      return;
    noStroke();
    fill(fg);
    triangle(v1x, v2y, v2x, v2y, v3x, v3y);
    fill(bg);
    innerGasket(levels, v1x, v1y, v2x, v2y, v3x, v3y);
  }

  private void innerGasket(int lv, float x1, float y1, float x2, float y2, float x3, float y3) {
    if (lv <= 0)
      return;
    float m12x = ave(x1, x2);
    float m12y = ave(y1, y2);
    float m13x = ave(x1, x3);
    float m13y = ave(y1, y3);
    float m23x = ave(x2, x3);
    float m23y = ave(y2, y3);

    triangle(m12x, m12y, m13x, m13y, m23x, m23y);

    int next = lv - 1;
    if (next == 0)
      return;

    innerGasket(next, x1, y1, m12x, m12y, m13x, m13y);
    innerGasket(next, x2, y2, m12x, m12y, m23x, m23y);
    innerGasket(next, x3, y3, m13x, m13y, m23x, m23y);
  }


  private float ave(float x, float y) {
    return (x + y) / 2;
  }

  public void setLevel(int l) {
    levels = l;
  }

  public void addLevel() {
    levels++;
  }

  public void minusLevel() {
    levels--;
  }
}
