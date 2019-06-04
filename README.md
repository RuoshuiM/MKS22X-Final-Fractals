# MKS22X-Final-Fractals

# Description: 
This is a fractal viewer for Sierpinski's Triangle (or Gasket). Originally planned to include other types of fractals, but time doesn't allow it.

# Usage
- Two modes, one allows zoom out, the other doesn't. The one without zoom out allows for more zoom in levels.
- When program starts, the default mode is the one that is able to zoom out.

## Press keys to control program:

- r to reset
- o to switch to zoom-out mode and reset
- i to switch to non-zoom-out mode and reset

## Use mouse click to zoom:

- Left click: zoom in
- Right click: zoom out

# Development Log
## 20190524
- Try to draw the first triangle using rotation of point around center.
- Implements faulty rotation method, which rotates a point around another point by a certain degree.

## 20190528
### Morning
- Fixes rotation function and implements faulty gasket displaying.
- Problem: Small triangles are covered underneath the large one.

### Class
- Display fractals correctly now.

## 20190529
### Morning
- Sets up code structure for zooming.

### Class
- Basic zooming, not creating more fractals based on zooming level and position yet.

## 20190530
### Morning
- Sets up conditional display. Didn't fix error when all vertices are outside view.
- Adds more structure to zooming.

### Class
- Gasket now adds details when zooming in.

### Evening
- Rethink zooming strategy.
- Gasket now drawn based not on level but on side length.
  - Triangle vertices now ordered so side length made easier to compute.
- Gasket adds detail when zoom in, get rid of detail when zoom out.

### Problems still present:
- Inefficient displaying (calculation determining which gasket to draw is perhaps too costy)
- When zooming in, wierd effect is displayed - has to do with factor and VISIBLE_LEN variable

## 20190531 - 20190603
- Adds the Fractal interface
- Adds SierpinskiIn class, which only allows for zoom in
- Sierpinski and SierpinskiIn both implement Fractal
- Tries to optimize and throws away unecessary data in SierpinskiIn class
  - Use Barycentric coordinates to detect if view is in a gasket
- Adds support for selecting options based on keyboard
- Default mode: zoom in and out

Problem: SierpinskiIn is __Still Slow!__
