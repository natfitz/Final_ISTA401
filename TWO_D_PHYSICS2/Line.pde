public class Line{
  
 float x1,x2,y1,y2;
 float r,g,b;
  
 public Line(float xval1, float yval1, float xval2, float yval2, int R, int G, int B){
  x1 = xval1;
  y1 = yval1;
  x2 = xval2;
  y2 = yval2;
  r = R;
  g = G;
  b = B;
 } 
  
  public void drawLine(float z){
    stroke(r,g,b,50);
    
    line(x1, y1,z, x2, y2,z);
  }
  
}
