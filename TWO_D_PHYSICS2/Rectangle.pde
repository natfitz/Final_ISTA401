public class Rectangle extends Shape {

  public Rectangle(float x, float y, int w, int h) {
    this.shape = createShape(RECT,x,y,w,h);
    this.shape.fill(128);
    this.X = x;
    this.Y = y;
    this.W = w;
    this.H = h;
    middle = new PVector(x + (w/2), y + (h/2));
    drawnShape = RECT;
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
    mass = (W*H) * density;
  }
  
  public void setDensity() {
    density = 1.0;
  }
  
  public void setMovable(boolean b) {
    isMovable = b; 
  }

}
