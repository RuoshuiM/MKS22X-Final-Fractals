public class Sierpinski {

  /** how many levels of sub-gaskets should this one make */
  int levels;

  /** color of triangle and background */
  int bg, fg;
  
  Sierpinski parent;

  {
    bg = color(255, 255, 255);
    fg = color(255, 0, 0);
  }

  /** 
   vertices of this gasket 
   */
  float[] vx, vy;

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
    vx = new float[] {x1, x2, x3};
    vy = new float[] {y1, y2, y3};
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
        inner = new Sierpinski[3];
        inner[0] = makeSierpinski(next, x1, y1, m12x, m12y, m13x, m13y);
        inner[1] = makeSierpinski(next, x2, y2, m12x, m12y, m23x, m23y);
        inner[2] = makeSierpinski(next, x3, y3, m13x, m13y, m23x, m23y);
        
        
        inner[0].setParent(this);
        inner[1].setParent(this);
        inner[2].setParent(this);
      }
    }
  }
  
  /** Set up necessary settings for displaying */
  public void display() {
    fill(fg);
    strokeWeight(0.000001);
    innerDisplay();
  }
  
  private void innerDisplay() {
    triangle(vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);
    if (inner != null) {
      for (Sierpinski i : inner) {
        i.innerDisplay();
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
  //public void gasket(int levels, float v1x, float v1y, float v2x, float v2y, float v3x, float v3y) {
  //  if (levels < 0)
  //    return;
  //  noStroke();
  //  fill(fg);
  //  triangle(v1x, v2y, v2x, v2y, v3x, v3y);
  //  fill(bg);
  //  innerGasket(levels, v1x, v1y, v2x, v2y, v3x, v3y);
  //}

  //private void innerGasket(int lv, float x1, float y1, float x2, float y2, float x3, float y3) {
  //  if (lv <= 0)
  //    return;
  //  float m12x = ave(x1, x2);
  //  float m12y = ave(y1, y2);
  //  float m13x = ave(x1, x3);
  //  float m13y = ave(y1, y3);
  //  float m23x = ave(x2, x3);
  //  float m23y = ave(y2, y3);

  //  triangle(m12x, m12y, m13x, m13y, m23x, m23y);

  //  int next = lv - 1;
  //  if (next == 0)
  //    return;

  //  innerGasket(next, x1, y1, m12x, m12y, m13x, m13y);
  //  innerGasket(next, x2, y2, m12x, m12y, m23x, m23y);
  //  innerGasket(next, x3, y3, m13x, m13y, m23x, m23y);
  //}

  public void zoomIn(float x, float y, float factor) {
    //System.out.format("Zooming in at (%f, %f) with factor %f%n", x, y, factor);
    for (int i = 0; i < vx.length; i++) {
      vx[i] = (vx[i] - x) * factor + x;
      vy[i] = (vy[i] - y) * factor + y;
    }
    
    if (inner != null) {
      for(Sierpinski s : inner) {
        s.zoomIn(x, y, factor);
      }
    }
  }
  
  public void zoomOut(float x, float y, float factor) {
    //System.out.format("Zooming out at (%f, %f) with factor %f%n", x, y, factor);
    for (int i = 0; i < vx.length; i++) {
      vx[i] = (vx[i] - x) / factor + x;
      vy[i] = (vy[i] - y) / factor + y;
    }
    
    if (inner != null) {
      for(Sierpinski s : inner) {
        s.zoomOut(x, y, factor);
      }
    }
  }
  
  public void setParent(Sierpinski s) {
    this.parent = s;
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