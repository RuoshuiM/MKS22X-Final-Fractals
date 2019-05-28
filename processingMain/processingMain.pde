import java.util.List;
import java.util.LinkedList;

Sierpinski gasket;

double zoomLevel;

void setup() {
  size(1000, 500);

  //gasket = makeSierpinski(width, height, 9);
  surface.setResizable(true);

  gasket = makeSierpinski(width, height, 8);
  //noLoop();
}

void draw() { 
  background(50);  
  fill(255);
  //text("Click the mouse to increase levels, press a key to decrease levles", 20, 20);

  
  //gasket.display(0, height - 10, width, height - 10, width / 2, 10);
  gasket.display(); //<>//
  //testRotation();
  
  
  //koch(levels,width-10, height/2,10, height/3 ); 
  //other fractal you can do! This requires a bit more math, or you can look up the coordinates.
}

void subKock() {
  // coordinates
  // https://stackoverflow.com/a/15368026
}

public void mouseClicked() {
  float fx1, fx2, fx3, fy1, fy2, fy3;
  
}

//public void keyPressed() {
//  gasket.minusLevel();
//  redraw();
//}