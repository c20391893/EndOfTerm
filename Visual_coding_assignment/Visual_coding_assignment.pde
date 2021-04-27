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
  
  for (int i = 0; i < mySound.bufferSize() - 1; i++) {
    
    float angle = sin(i+a1)* 10;
    float angle2 = sin(i+a2)* 300;
    
    float x = sin(radians(i))*(500/angle);
    float y = cos(radians(i))*(500/angle);
    
    float x3 = sin(radians(i))*(500/angle);
    float y3 = cos(radians(i))*(500/angle);
    
    fill (100, 90);
    ellipse(x, y, mySound.left.get(i)*20, mySound.left.get(i)*10);
    
    fill ( 20, 100, 60);
    rect(x, y, mySound.left.get(i)*20, mySound.left.get(i)*10);
    
    fill ( 150, 50, 90);
    rect(x, y, mySound.right.get(i)*10, mySound.left.get(i)*10);
    
    
    fill( 150, 0, 70);
    rect(x3, y3, mySound.right.get(i)*10, mySound.right.get(i)*20);
  }
  a1 += 0.008;
  a2 += 0.04;
}
