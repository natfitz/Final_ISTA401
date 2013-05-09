public class Line{
  
 float x1,x2,y1,y2; 
  
 public Line(float xval1, float yval1, float xval2, float yval2){
  x1 = xval1;
  y1 = yval1;
  x2 = xval2;
  y2 = yval2;
 } 
  
  public void drawLine(){
    line(x1, y1, x2, y2);
   //println(); 
  }
  
}
