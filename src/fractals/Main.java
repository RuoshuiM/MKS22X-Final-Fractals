/**
 * 
 */
package fractals;

import processing.core.PApplet;

/**
 * @author ruosh
 *
 */
public class Main extends PApplet {

    Sierpinski gasket;

    /**
     * @param args
     */
    public static void main(String[] args) {
        PApplet.main("fractals.Main");
    }

    public void settings() {
        size(500, 500);
    }

    public void setup() {
        gasket = new Sierpinski(this);
        surface.setResizable(true);

        noLoop();
    }

    public void draw() {

        background(50);

        fill(255);
        text("Click the mouse to increase levels, press a key to decrease levles", 20, 20);
        
        gasket.draw(0, height - 10, width, height - 10, width / 2, 10);
        // koch(levels,width-10, height/2,10, height/3 );
        // other fractal you can do! This requires a bit more math, or you can look up
        // the coordinates.
    }





    public void subKock() {
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
}
