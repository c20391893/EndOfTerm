class Line {
  
  //Positon, speed and acceleration
  float pos, v, a;
  
  Line(int h) {
  
    pos = h;
    v = 0.2;
    a = 0.1;
  }
  
  //Moves and accelerates the line
  void move() {
  
    pos += v;
    v += a;
  }
  
  //Draws the line
  void show() {
  
    line(-width/2, pos, width/2, pos);
  }
}
