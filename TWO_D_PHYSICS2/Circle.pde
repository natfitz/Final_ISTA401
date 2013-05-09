public class Circle extends Shape {

  public Circle(float x, float y, int w, int h) {
    drawnShape = ELLIPSE;
    this.shape = createShape(drawnShape,x,y,w,h);
    this.shape.fill(128);
    this.X = x;
    this.Y = y;
    this.W = w;
    this.H = h;
    middle = new PVector(x + (w/2), y + (h/2));
    setDensity();
    setMass();
  }
  
  public void redrawShape() {
    this.shape = createShape(drawnShape, X, Y, W, H);
    this.middle.x = X + (W/2);
    this.middle.y = Y + (H/2);
    drawShape();
  }
  
  public void setMass() {
    mass = (PI * pow((W/2.0),2.0)) * density;
  }
  
  public void setDensity() {
    density = 1.0;
  }

}
