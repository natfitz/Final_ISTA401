import java.util.*;
import TUIO.*;

TuioProcessing tuioClient;

//Line structures
ArrayList curHist;
ArrayList lineHist;
float thresh = 150;

// The list of all the shapes in the simulation
ArrayList<Shape> shapes;

ArrayList<Shape> UIShapes;

ArrayList<Shape> toRemoveList;

// The list of all the current cursors
Vector<TuioCursor> cursors;

// Collision Counter
int cc = 0;

// Random integers to represent 3d and 2d
final int _3D = 3853;
final int _2D = 1092;
int VIEWING_MODE = _2D; // Default is set to 3D rendering

// Size of each square
int SQUARE_SIZE = 75;

int W = 1000; // The width of the left Section
int H = 700; // The height of the left Section

// The vector that handles amount that gravity pulls
float maxGravity = 0.8;
PVector GRAVITY = new PVector(0.0, 0.25);

boolean gravityOn = false;
boolean collisionsOn = true;
boolean frictionOn = false;

boolean breakCursorOn = false;
boolean drawLinesOn = false;

float lineDepth = 0.0;

// The elasticity of the 4 walls
float TOP_BOUNCE_BACK = -1.00;
float BOTTOM_BOUNCE_BACK = -0.95;
float LEFT_BOUNCE_BACK = -0.95;
float RIGHT_BOUNCE_BACK = -0.95;
float GROUND_FRICTION = 0.0075;

// Section lines
float middleLine = W * .70;

// Slider Bounds
float sliderLeftBound = 775;
float sliderRightBound = 925;
float slider1Y = 50;
float slider2Y = 125;
float slider3Y = 200;
float slider4Y = 275;

// Shapes to represent the edges of the hoop
Rect_3D leftHoop;
Rect_3D rightHoop;

// All the shapes
Circle cir1;
Rectangle cir2;
Rectangle cir3;

Rect_3D rect3D;
Rect_3D rect3D1;
Rect_3D rect3D2;
Rect_3D rect3D3;

Rect_3D slider1;
Rect_3D slider2;
Rect_3D slider3;
Rect_3D slider4;

Rect_3D button1;
Rect_3D button2;
Rect_3D button3;
Rect_3D button4;
Rect_3D button5;
Rect_3D button6;
Rect_3D button7;
Rect_3D button8;
Rect_3D button9;

void setup() {
  size(W, H, P3D);

  shapes = new ArrayList<Shape>();
  
  UIShapes = new ArrayList<Shape>();
  
  toRemoveList = new ArrayList<Shape>();

  tuioClient  = new TuioProcessing(this);

  cursors = new Vector<TuioCursor>();
  lineHist = new ArrayList();
  curHist =  new ArrayList();
// 3D Shapes
  slider1 = new Rect_3D((sliderLeftBound+((sliderRightBound-sliderLeftBound)/2)),slider1Y,0,25,30,25);
  slider1.setStroke(0,0,0);
  slider1.setFill(255, 255, 255);
  UIShapes.add(slider1);
  slider1.drawShape();
  
  slider2 = new Rect_3D((sliderLeftBound+((sliderRightBound-sliderLeftBound)/2)),slider2Y,0,25,30,25);
  slider2.setStroke(0,0,0);
  slider2.setFill(255, 255, 255);
  UIShapes.add(slider2);
  slider2.drawShape();
  
  slider3 = new Rect_3D((sliderLeftBound+((sliderRightBound-sliderLeftBound)/2)),slider3Y,0,25,30,25);
  slider3.setStroke(0,0,0);
  slider3.setFill(255, 255, 255);
  UIShapes.add(slider3);
  slider3.drawShape();
  
  slider4 = new Rect_3D((sliderLeftBound+((sliderRightBound-sliderLeftBound)/2)),slider4Y,0,25,30,25);
  slider4.setStroke(0,0,0);
  slider4.setFill(255, 255, 255);
  UIShapes.add(slider4);
  slider4.drawShape();
  
  button7 = new Rect_3D(sliderLeftBound + 200 -25,500,0,60,40,30);
  button7.setStroke(0,0,0);
  button7.setFill(255, 255, 255);
  button7.isButton = true;
  UIShapes.add(button7);
  button7.drawShape();
  
  button8 = new Rect_3D(sliderLeftBound + 200 -25,575,0,60,40,30);
  button8.setStroke(0,0,0);
  button8.setFill(255, 255, 255);
  button8.isButton = true;
  UIShapes.add(button8);
  button8.drawShape();
  
  button9 = new Rect_3D(sliderLeftBound + 200 -25,650,0,60,40,30);
  button9.setStroke(0,0,0);
  button9.setFill(255, 255, 255);
  button9.isButton = true;
  UIShapes.add(button9);
  button9.drawShape();
  
  button1 = new Rect_3D(sliderLeftBound -25,500,0,60,40,30);
  button1.setStroke(0,0,0);
  button1.setFill(255, 255, 255);
  button1.isButton = true;
  UIShapes.add(button1);
  button1.drawShape();
  
  button2 = new Rect_3D(sliderLeftBound + 100 -25,500,0,60,40,30);
  button2.setStroke(0,0,0);
  button2.setFill(255, 255, 255);
  button2.isButton = true;
  UIShapes.add(button2);
  button2.drawShape();
  
  button3 = new Rect_3D(sliderLeftBound -25,575,0,60,40,30);
  button3.setStroke(0,0,0);
  button3.setFill(255, 255, 255);
  button3.isButton = true;
  UIShapes.add(button3);
  button3.drawShape();
  
  button4 = new Rect_3D(sliderLeftBound -25 + 100,575,0,60,40,30);
  button4.setStroke(0,0,0);
  button4.setFill(255, 255, 255);
  button4.isButton = true;
  UIShapes.add(button4);
  button4.drawShape();
  
  button5 = new Rect_3D(sliderLeftBound -25,650,0,60,40,30);
  button5.setStroke(0,0,0);
  button5.setFill(255, 255, 255);
  button5.isButton = true;
  UIShapes.add(button5);
  button5.drawShape();
  
  button6 = new Rect_3D(sliderLeftBound + 100 -25,650,0,60,40,30);
  button6.setStroke(0,0,0);
  button6.setFill(255, 255, 255);
  button6.isButton = true;
  UIShapes.add(button6);
  button6.drawShape();

  rect3D = new Rect_3D(150,0,0,SQUARE_SIZE,SQUARE_SIZE,SQUARE_SIZE);
  rect3D.setStroke(0,0,0);
  rect3D.setFill(255, 0, 0);
  shapes.add(rect3D);
  rect3D.drawShape();
  
  rect3D1 = new Rect_3D(500,500,0,SQUARE_SIZE,SQUARE_SIZE,SQUARE_SIZE);
  rect3D1.setStroke(0,0,0);
  rect3D1.setFill(0, 255, 0);
  shapes.add(rect3D1);
  rect3D1.drawShape();
  
  rect3D2 = new Rect_3D(700,150,0,SQUARE_SIZE,SQUARE_SIZE,SQUARE_SIZE);
  rect3D2.setStroke(0,0,0);
  rect3D2.setFill(0, 255, 255);
  shapes.add(rect3D2);
  rect3D2.drawShape();
  
  rect3D3 = new Rect_3D(400,100,0,SQUARE_SIZE,SQUARE_SIZE,SQUARE_SIZE);
  rect3D3.setStroke(0,0,0);
  rect3D3.setFill(255, 255, 0);
  shapes.add(rect3D3);
  rect3D3.drawShape();
  

//  leftHoop = new Rect_3D(200, 400, 0, 60, 400, 60);
//  leftHoop.setStroke(0,0,0);  
//  leftHoop.setFill(255, 255, 255);
//  leftHoop.setMovable(false);
//  shapes.add(leftHoop);
//  leftHoop.drawShape();
//  
//  rightHoop = new Rect_3D(500, 300, 0, 400, 60, 60);
//  rightHoop.setStroke(0,0,0);  
//  rightHoop.setFill(255, 255, 255);
//  rightHoop.setMovable(false);
//  shapes.add(rightHoop);
//  rightHoop.drawShape();

  if(VIEWING_MODE == _2D)
    go2D();
  smooth();
}

int[] backrgb = new int[3];

void functionSlider1() {
  textSize(18);
  fill(255);
  text("Change Square Size", sliderLeftBound,slider1Y - 25);
  stroke(255);
  line(sliderLeftBound + 12,slider1Y,sliderRightBound + 12,slider1Y);
  float length = (sliderLeftBound - sliderRightBound);
  float xpos = (sliderLeftBound - slider1.X);
  float percentage = xpos / length;
  for(int i = 0; i < shapes.size(); i++) {
    Shape s = shapes.get(i);
    if(!s.isCursor && s.isMovable) {
      if(VIEWING_MODE == _2D)
        s.scaleSize2D(percentage);
      else
        s.scaleSize(percentage);
    }
  }
}

void functionSlider2() {
  textSize(18);
  fill(255);
  text("Change Gravity", sliderLeftBound,slider2Y - 25);
  stroke(255);
  line(sliderLeftBound + 12,slider2Y,sliderRightBound + 12,slider2Y);
  float length = (sliderLeftBound - sliderRightBound);
  float xpos = (sliderLeftBound - slider2.X);
  float percentage = xpos / length;
  GRAVITY.y = maxGravity * percentage;
}

void functionSlider3() {
  textSize(18);
  fill(255);
  text("Change Elasticity", sliderLeftBound,slider3Y - 25);
  stroke(255);
  line(sliderLeftBound + 12,slider3Y,sliderRightBound + 12,slider3Y);
  float length = (sliderLeftBound - sliderRightBound);
  float xpos = (sliderLeftBound - slider3.X);
  float percentage = xpos / length;
  BOTTOM_BOUNCE_BACK = -1 * (percentage + .35);
}

void functionSlider4() {
  textSize(18);
  fill(255);
  text("Move Lines", sliderLeftBound,slider4Y - 25);
  stroke(255);
  line(sliderLeftBound + 12,slider4Y,sliderRightBound + 12,slider4Y);
  float length = (sliderLeftBound - sliderRightBound);
  float xpos = (sliderLeftBound - slider4.X);
  float percentage = xpos / length;
  if(percentage > .5) {
    lineDepth = (percentage - .5) * 100;
  }
  else if (percentage < .5) {
    lineDepth = (.5 - percentage) * -100;
  }
  
}

// Toggle
void functionButton1() {
  toggleCollisions();
}

// Toggle
void functionButton2() {
  toggleGravity();
}

// Toggle
void functionButton3() {
  toggleFriction();
}

// Press
void functionButton4() {
  print("X");
  jumble();
  print("X5");
}

// Press
void functionButton5() {
  breakSquares();
}

// Toggle
void functionButton6() {
  TwoD_ThreeD();
}

// Press
void functionButton7() {
  setup();
}

// Press
void functionButton8() {
  breakCursorOn = !breakCursorOn;
}

// Press
void functionButton9() {
  drawLinesOn = !drawLinesOn;
  if(!drawLinesOn) {
    lineHist.clear();
    curHist.clear();
  }
}

void drawButton1() {
  textSize(18);
  fill(255);
  text("Collision", sliderLeftBound -25 - 30,475);
  fill(0);
  if(collisionsOn)
    text("ON!", sliderLeftBound -25 - 30,500,30);
  else
    text("OFF!", sliderLeftBound -25 - 30,500,30);
}

void drawButton2() {
  textSize(18);
  fill(255);
  text("Gravity", sliderLeftBound + 100 -25 - 30,475);
  fill(0);
  if(gravityOn)
    text("ON!", sliderLeftBound + 100 -25 - 30,500,30);
  else
    text("OFF!", sliderLeftBound + 100 -25 - 30 - 7,500,30);
}

void drawButton3() {
  textSize(18);
  fill(255);
  text("Friction", sliderLeftBound -25 - 30,550);
  fill(0);
  if(frictionOn)
    text("ON!", sliderLeftBound -25 - 30,575,30);
  else
    text("OFF!", sliderLeftBound -25 - 30,575,30);
}

void drawButton4() {
  textSize(18);
  fill(255);
    text("Jumble", sliderLeftBound -25 + 100 - 30,550);
  fill(0);
  if(VIEWING_MODE == _2D)
    text("Press", sliderLeftBound -25 + 100 - 30 - 10,575,30);
  else
    text("Press", sliderLeftBound -25 + 100 - 30,575,30);
}

void drawButton5() {
  textSize(18);
  fill(255);
  text("Break", sliderLeftBound -25 - 30,625);
  fill(0);
  if(VIEWING_MODE == _2D)
    text("Press", sliderLeftBound -25 - 30 - 7 ,650 - 3,30);
  else
    text("Press", sliderLeftBound -25 - 30,650,30);
}

void drawButton6() {
  textSize(18);
  fill(255);
  text("View", sliderLeftBound -25 + 100 - 30,625);
  fill(0);
  if(VIEWING_MODE == _2D)
    text("2D", sliderLeftBound -25 + 100 - 30,650 -5,30);
  else
    text("3D", sliderLeftBound -25 + 100 - 30,650,30);
}

void drawButton7() {
  textSize(18);
  fill(255);
  text("Reset", sliderLeftBound + 175 -25, 475);
  fill(0);
  if(VIEWING_MODE == _2D)
    text("Press", sliderLeftBound  + 175 - 25 - 18,500,30);
  else
    text("Press", sliderLeftBound + 175-25 - 12,500+5,30);
}

void drawButton8() {
  textSize(18);
  fill(255);
  text("Break Mode", sliderLeftBound  + 175 -25, 550);
  fill(0);
  if(breakCursorOn) {
    if(VIEWING_MODE == _2D)
      text("On", sliderLeftBound + 175 -25,575,30);
    else
      text("On", sliderLeftBound  + 175 -25,575,30);
  }
  else {
    if(VIEWING_MODE == _2D)
      text("Off", sliderLeftBound + 175 -25,575,30);
    else
      text("Off", sliderLeftBound  + 175 -25,575,30);
  }
}

void drawButton9() {
  textSize(18);
  fill(255);
  text("Lines", sliderLeftBound + 175 -25, 625);
  fill(0);
  if(drawLinesOn) {
    if(VIEWING_MODE == _2D)
      text("On", sliderLeftBound  + 175 -25,650+3,30);
    else
      text("On", sliderLeftBound  + 175 -25,650+5,30);
  }
  else {
    if(VIEWING_MODE == _2D)
      text("Off", sliderLeftBound  + 175 -25,650+3,30);
    else
      text("Off", sliderLeftBound  + 175 -25,650+5,30);
  }
}

void draw() {
  // Make sure to clear the screen each time before you draw
  background(backrgb[0],backrgb[1],backrgb[2]);
  pointLight(255, 255, 255, W/2, H/2, 600);
  
  if(drawLinesOn) {
    drawWeb();
    drawPersist();
  }
  
  // General Collision Detection
  // Loops through all unique shape pairings to check if there is a collision
  if(collisionsOn) {
    for (int i = 0; i < shapes.size(); i++) {
      for (int j = i + 1; j < shapes.size(); j++) {
        if (isTouching(shapes.get(i), shapes.get(j)) && (!shapes.get(i).isCursor && !shapes.get(j).isCursor)) {
          cc++; // Collion counter
//          backrgb[0] = (int)random(256);
//          backrgb[1] = (int)random(256);
//          backrgb[2] = (int)random(256);
          handleCollision(shapes.get(i), shapes.get(j));
        }
      }
    }
  }
  
  stroke(255);
  line(middleLine,0,middleLine,H);
  
  // Display the collion counter
  textSize(48);
  text(cc+"",5,50);

  noFill();
  stroke(255);
  strokeWeight(4);
  
  for(int i = 0; i < UIShapes.size(); i++) {
    Shape cir = UIShapes.get(i);
    // If the shapse is held by a cursor
    if (cir.cursor != null && !cir.isButton) {
      // If this is the first time I have grabbed it
      if (cir.x_dif == 0) {
        // I set the differences so the shape will stay in a relative space
        // to the cursor and I stop the shape from moving
        cir.setDifs(cir.X - cir.cursor.getX()*W, cir.Y - cir.cursor.getY()*H);
        cir.velocity.x = 0.0;
        cir.velocity.y = 0.0;
      }

      // The check is for some bug that would happen every so often
      if (cir.cursor != null) {
        // Move the shape with the cursor
        cir.X = cir.cursor.getX()*W + cir.x_dif;
        if(cir.X < sliderLeftBound)
          cir.X = sliderLeftBound;
        else if(cir.X > sliderRightBound)
          cir.X = sliderRightBound;
        // Redraw it so it is visible
        cir.redrawShape();
      }
    }
    cir.drawShape();
  }
  
  // Process the sliders
  functionSlider1();
  functionSlider2();
  functionSlider3();
  functionSlider4();
  
  // Draw the buttons
  drawButton1();
  drawButton2();
  drawButton3();
  drawButton4();
  drawButton5();
  drawButton6();
  drawButton7();
  drawButton8();
  drawButton9();

  // Show where the cursors are
  trackCursors();
  fill(255);
  noStroke();

  // Looping through all shapes
  for (int i = 0; i < shapes.size(); i++) {
    Shape cir = shapes.get(i);
    // Check speeds and limit speeds
    if (cir.velocity.x > 50.0)
      cir.velocity.x = 50.0;
    if (cir.velocity.y > 50.0)
      cir.velocity.y = 50.0;
    if (cir.velocity.x < -50.0)
      cir.velocity.x = -50.0;
    if (cir.velocity.y < -50.0)
      cir.velocity.y = -50.0;

    // If the shapse is held by a cursor
    if (cir.cursor != null) {
      // If this is the first time I have grabbed it
      if (cir.x_dif == 0) {
        // I set the differences so the shape will stay in a relative space
        // to the cursor and I stop the shape from moving
        cir.setDifs(cir.X - cir.cursor.getX()*W, cir.Y - cir.cursor.getY()*H);
        cir.velocity.x = 0.0;
        cir.velocity.y = 0.0;
      }

      // Use the cursor speed to get speed and direction for when you release the shape
      cir.velocity.x = cir.cursor.getXSpeed()*5;
      cir.velocity.y = cir.cursor.getYSpeed()*5;
      
      // Make sure it is a shape that is allowed to move about freely
      if(!cir.isMovable) {
        cir.velocity.x = 0.0;
        cir.velocity.y = 0.0;
      }

      // The check is for some bug that would happen every so often
      if (cir.cursor != null) {
        // Move the shape with the cursor
        cir.X = cir.cursor.getX()*W + cir.x_dif;
        cir.Y = cir.cursor.getY()*H + cir.y_dif;
        // Redraw it so it is visible
        cir.redrawShape();
      }
    }
    else {
      // Simulate gravity
      if (gravityOn && cir.isMovable)
        cir.velocity.add(GRAVITY);

      /// Not sure about this at the moment
      cir.outsideShape.x = cir.X;
      cir.outsideShape.y = cir.Y;
      
      // Will move the shape as well as call a redraw
      cir.moveShape();
      
      // Top bound
      if (cir.Y <= 0) {
        cir.Y = 0;
        cir.velocity.y *= TOP_BOUNCE_BACK;
      }
      // Bottom bound
      if ((cir.Y + cir.H) >= H) {
        cir.Y = H - cir.H;
        cir.velocity.y *= BOTTOM_BOUNCE_BACK;
      }
      // Right bound
      if ((cir.X + cir.W) >= middleLine) {
        cir.X = middleLine - cir.W;
        cir.velocity.x *= RIGHT_BOUNCE_BACK;
        //                GRAVITY.x *= -1;
      }
      // Left bound
      if (cir.X <= 0) {
        cir.X = 0;
        cir.velocity.x *= LEFT_BOUNCE_BACK;
        //                GRAVITY.x *= -1;
      }
      
      // Ground static
      // Make sure it is supposed to be on
      if (frictionOn) {
        // If gravity is on I only want friction on the bottom of the screen
        if (gravityOn) {
          // If it is touching the bottom and 
          // the second check being at -1 is for the slight fluctuation in velocity when a shape is on the bottom
          if ((cir.Y + cir.H) >= H && cir.velocity.y >= -1.0) {
            if (cir.velocity.x > 0)
              cir.velocity.x -= GROUND_FRICTION;
            else if (cir.velocity.x < 0)
              cir.velocity.x += GROUND_FRICTION;
          }
        }
        // If gravity is off then I want friction everywhere
        else {
          if (cir.velocity.x > 0.0)
            cir.velocity.x -= GROUND_FRICTION;
          else if (cir.velocity.x < 0.0)
            cir.velocity.x += GROUND_FRICTION;
          if (cir.velocity.y > 0.0)
            cir.velocity.y -= GROUND_FRICTION;
          else if (cir.velocity.y < 0.0)
            cir.velocity.y += GROUND_FRICTION;
        }
      }
    }
  }
  // Remove cursors while not looping over them in the main draw loop
  for(int i = 0; i < toRemoveList.size(); i++) {
    Shape s = toRemoveList.get(i);
    if(shapes.contains(s))
      shapes.remove(s);
    else if(UIShapes.contains(s))
      UIShapes.remove(s);
  }
}

private void handleCollision(Shape s1, Shape s2) {
  if(s1.isMovable && !s2.isMovable) {
    int side = detectSide(s1,s2);
    if(side == HORIZONTAL) {
      s1.velocity.y *= -1.0;
    }
    else if(side == VERTICAL) {
      s1.velocity.x *= -1.0;
    }
    else if(side == CORNERHIT) {
      s1.velocity.x *= -1.0;
      s1.velocity.y *= -1.0;
    }
  }
  else if(s2.isMovable && !s1.isMovable) {
    int side = detectSide(s2,s1);
    if(side == HORIZONTAL) {
    }
    else if(side == VERTICAL) {
      s2.velocity.x *= -1.0;
    }
    else if(side == CORNERHIT) {
      s2.velocity.x *= -1.0;
      s2.velocity.y *= -1.0;
    }
  }
  // Both movable
  else {
    int side = detectSide(s1,s2);
    if(side == HORIZONTAL) {
      println("HORIZONTAL");
      float temp = s1.velocity.y;
      s1.velocity.y = s2.velocity.y;
      s2.velocity.y = temp;
    }
    else if(side == VERTICAL) {
      println("VERTICAL");
      float temp = s1.velocity.x;
      s1.velocity.x = s2.velocity.x;
      s2.velocity.x = temp;
    }
    else if(side == CORNERHIT) {
      println("CORNERHIT");
      float temp = s1.velocity.x;
      s1.velocity.x = s2.velocity.x;
      s2.velocity.x = temp;
      temp = s1.velocity.y;
      s1.velocity.y = s2.velocity.y;
      s2.velocity.y = temp;
    }
  }
}

private final int HORIZONTAL = 1111;
private final int VERTICAL = 2222;
private final int CORNERHIT = 3333;
private final int FAIL_SIDE_DETECTION = -1234;

private int detectSide(Shape s, Shape r) {
  Shape S = s;
  Shape R = r;
  float rbottom = R.Y + R.H;
  float rright = R.X + R.W;
  float prerbottom = R.Y + R.H - R.velocity.y;
  float prerright = R.X + R.W - R.velocity.x;
  float xs = S.velocity.x;
  float ys = S.velocity.y;
  float xpos = S.X;
  float ypos = S.Y;
  // If they are heading in the same direction
  // We can pick which one is moving fastest to be the one the is "colliding" with the other one
  if(((xs > 0 && R.velocity.x > 0) ||  (xs < 0 && R.velocity.x < 0)) && ((ys > 0 && R.velocity.y > 0) ||  (ys < 0 && R.velocity.y < 0))) {
      if(abs(xs * ys) < abs(R.velocity.x * R.velocity.y)) {
        Shape temp = S;
        S = R;
        R = temp;
        rbottom = R.Y + R.H;
        rright = R.X + R.W;
        prerbottom = R.Y + R.H - R.velocity.y;
        prerright = R.X + R.W - R.velocity.x;
        xs = S.velocity.x;
        ys = S.velocity.y;
        xpos = S.X;
        ypos = S.Y;
        println("FLIP COLLISIOSNS");
      }
  }
  float xright = S.X + S.W;
  float ybottom = S.Y + S.H;
  float preXpos = S.X - xs;
  float preYpos = S.Y - ys;
  float preXright = xright - xs;
  float preYbottom = xright - ys;
  
//  println(
  // Case 1 (+,+)
  if(xs > 0 && ys > 0) {
    println("(+,+)");
    println("              " + cc + "         *************");
    println("XPOS: " + xpos + ", XRIGHT: " + xright + ", XSPEED: " + xs);
    println("RPOS: " + R.X + ", RSPEED: " + R.velocity.x);
    println("PREXPOS: " + preXpos + ", RRIGHT: " + rright + ", PRERRIGHT: " + prerright);
    println("YPOS: " + ypos + ", YBOTTOM: " + ybottom+ ", YSPEED: " + ys);
    println("RPOS: " + R.Y + ", RSPEED: " + R.velocity.y);
    println("PREYPOS: " + preYpos + ", RBOTTOM: " + rbottom + ", PRERBOTTOM: " + prerbottom);
    if(preXright > (prerright - R.W))
      return HORIZONTAL;
    else if(preYbottom > (R.Y-R.velocity.y))
      return VERTICAL;
    else {
      if(abs(xright - R.X) < abs(ybottom - R.Y))
        return VERTICAL;
      else if(abs(xright - R.X) > abs(ybottom - R.Y))
        return HORIZONTAL;
      else 
        return CORNERHIT;
    }
  }
  // Case 2 (+,-)
  else if(xs > 0 && ys < 0) {
    println("(+,-)");
    println("              " + cc + "         *************");
   println("XPOS: " + xpos + ", XRIGHT: " + xright + ", XSPEED: " + xs);
    println("RPOS: " + R.X + ", RSPEED: " + R.velocity.x);
    println("PREXPOS: " + preXpos + ", RRIGHT: " + rright + ", PRERRIGHT: " + prerright);
    println("YPOS: " + ypos + ", YBOTTOM: " + ybottom+ ", YSPEED: " + ys);
    println("RPOS: " + R.Y + ", RSPEED: " + R.velocity.y);
    println("PREYPOS: " + preYpos + ", RBOTTOM: " + rbottom + ", PRERBOTTOM: " + prerbottom);
    if(preXright > (R.X - R.velocity.x))
      return HORIZONTAL;
    else if(preYpos < (rbottom-R.velocity.y))
      return VERTICAL;
    else {
      if(abs(xright - R.X) < abs(ypos - rbottom))
        return VERTICAL;
      else if(abs(xright - R.X) > abs(ypos - rbottom))
        return 1;
      else 
        return 3;
    }
  }
  // Case 3 (-,+)
  else if(xs < 0 && ys > 0) {
    println("(-,+)");
    println("              " + cc + "         *************");
    println("XPOS: " + xpos + ", XRIGHT: " + xright + ", XSPEED: " + xs);
    println("RPOS: " + R.X + ", RSPEED: " + R.velocity.x);
    println("PREXPOS: " + preXpos + ", RRIGHT: " + rright + ", PRERRIGHT: " + prerright);
    println("YPOS: " + ypos + ", YBOTTOM: " + ybottom+ ", YSPEED: " + ys);
    println("RPOS: " + R.Y + ", RSPEED: " + R.velocity.y);
    println("PREYPOS: " + preYpos + ", RBOTTOM: " + rbottom + ", PRERBOTTOM: " + prerbottom);
    if(preXpos < prerright)
      return HORIZONTAL;
    else if(preYbottom > (R.Y-R.velocity.y))
      return VERTICAL;
    else {
      if(abs(xpos - rright) < abs(ybottom - R.Y))
        return VERTICAL;
      else if(abs(xpos - rright) > abs(ybottom - R.Y))
        return HORIZONTAL;
      else 
        return CORNERHIT;
    }
  }
  // Case 4 (-,-)
  else if(xs < 0 && ys < 0) {
    println("(-,-)");
    println("              " + cc + "         *************");
    println("XPOS: " + xpos + ", XRIGHT: " + xright + ", XSPEED: " + xs);
    println("RPOS: " + R.X + ", RSPEED: " + R.velocity.x);
    println("PREXPOS: " + preXpos + ", RRIGHT: " + rright + ", PRERRIGHT: " + prerright);
    println("YPOS: " + ypos + ", YBOTTOM: " + ybottom+ ", YSPEED: " + ys);
    println("RPOS: " + R.Y + ", RSPEED: " + R.velocity.y);
    println("PREYPOS: " + preYpos + ", RBOTTOM: " + rbottom + ", PRERBOTTOM: " + prerbottom);
    if(preXpos < prerright) {
      println("1;");
      return HORIZONTAL;
    }
    else if(preYpos < prerbottom)
      return VERTICAL;
    else {
      if(abs(xpos - rright) < abs(ypos - rbottom))
        return VERTICAL;
      else if(abs(xpos - rright) > abs(ypos - rbottom)) {
        println("2;");
        return HORIZONTAL;
      }
      else 
        return CORNERHIT;
    }
  }
  // Case 5 (0,+) or (0,-)
  else if(xs == 0) {
    println("(0,+)");
    return HORIZONTAL;
  }
  // Case 6 (+,0) or (-,0)
  else if(ys == 0) {
    println("(+,0)");
    return VERTICAL;
  }
  return FAIL_SIDE_DETECTION;
}

// Show where all cursors are on the screen with a circle
private void trackCursors() {
  for(int i = 0; i < shapes.size(); i++) {
    Shape cir = shapes.get(i);
    if(cir.isCursor && cir.cursor != null) {
    TuioCursor c = cir.cursor;
    TuioPoint p = c.getPosition();
    cir.X = p.getX()*W;
    cir.Y = p.getY()*H;
    cir.drawShape();
    }
  }
}

// To tell if a cursor is inside of a shape
private boolean isInsideShape(TuioCursor cur, Shape shape) {
  TuioPoint p = cur.getPosition();
  // In X bound
  if (p.getX()*W >= shape.X && p.getX()*W <= shape.X + shape.W) {
    if (p.getY()*H >= shape.Y && p.getY()*H <= shape.Y + shape.H) {
      return true;
    }
  }
  return false;
}

// To tell if two shapes are in contact with each other
private boolean isTouching(Shape cir, Shape rim) {
  float lx1 = rim.X;
  float lx2 = (rim.X + rim.W);
  float lx3 = cir.X;
  float lx4 = (cir.X + cir.W);
  float ly1 = rim.Y;
  float ly2 = (rim.Y + rim.H);
  float ly3 = cir.Y;
  float ly4 = (cir.Y + cir.H);

  if (lx3 <= lx2 && lx4 >= lx1) {
    if (ly3 <= ly2 && ly4 >= ly1) {
      return true;
    }
  }
  return false;
}

// Toggles gravity on and off and randomizes the vector when it is turned back on
private void toggleGravity() {
  gravityOn = !gravityOn;
}

// Toggles ball collisions on and off and randomizes the value when it is turned back on
private void toggleCollisions() {
  collisionsOn = !collisionsOn;
}

// Toggles friction on and off and randomizes the value when it is turned back on
private void toggleFriction() {
  frictionOn = !frictionOn;
}

// Sets the vector gravity to the given values
private void setGravity(float xg, float yg) {
  GRAVITY.x = xg;
  GRAVITY.y = yg;
}

// Adds a given mount to the global gravity vector
private void addGravity(float xg, float yg) {
  GRAVITY.x += xg;
  GRAVITY.y += yg;
}


// these callback methods are called whenever a TUIO event occurs

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  // Add the cursor to the local list
  cursors.add(tcur);
  // Set the cursor in the shape that the cursor is holding
  for (Shape cir : shapes) {
    if (isInsideShape(tcur, cir)) {
      cir.cursor = tcur;
      if(breakCursorOn) {
        breakSquares(cir);
        jumble(cir);
      }
      break;
    }
  }
  for(int i = 0; i < UIShapes.size(); i++) {
    Shape cir = UIShapes.get(i);
    if (isInsideShape(tcur, cir)) {
      cir.cursor = tcur;
      if(cir.equals(button1)) 
        functionButton1();
      else if(cir.equals(button2)) 
        functionButton2();
      else if(cir.equals(button3))
        functionButton3();
      else if(cir.equals(button4))
        functionButton4();
      else if(cir.equals(button5))
        functionButton5();
      else if(cir.equals(button6))
        functionButton6();
      else if(cir.equals(button7))
        functionButton7();
      else if(cir.equals(button8))
        functionButton8();
      else if(cir.equals(button9))
        functionButton9();
      print("X6");
      break;
    }
  }
  print("X7");
  Rect_3D temp = null;
  if(VIEWING_MODE == _3D)
    temp = new Rect_3D(tcur.getX()*W, tcur.getY()*H,0.0,20,20,20);
  else
    temp = new Rect_3D(tcur.getX()*W, tcur.getY()*H,0.0,20,20,0);
  temp.setStroke(0,0,0);
  temp.setFill(255, 255, 255);
  temp.isMovable = false;
  temp.isCursor = true;
  temp.cursor = tcur;
  shapes.add(temp);
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()*W+" "+tcur.getY()*H);
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  //  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
  //          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  // Remove that cursor from the local list
  cursors.remove(tcur);
  // Remove the cursor from the shape
  Shape toRemove = null;
  for (Shape cir : shapes) {
    if (tcur.equals(cir.cursor) && cir.isCursor) {
      toRemove = cir;
      break;
    }
  }
  for (Shape cir : UIShapes) {
    if (tcur.equals(cir.cursor) && cir.isCursor) {
      toRemove = cir;
      break;
    }
  }
    if(toRemove != null)
      toRemoveList.add(toRemove);
  for (Shape cir : shapes) {
    if (tcur.equals(cir.cursor)) {
      cir.cursor = null;
      cir.setDifs(0, 0);
    }
  }
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}

// Shakes the moving shapes around so jumbles them up
private void jumble() {
  print("X1");
  for(Shape s : shapes) {
    if(s.isMovable) {
      s.velocity.x = random(7,12);
      if((int)random(1,3) == 1)
        s.velocity.x *= -1.0;
      s.velocity.y = random(7,12);
      if((int)random(1,3) == 1)
        s.velocity.y *= -1.0;
    }
  }
  print("X2");
  // Flash the screen for visual effect

  print("X3");
}

// Shakes the moving shape around so jumbles them up
private void jumble(Shape s) {
    if(s.isMovable) {
      s.velocity.x = random(7,12);
      if((int)random(1,3) == 1)
        s.velocity.x *= -1.0;
      s.velocity.y = random(7,12);
      if((int)random(1,3) == 1)
        s.velocity.y *= -1.0;
    }
}

private void TwoD_ThreeD() {
  if(VIEWING_MODE == _3D) {
    VIEWING_MODE = _2D;
    go2D();
  }
  else {
    VIEWING_MODE = _3D;
    go3D();
  }
}

private void go2D() {
  for(Shape s : shapes) {
    if(s instanceof Rect_3D) {
        s.saveD = s.D;
        s.D = 0.0;
    }
  }
  for(Shape s : UIShapes) {
    if(s instanceof Rect_3D) {
        s.saveD = s.D;
        s.D = 0.0;
    }
  }
}

private void go3D() {
  for(Shape s : shapes) {
    if(s instanceof Rect_3D) {
        s.D = s.saveD;
    }
  }
  for(Shape s : UIShapes) {
    if(s instanceof Rect_3D) {
        s.D = s.saveD;
    }
  }
}
private void changeSquareSize() {
  if(key == '[') {
    for(Shape s : shapes) {
      if(s.isMovable) {
        if(VIEWING_MODE == _3D)
          s.changeSize(-2);
        else
          s.changeSize2D(-2); 
      }
    }
  }
  else {
    for(Shape s : shapes) {
      if(s.isMovable) {
        if(VIEWING_MODE == _3D)
          s.changeSize(2);
        else
          s.changeSize2D(2); 
      }
    }
  }
}

private void breakSquares(Shape s) {
   ArrayList<Shape> temp = new ArrayList<Shape>();
  Rect_3D rect = null;
    if(s.isMovable) {
      rect = new Rect_3D(s.X,s.Y,s.Z,(int)s.W/2,(int)s.H/2,(int)s.D/2);// Top Left
      rect.setStroke(0,0,0);
      rect.setFill(s.fr, s.fg, s.fb);
//      rect.setFill((int)random(256), (int)random(256), (int)random(256));
//      rect.velocity = s.velocity;
      rect.isMovable = s.isMovable;
      rect.isCursor = s.isCursor;
      temp.add(rect); 
      rect = new Rect_3D(s.X + s.W/2,s.Y,s.Z,(int)s.W/2,(int)s.H/2,(int)s.D/2);// Top Right
      rect.setStroke(0,0,0);
      rect.setFill(s.fr, s.fg, s.fb);
//      rect.setFill((int)random(256), (int)random(256), (int)random(256));
//      rect.velocity = s.velocity;
      rect.isMovable = s.isMovable;
      rect.isCursor = s.isCursor;
      temp.add(rect); 
      rect = new Rect_3D(s.X,s.Y + s.H/2,s.Z,(int)s.W/2,(int)s.H/2,(int)s.D/2);// Bottom Left
      rect.setStroke(0,0,0);
      rect.setFill(s.fr, s.fg, s.fb);
//      rect.setFill((int)random(256), (int)random(256), (int)random(256));
//      rect.velocity = s.velocity;
      rect.isMovable = s.isMovable;
      rect.isCursor = s.isCursor;
      temp.add(rect); 
      rect = new Rect_3D(s.X + s.W/2,s.Y +s.H/2,s.Z,(int)s.W/2,(int)s.H/2,(int)s.D/2);// Bottom Right
      rect.setStroke(0,0,0);
      rect.setFill(s.fr, s.fg, s.fb);
//      rect.setFill((int)random(256), (int)random(256), (int)random(256));
//      rect.velocity = s.velocity;
      rect.isMovable = s.isMovable;
      rect.isCursor = s.isCursor;
      temp.add(rect);
      shapes.remove(s);
      shapes.addAll(temp);
    } 
}

private void breakSquares() {
  ArrayList<Shape> temp = new ArrayList<Shape>();
  Rect_3D rect = null;
  for(Shape s : shapes) {
    if(s.isMovable) {
      rect = new Rect_3D(s.X,s.Y,s.Z,(int)s.W/2,(int)s.H/2,(int)s.D/2);// Top Left
      rect.setStroke(0,0,0);
      rect.setFill(s.fr, s.fg, s.fb);
//      rect.setFill((int)random(256), (int)random(256), (int)random(256));
//      rect.velocity = s.velocity;
      rect.isMovable = s.isMovable;
      rect.isCursor = s.isCursor;
      temp.add(rect); 
      rect = new Rect_3D(s.X + s.W/2,s.Y,s.Z,(int)s.W/2,(int)s.H/2,(int)s.D/2);// Top Right
      rect.setStroke(0,0,0);
      rect.setFill(s.fr, s.fg, s.fb);
//      rect.setFill((int)random(256), (int)random(256), (int)random(256));
//      rect.velocity = s.velocity;
      rect.isMovable = s.isMovable;
      rect.isCursor = s.isCursor;
      temp.add(rect); 
      rect = new Rect_3D(s.X,s.Y + s.H/2,s.Z,(int)s.W/2,(int)s.H/2,(int)s.D/2);// Bottom Left
      rect.setStroke(0,0,0);
      rect.setFill(s.fr, s.fg, s.fb);
//      rect.setFill((int)random(256), (int)random(256), (int)random(256));
//      rect.velocity = s.velocity;
      rect.isMovable = s.isMovable;
      rect.isCursor = s.isCursor;
      temp.add(rect); 
      rect = new Rect_3D(s.X + s.W/2,s.Y +s.H/2,s.Z,(int)s.W/2,(int)s.H/2,(int)s.D/2);// Bottom Right
      rect.setStroke(0,0,0);
      rect.setFill(s.fr, s.fg, s.fb);
//      rect.setFill((int)random(256), (int)random(256), (int)random(256));
//      rect.velocity = s.velocity;
      rect.isMovable = s.isMovable;
      rect.isCursor = s.isCursor;
      temp.add(rect); 
    }
    else
      temp.add(s);
  }
  shapes = temp;
  jumble();
}

void keyPressed() {
  if (key == 'g') {
    toggleGravity();
  }
  else if (key == 'c') {
    toggleCollisions();
  }
  else if (key == 'f') {
    toggleFriction();
  }
  else if (key == 'j') {
    jumble();
  }
  else if (key == '3') {
    TwoD_ThreeD();
  }
  else if (key == 'b') {
    breakSquares();
  }
  else if (key == ']' || key == '[') {
    changeSquareSize();
  }
  else if (key == 'r') {
    setup();
    jumble();
  }
}


//Line drawing portion
void drawWeb(){
   //Vector tuioCursorList = tuioClient.getTuioCursors();
   strokeWeight(1);
   stroke(255, 50);
   
   
   for (int i = 0; i < shapes.size(); i++) {
    Shape cir = shapes.get(i);
   //  TuioCursor tcur = (TuioCursor)cursors.elementAt(i);
     //Vector pointList = tcur.getPath();
     
     if(!cir.isCursor){
     float curX = cir.X + (cir.W/2);
     float curY = cir.Y + (cir.H/2);
     PVector curD = new PVector(curX,curY);
     curHist.add(0,curD);
      for (int p=0; p<curHist.size(); p++){
    PVector curV = (PVector) curHist.get(p);
    float linkChance = 0;
    if(curD != null && curV != null) {
      linkChance = p/curHist.size() + curD.dist(curV)/thresh;
      if (linkChance < random(0.4))  
        lineHist.add(new Line(curD.x,curD.y,curV.x,curV.y,cir.fr,cir.fg,cir.fb));
    }
//    if(last > 30000)
//      lineHist.remove(0);
  
  }
}

   }
}
   void drawPersist(){
//     int last = lineHist.size();
//     while(last > 30000) {
//       if(!lineHist.isEmpty())
//        lineHist.remove(0);
//        last--;
//     }
//     last = curHist.size();
//     while(last > 10000) {
//        if(last > 0)
//          curHist.remove(last-1);
//        last--;
//     }
     for (int i = 0; i < lineHist.size(); i++){
     Line var = (Line) lineHist.get(i);
     if(var != null)
       var.drawLine(lineDepth);
     } 
     
     
   }
