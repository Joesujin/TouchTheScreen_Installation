float xNoise, yNoise, xStart, yStart, scl,onemorescale;
float xstartNoise, ystartNoise;
float a, b, lastx, lasty;
float fade;
PImage img;



void setup() {
  size(displayWidth, displayHeight, P2D);
  strokeWeight(1);
  scl = 12;
  onemorescale =5;
  noFill();
  xStart = random(10);
  yStart = random(10);
  rectMode(CENTER);
  colorMode(HSB);
  img = loadImage("CAT.jpg");



  xstartNoise = random(20);
  ystartNoise = random(20);
}

void draw() {
  fill(0);
  noStroke();
  rect(0, 0, width*2, height*2);
  //background(0);


  xstartNoise += 0.008;
  ystartNoise += 0.008;

  xStart += (noise(xstartNoise)*0.009)-0.008;
  yStart += (noise(ystartNoise)*0.009)-0.008;
  //xStart+=0.008;
  //yStart+=0.008;

  xNoise = xStart;
  yNoise = yStart;
  if (mousePressed ==true) {
    fade =250;
  } else if (fade <= 20) {
    textSize(150);
    fill(140);
    text("Touch The Screen", 100, 250);
  }
  a=mouseX;
  b=mouseY;


  lastx=lerp(lastx, a, 0.04);
  lasty=lerp(lasty, b, 0.06);

  for (int y=0; y<=500; y+=onemorescale) {
    for (int x=0; x<=500; x+= onemorescale) {
      pushMatrix();
      translate(1200+x,500+y);
      float distant = dist(lastx, lasty,1200+x,500+y);
      
      if (distant<=fade){
        color c = img.get(int(x),int(y));
        fill(c);
        ellipse(0,0,onemorescale,onemorescale);
      }
      popMatrix();
      
    }
  }
  

  for (float y=0; y<=height; y+=scl) {
    yNoise += 0.07;
    xNoise = xStart;
    for (float x=0; x<=width; x+=scl) {
      xNoise += 0.07;


      float NoiseVal = noise(xNoise, yNoise);
      //float lerpX= lerp(x,a,0.06);
      //float lerpY= lerp(y,b,0.06);


      float distant = dist(lastx, lasty, x, y);

      if (distant<=fade&& (NoiseVal*50)>15) {
        drawPointRotate(x, y, NoiseVal, scl);
      }
      //if (distant<=fade&& (NoiseVal*50)>25){
      //  color c = img.get(int(x),int(y));
      //  fill(c);
      //  ellipse(x,y,2,2);
      //}
      
      //else{
      //drawPoint(x, y, NoiseVal, scl);
      //}
      //println(NoiseVal*255);
    }
  }


  fade-=0.1;
}



void drawPoint(float x, float y, float Noise, float Size) {
  pushMatrix();
  noFill();
  translate(x, y);
  //rotate(Noise*radians(360*1.35));
  stroke(30, 170, Noise*255, 50);
  strokeWeight(15);
  line(0, 0, (Size+20), 0);
  //rect(0,0,Size,Size);
  popMatrix();
}

void drawPointRotate(float x, float y, float Noise, float Size) {
  pushMatrix();
  noFill();
  translate(x, y);
  rotate(Noise*radians(360*1.15));
  stroke(Noise*255+50, Noise*230+25, 255, Noise*255);
  strokeWeight(Noise*20);
  line(0, 0, Noise*(Size+100), 0);
  stroke(130, 70, Noise*255, 12);
  strokeWeight(1);
  //ellipse(0,0,Noise*(Size),Noise*(Size));
  popMatrix();
}
