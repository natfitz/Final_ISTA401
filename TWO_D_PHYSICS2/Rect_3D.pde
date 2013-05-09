public class Rect_3D extends Shape {
  
  public Rect_3D(float x, float y, float z, int w, int h, int d) {
    this.X = x - (w/2);
    this.Y = y - (h/2);
    this.Z = (z * 1.5);
    displayX = x;
    displayY = y;
    this.W = w;
    this.H = h;
    this.D = d;
    maxW = w*2;
    maxH = h*2;
    maxD = d*2;
    saveD = d;
    setDensity();
    setMass();
  }
  
  public void redrawShape() {
    drawShape();
  }
  
  public void drawShape() {
    displayX = X + (W/2);
    displayY = Y + (H/2);
    stroke(sr, sg, sb);
    if (sw == 0)
      noStroke();
    else  
      strokeWeight(sw);
    fill(fr, fg, fb);
    pushMatrix();
    translate(displayX,displayY,Z);
    box(W,H,D);
    translate(-displayX,-displayY,-Z);
    popMatrix();
//    line(0,Y,W,Y);
//    strokeWeight(1);
//    stroke(255);
//    line(X+W,0,X+W,H);
  }
  
  public void moveShape() {
    X += velocity.x;
    Y += velocity.y;
    displayX += velocity.x;
    displayY += velocity.y;
    redrawShape();
  }
  
  public void setMass() {
    mass = (W*H*D) * density;
  }
  
  public void setDensity() {
    density = 1.0;
  }
  
  public void setMovable(boolean b) {
    isMovable = b; 
  }

}
