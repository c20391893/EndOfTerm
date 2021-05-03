float a1;
float a2;

import ddf.minim.*;
import ddf.minim.signals.*;
Minim minim;
AudioPlayer mySound;


void setup () {
  fullScreen(P3D);
  noCursor();
  smooth();
  background (0);
  frameRate(50);

minim = new Minim(this);
mySound = minim.loadFile("Robert Miles - Children.mp3");
mySound.play();
}

void draw () {
  fill(0,50);
  noStroke();
  rect(0, 0, width, height);
  translate(width/2, height/2);
  
  for (int i = 1; i < mySound.bufferSize() - 1; i++) {
    
    float angle = sin(i+a1)* 10;
    float angle2 = sin(i+a2)* 10;
    
    float x = sin(radians(i))/(500/angle);
    float y = cos(radians(i))*(500/angle);
    
    float x2 = sin(radians(i))*(500/angle);
    float y2 = cos(radians(i))-(500/angle);
    
    float x3 = sin(radians(i))+(500/angle2);
    float y3 = sin(radians(i))/(500/angle);
      
    //Both vertical and horizontal lines the meet in the middle 
    fill (0, 150, 0);
    rect(x, y, mySound.right.get(i)*50, mySound.right.get(i)*50);
    
    fill ( 0, 150, 0);
    rect(x2, y3, mySound.right.get(i)*50, mySound.right.get(i)*50);
    
    fill ( 150, 0, 0);
    rect(x, y, mySound.left.get(i)*50, mySound.left.get(i)*50);
    
    fill( 150, 0, 0);
    rect(x2, y3,mySound.left.get(i)*50,mySound.left.get(i)*50);
   
   
   //The corners cross hatch line effect
   fill(150,0,0);
   ellipse(x3,y2,x3,mySound.right.get(i)*10);
   
   fill(0,150,0);
   ellipse(x3,y2,mySound.left.get(i)*10,y2);
   
  a1 += 1.000;
  a2 -= +0.05;
}
}
