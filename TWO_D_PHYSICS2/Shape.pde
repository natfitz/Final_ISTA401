public abstract class Shape {

  TuioCursor cursor;
  float W;
  float H;
  float D;
  float maxW;
  float maxH;
  float maxD;
  float X;
  float Y;
  float Z;
  float saveD;
  float x_dif;
  float y_dif;
  float displayX, displayY;
  PVector middle;
  int sr, sg, sb;
  int fr, fg, fb;
  int sw; // Stroke weight
  PShape shape;
  PVector velocity = new PVector(0, 0);
  float mass;
  float density;
  PVector outsideShape = new PVector(0, 0);
  int drawnShape;
  boolean isMovable = true;
  boolean isCursor = false;
  boolean isButton = false;
  

  public Shape() {
    cursor = null;
  }
  
  public abstract void redrawShape();
  public abstract void setMass();
  public abstract void setDensity();

  public void addX(float x) {
    this.X += x;
  }

  public void addY(float y) {
    this.Y += y;
  }

  public void drawShape() {
    shape.stroke(sr, sg, sb);
    if (sw == 0)
      shape.noStroke();
    else  
      shape.strokeWeight(sw);
    shape.fill(fr, fg, fb);
    shape(shape);
//    textSize(24);
//    fill(255);
//    text(this.X +"", this.X,this.Y+24);
  }

  public void setDifs(float x, float y) {
    x_dif = x;
    y_dif = y;
  }

  public void moveShape() {
    X += velocity.x;
    Y += velocity.y;
    redrawShape();
  }

  public void setStroke(int r, int g, int b) {
    sr = r;
    sg = g;
    sb = b;
  }

  public void setStrokeWeight(int weight) {
    sw = weight;
  }

  public void setFill(int r, int g, int b) {
    fr = r;
    fg = g;
    fb = b;
  }
  
  public void changeSize(int amount) {
    H += amount;
    W += amount;
    D += amount;
    if(H > 200)
      H = 200;
    if(W > 200)
      W = 200;
    if(D > 200)
      D = 200;
    if(H <= 2)
      H = 2;
    if(W <= 2)
      W = 2;
    if(D <= 2)
      D = 2;
  }
  public void changeSize2D(int amount) {
    H += amount;
    W += amount;
    saveD += amount;
    if(H > 200)
      H = 200;
    if(W > 200)
      W = 200;
    if(saveD > 200)
      saveD = 200;
    if(H <= 2)
      H = 2;
    if(W <= 2)
      W = 2;
    if(saveD <= 2)
      saveD = 2;
  }
  
  public void scaleSize(float scale) {
    H = maxH * scale;
    W = maxW * scale;
    D = maxD * scale;
  }
  
  public void scaleSize2D(float scale) {
    H = maxH * scale;
    W = maxW * scale;
    saveD = maxD * scale;
  }
}

