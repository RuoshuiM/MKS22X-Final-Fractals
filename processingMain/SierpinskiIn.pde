/**
 * Represents a gasket.
 * Coordinates are ordered: top, bottom-right, bottom-left
 *
 */
public class SierpinskiIn {

  /** how many levels of sub-gaskets should this one make */
  int level;

  // Following code moved to static
  ///** color of triangle and background */
  //int bg, fg;
  //{
  //  bg = color(255, 255, 255);
  //  fg = color(255, 0, 0);
  //}

  //Sierpinski parent;

  /** 
   * vertices of this gasket 
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

  public SierpinskiIn(int level, float x1, float y1, float x2, float y2, float x3, float y3) {
    this.level = level;

    vx = new float[] {x1, x2, x3};
    vy = new float[] {y1, y2, y3};
    if (level < Sierpinski_level) {

      float m12x = ave(x1, x2);
      float m12y = ave(y1, y2);
      float m13x = ave(x1, x3);
      float m13y = ave(y1, y3);
      float m23x = ave(x2, x3);
      float m23y = ave(y2, y3);


      //triangle(m12x, m12y, m13x, m13y, m23x, m23y);

      int next = level + 1;
      //if (next < Sierpinski_level) {
      if (abs(vx[2] - vx[1]) > VISIBLE_LEN) {
        inner = new Sierpinski[3];
        inner[0] = makeSierpinski(next, x1, y1, m12x, m12y, m13x, m13y);
        inner[1] = makeSierpinski(next, m12x, m12y, x2, y2, m23x, m23y);
        inner[2] = makeSierpinski(next, m13x, m13y, m23x, m23y, x3, y3);
      }
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
   * Check boundary of gasket so it doesn't waste time drawing gaskets that can't be seen
   */
  private void condDisplay() {
    triangle(vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);


    if (inner != null) {


      // no need to use abs since all coors are positive
      boolean inside1 = vx[0] <= width && vy[0] <= height;
      boolean inside2 = vx[1] <= width && vy[1] <= height;
      boolean inside3 = vx[2] <= width && vy[2] <= height;

      if (inside1 && inside2 && inside3) {
        // all vertices are inside view, then all sub-gaskets should be drawn
        for (Sierpinski i : inner) {
          i.innerDisplay();
        }
      } else if (inside1 || inside2 || inside3) {
        // some vertices are inside view, let sub-gaskets determine for themselves
        for (Sierpinski i : inner) {
          i.condDisplay();
        }
      } else {
        // no vertices are inside view, don't display. 
        // a mistake: if gaskets are on opposite side of view, still do conditional display
        // for sub gaskets. If they are all outside view on same side, don't display at all

        // This will prevent taking time to display extra gaskets outside view.

        if ((vx[0] < 0 && vx[1] < 0 && vx[2] < 0) ||
          (vx[0] > width && vx[1] > width && vx[2] > width) ||
          (vy[0] < 0 && vy[1] < 0 && vy[2] < 0) ||
          (vy[0] > height && vy[1] > height && vy[2] > height)) {
          // don't draw the fractals
        } else {
          // draw the fractal, since it covers part of the view
          for (Sierpinski i : inner) {
            i.condDisplay();
          }
        }
      }
    }
  }

  /**
   * Display this gasket and all sub-gaskets without checking bounds
   */
  private void innerDisplay() { 
    //triangle(vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);
    line(vx[0], vy[0], vx[1], vy[1]);
    line(vx[1], vy[1], vx[2], vy[2]);
    line(vx[0], vy[0], vx[2], vy[2]);

    if (inner != null) {
      for (Sierpinski i : inner) {
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
      for (Sierpinski s : inner) {
        s.zoomIn(x, y, factor);
      }
    } else {
      
      float len = abs(vx[2] - vx[1]);
      
      // if gasket is larger than screen size, check if it includes all of the screen
      if (len > width) {
        // Compute: if the sketch is contained in this gasket. If it is, set this gasket as the parent gasket
        // http://blackpawn.com/texts/pointinpoly/default.html
      }
      
      // no inner gaskets; create some if necessary
      if ((len > VISIBLE_LEN) && // if large enought
        ((vx[0] <= width && vy[0] <= height) ||  // if all coors are inside view
        (vx[1] <= width && vy[1] <= height) ||
        (vx[2] <= width && vy[2] <= height))) {
        inner = makeChildren(level, vx[0], vy[0], vx[1], vy[1], vx[2], vy[2]);
      }
    }
  }

  public void zoomOut(float x, float y, float factor) {
    throw new UnsupportedOperationException("Zoom out is not supported");
  }
}