/**
 * Represents a gasket.
 * Coordinates are ordered: top, bottom-right, bottom-left
 *
 */
public class SierpinskiIn implements Iterable, Fractal {

  /** how many levels of sub-gaskets should this one make */
  int level;

  SierpinskiIn parent;

  /** 
   * vertices of this gasket 
   */
  float[] vx, vy;

  /** inner gaskets */
  SierpinskiIn[] inner;
  SierpinskiIn c0, c1, c2;

  public SierpinskiIn(SierpinskiIn parent, float x1, float y1, float x2, float y2, float x3, float y3) {
    this.parent = parent;

    vx = new float[] {x1, x2, x3};
    vy = new float[] {y1, y2, y3};

    float m12x = ave(x1, x2);
    float m12y = ave(y1, y2);
    float m13x = ave(x1, x3);
    float m13y = ave(y1, y3);
    float m23x = ave(x2, x3);
    float m23y = ave(y2, y3);


    //triangle(m12x, m12y, m13x, m13y, m23x, m23y);

    //int next = level + 1;

    if (abs(vx[2] - vx[1]) > VISIBLE_LEN) {
      //inner = new SierpinskiIn[3];
      //inner[0] = makeSierpinskiIn(next, x1, y1, m12x, m12y, m13x, m13y);
      //inner[1] = makeSierpinskiIn(next, m12x, m12y, x2, y2, m23x, m23y);
      //inner[2] = makeSierpinskiIn(next, m13x, m13y, m23x, m23y, x3, y3);
      //for (SierpinskiIn s : inner) {
      //  s.setParent(this);
      //}

      c0 = makeSierpinskiIn(this, x1, y1, m12x, m12y, m13x, m13y);
      c1 = makeSierpinskiIn(this, m12x, m12y, x2, y2, m23x, m23y);
      c2 = makeSierpinskiIn(this, m13x, m13y, m23x, m23y, x3, y3);
    }
  }

  /** Set up necessary settings for displaying */
  public void display() {
    fill(Sierpinski_bg);
    strokeWeight(LN_WEIGHT);

    // attempt at optimization: draw one big triangle background, then only lines inside
    triangle(vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);

    innerDisplay();
  }

  /**
   * Display this gasket and all sub-gaskets without checking bounds
   */
  private void innerDisplay() { 
    //triangle(vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);
    // seems like drawing lines are faster than drawing triangles, when background is already filled
    line(vx[0], vy[0], vx[1], vy[1]);
    line(vx[1], vy[1], vx[2], vy[2]);
    line(vx[0], vy[0], vx[2], vy[2]);

    // TODO: use iterator
    if (inner != null) {
      for (SierpinskiIn i : inner) {
        i.innerDisplay();
      }
    }
  }

  public void zoomIn(float x, float y, float factor) {
    // set up zoom

    innerZoomIn(x, y, factor);

    // do any necesssary clean up
  }

  private void innerZoomIn(float x, float y, float factor) {
    //System.out.format("Zooming in at (%f, %f) with factor %f%n", x, y, factor);
    for (int i = 0; i < vx.length; i++) {
      vx[i] = (vx[i] - x) * factor + x;
      vy[i] = (vy[i] - y) * factor + y;
    }
    if (inner != null) {
      for (SierpinskiIn s : inner) {
        if (s != null) { 
          s.zoomIn(x, y, factor);
        }
      }
    } else {

      float len = abs(vx[2] - vx[1]);

      boolean inside0 = vx[0] <= width && vy[0] <= height;
      boolean inside1 = vx[1] <= width && vy[1] <= height;
      boolean inside2 = vx[2] <= width && vy[2] <= height;

      // if gasket is larger than screen size, and all of the coors are outside check if it includes all of the screen
      if (len > width && !(inside0 || inside1 || inside2)) {
        // Compute: if the sketch is contained in this gasket. If it is, set this gasket as the parent gasket
        // http://blackpawn.com/texts/pointinpoly/default.html
        PtInTriangle triangle = new PtInTriangle(vx, vy);
        int numIn = 0;
        if (triangle.containsPt(0, 0)) numIn++;
        if (triangle.containsPt(0, height)) numIn++;
        if (triangle.containsPt(width, 0)) numIn++;
        if (triangle.containsPt(width, height)) numIn++;

        // If gasket contains three corners of the canvas, then set this gasket to be the parent
        if (numIn > 2) {
          f = this;

          // if gasket is completely outside of canvas, remove it from parent
        } else if (numIn == 0) {
          parent.removeChild(this);
        }
      }

      // no inner gaskets; create some if necessary
      if ((len > VISIBLE_LEN) && // if large enough
        (inside0 || inside1 || inside2)) { // if any coors are inside
        //inner = makeSierpinskiInChildren(level, vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);
        SierpinskiIn[] result = makeSierpinskiInChildren(this, vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);

        c0 = result[0];
        c1 = result[1];
        c2 = result[2];
      }
    }
  }

  public void zoomOut(float x, float y, float factor) {
    throw new UnsupportedOperationException("Zoom out is not supported");
  }

  void removeChild(SierpinskiIn child) {
    
  }

  @Override
  public Iterator iterator() {
    
  }

    @Override
    // finalize method is called on object once  
    // before garbage collecting it 
    protected void finalize() throws Throwable 
  { 
    System.out.println("Object garbage collected : " + this);
  }
}
