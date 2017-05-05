int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;
int sec, min, start, timer;

/*
void setup() {
  size(640, 360);
  stroke(255);

  int radius = min(width, height) / 2;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  //hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;

  cx = width / 2;
  cy = height / 2;

  sec = 0;
  min = 0;
  start = millis();
  timer = 0;
}

void draw() {
  frameRate(99);
  timer += millis() - start;

  background(0);

  // Draw the clock background
  fill(80);
  noStroke();
  ellipse(cx, cy, clockDiameter, clockDiameter);
  
  float s = map(sec , 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(min + norm(sec, 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
if(timer > 999){
       sec++;
       timer-=1000;
       if(sec > 59){
            min++;
            sec = 0;
            if(min > 59){
                 min = 0;
            }
      }
}

  // Draw the hands of the clock
  stroke(255);
  strokeWeight(1);
  line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  strokeWeight(2);
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  //strokeWeight(4);
  //line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);

  // Draw the minute ticks
  strokeWeight(2);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadius;
    float y = cy + sin(angle) * secondsRadius;
    vertex(x, y);
  }
  endShape();
  start=millis();
}
*/