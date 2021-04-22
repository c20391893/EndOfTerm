import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
AudioBuffer buffer;
AudioInput input;
AudioInput ai;
FFT fft;
float lerpedAverage = 0;

float[] lerpedBuffer;
float[] boxArrayX;
float[] boxArrayY;
float[] boxArraySpeed;
float x = 50;
float magnitude;
int widths = 100;
int heights = 40;
float speed = 50.0;
float factor;
float amplitude = 100;
float amplitude1 = 150;
float amplitude2 = 75;
float amplitude3 = 70;
float step_multiple = 5;
float step_multiple2 = 6;
float step_multiple3 = 7;
int h = 150;
float p = 4.5;
ArrayList<Line> l = new ArrayList<Line>();
int c = 255;
int dir = 1;
float[] peaks = new float[1024];
float[] last_peaks = new float[1024];
int total=50;
float rad1, rad2, rad3;
int which = 0;
float step = TWO_PI/340;
float min;


  
  
void setup()
  {
  size(1000, 1000,P3D);
  colorMode(HSB);
  minim = new Minim(this);
  player = minim.loadFile("Headhunterz - Dragonborn Part 3 (Da Tweekaz Remix).mp3", width);
  //ai = minim.getLineIn(Minim.MONO, width, 44100, 16);
  buffer = player.mix;
  input=minim.getLineIn();
fft= new FFT(input.bufferSize(),input.sampleRate());
 lerpedBuffer = new float[buffer.size()];
boxArrayX= new float[total];
 boxArrayY= new float[total];
 boxArraySpeed= new float[total];
 for(int j=0;j<total;j++)
 {
  boxArrayX[j]=random(0,width);
  boxArrayY[j]=random(0,height);
  boxArraySpeed[j]=random(2,5);
}
  }


  
void draw()

{

  background(0);
  float halfH = height / 2;
    if(which==0)
  {
   fill(255,0,255);
    //stroke(255);
    text("Press the numbers 1 through 5 to change visual",width/2-150,height/2);
  }
  if(which>0)
  {
   player.play();
  }
    
     
      
  
  

   if (which == 1)
  {
    colorMode(HSB,255);
    strokeWeight(1);
       for(int j=0;j<total;j++)
      {
        
        noStroke();
        fill(100,50,50);
       ellipse(boxArrayX[j],boxArrayY[j],10,10);
       boxArrayX[j]+=boxArraySpeed[j];
       if(boxArrayX[j]>width)
       {
           boxArrayX[j]=0;
  boxArrayY[j]=random(0,height);
  boxArraySpeed[j]=random(2,5);
      }
      }
    for (int i = 0; i < buffer.size(); i ++)
    {
      float sample = buffer.get(i) * halfH;
      stroke(map(i, 0, buffer.size()/5, 0, 255), 255, 255);
      //line(i, halfH + sample, i, halfH - sample); 
lerpedBuffer[i] = lerp(lerpedBuffer[i], buffer.get(i), 0.1f);
      sample = lerpedBuffer[i] * width / 2;    
      fill(map(i, 0, buffer.size()/5, 0, 255), 255, 255);
      ellipse(i*20, width/2, 5, sample); 
    }
   }
   
  if(which==2)
  {
    background(0);
    blendMode(ADD);
    colorMode(RGB,255);
    
for (int i = 0; i < buffer.size() ; i++) 
{
    
    // with linear interpolation:
    peaks[i] = lerp(last_peaks[i], (input.mix.get(i)*10000), 0.03);
    
    // with NO linear interpolation:
    //peaks[i] = (input.mix.get(i)*1000);
    
    last_peaks[i] = peaks[i];
  }
  
 rad1 = 0;
  rad1 += frameCount/125.0;
  rad2 = TWO_PI/3;
  rad2 += frameCount/300.0;
  rad3 = 2*(TWO_PI/3);
  rad3 -= frameCount/100.0;
  min = 200;
  for (int i = 0; i < 341; i++)
  {
     rad1 += step;
    rad2 += step;
    rad3 += step;
    if (i % 5 == 0) 
    {
      beginShape(TRIANGLES);
      fill(0, 0, 255);
      vertex(width/2, height/2);
      vertex(width/2 + sin(rad2)*(peaks[i]*amplitude1 + min*0.50), height/2 + cos(rad2)*(peaks[i]*amplitude1 + min*0.50));
      vertex(width/2 + sin(rad2 + step*step_multiple)*(peaks[i]*amplitude1 + min*0.50), height/2 + cos(rad2 + step*step_multiple)*(peaks[i]*amplitude1 + min*0.50));
      
      fill(0, 255, 0);
      vertex(width/2, height/2);
      vertex(width/2 + sin(rad1)*(peaks[i]*amplitude2 + min*0.75), height/2 + cos(rad1)*(peaks[i]*amplitude2 + min*0.75));
      vertex(width/2 + sin(rad1 + step*step_multiple2)*(peaks[i]*amplitude2 + min*0.75), height/2 + cos(rad1 + step*step_multiple2)*(peaks[i]*amplitude2 + min*0.75));
      
      fill(255, 0, 0);
      vertex(width/2, height/2);
      vertex(width/2 + sin(rad3)*(peaks[i]*amplitude3 + min), height/2 + cos(rad3)*(peaks[i]*amplitude3 + min));
      vertex(width/2 + sin(rad3 + step*step_multiple3)*(peaks[i]*amplitude3 + min), height/2 + cos(rad3 + step*step_multiple3)*(peaks[i]*amplitude3 + min));
      endShape();
    }
  }
   for (int i = 0; i < buffer.size(); i ++)
    {
      float sample = buffer.get(i) * halfH;
      stroke(map(i, 0, buffer.size(), 0, 255), 255, 255);
      //line(i, halfH + sample, i, halfH - sample); 

      lerpedBuffer[i] = lerp(lerpedBuffer[i], buffer.get(i), 0.1f);

      sample = lerpedBuffer[i] * width ;    
      stroke(map(i, 0, buffer.size(), 0, 255), 255, 255);
      line(0, i, sample, i); 
      line(width, i, width - sample, i); 
      line(i, 0, i, sample); 
      line(i, height, i, height - sample);
    }
  }
 
  float sum = 0;
  for (int i = 0; i < buffer.size(); i ++)
  {
    sum += abs(buffer.get(i));
  }
  
  noStroke();
  fill(map(lerpedAverage, 0, 1, 0, 255), 255, 255);
  float average = sum / buffer.size();
  lerpedAverage = lerp(lerpedAverage, average, 0.1f);
 

  } 



void keyPressed()
{
  if (keyCode >= '1' && keyCode <= '5')
  {
    which = keyCode - '0';
  }
 
  }
