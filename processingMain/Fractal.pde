/**
 * Interface that represents a fractal, with methods to display 
 *
 *
 */
interface Fractal {
  
  void display();
  void zoomIn(float x, float y, float factor);
  void zoomOut(float x, float y, float factor);
  
  static enum Types {
    SIERPINSKI, SIERPINSKI_IN;
  }
}
