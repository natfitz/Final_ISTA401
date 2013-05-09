/* A TUIO implementation of Mr. Doob's Harmony web app */

import TUIO.*;

TuioProcessing tuioClient;

//ArrayList history = new ArrayList();
ArrayList curHist = new ArrayList();
ArrayList lineHist = new ArrayList();
float thresh = 100;
Vector<TuioCursor> cursors;

void setup(){
  size(500,500);
  background(255);
  stroke(0,50);
  smooth();
  tuioClient  = new TuioProcessing(this);
  cursors = new Vector<TuioCursor>();
}
 
 
void draw(){
  background(255); 
  
  drawWeb();
  drawPersist();
   //line(50, 50, 250, 250);
   //println(lineHist.size());
 //  background(255);
   //println(curHist.size());
 /*
 
   if(curHist.size()>500){
     stroke(0,0,0,50);
   }
     if(curHist.size()>1000){
     stroke(255,0,0,50);
   }
   if(curHist.size()>1500){
     stroke(0,0,255,50);
   }
   if(curHist.size()>2000){
     stroke(0,255,0,50);
   } 
     
   //A means to reset the frame, could be better
   if (curHist.size()>2500){
     stroke(0,0,0,50);
     background(255);
     curHist.clear(); 
   }
   */
}
 
void drawWeb(){
   //Vector tuioCursorList = tuioClient.getTuioCursors();
   for (int i=0;i<cursors.size();i++) {
     TuioCursor tcur = (TuioCursor)cursors.elementAt(i);
     Vector pointList = tcur.getPath();
     float curX = tcur.getScreenX(width);
     float curY = tcur.getScreenY(height);
     PVector curD = new PVector(curX,curY);
     curHist.add(0,curD);
     
      for (int p=0; p<curHist.size(); p++){
    PVector curV = (PVector) curHist.get(p);
    float linkChance = p/curHist.size() + curD.dist(curV)/thresh;
    if (linkChance < random(0.4))  
    lineHist.add(new Line(curD.x,curD.y,curV.x,curV.y));
  }
}

   }
   
   void drawPersist(){
     for (int i = 0; i < lineHist.size(); i++){
     Line var = (Line) lineHist.get(i);
     var.drawLine();
     } 
     
     
   }
   
// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  //println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  //println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle() +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  cursors.add(tcur);
 // println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
 //println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
   //       +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  cursors.remove(tcur);
 // println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  //redraw();
}
