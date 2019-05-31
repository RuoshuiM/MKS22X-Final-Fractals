# MKS22X-Final-Fractals

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
