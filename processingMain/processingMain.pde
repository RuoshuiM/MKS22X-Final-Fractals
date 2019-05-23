import java.util.List;
import java.util.LinkedList;

Sierpinski gasket;

void setup() {
  size(500, 500);

  gasket = new Sierpinski();
  surface.setResizable(true);

  noLoop();
}

void draw() { 
  background(50);  

  fill(255);
  text("Click the mouse to increase levels, press a key to decrease levles", 20, 20);

  gasket.draw(0, height - 10, width, height - 10, width / 2, 10);

  //koch(levels,width-10, height/2,10, height/3 ); 
  //other fractal you can do! This requires a bit more math, or you can look up the coordinates.
}

void subKock() {
  // coordinates
  // https://stackoverflow.com/a/15368026
}

public void mouseClicked() {
  gasket.addLevel();
  redraw();
}

public void keyPressed() {
  gasket.minusLevel();
  redraw();
}