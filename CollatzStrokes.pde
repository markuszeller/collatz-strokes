int[] alphas = { 4, 8, 16, 32, 64, 128, 255 }; // 4, 8, 16, 32, 64, 128, 255
int alpha = 0;
int alphaIndex = 0;
int it = 1;
int loopStop;
int progress = 0;
float degStep = PI/4;

public void setup() {
  // size(851, 315); // facebook cover size
  // size(1600, 800); // deviant art cover size
  size(1080, 1080); // insta image size
  background(2);
  noFill();
  
  loopStop = (int) sqrt((width * width) + (height * height));
  alpha = getNextAlpha();
}

public void draw() {
  translate((int) random(width), (int) random(height));
  
  int num = it++;
  IntList precalc = new IntList();
  precalc.append(num);
  while(num != 1) {
    num = collatz(num);
    precalc.append(num);
  }
  precalc.append(1);
  
  int l = precalc.size();
  int colorR = (int)random(255);
  int colorG = (int)random(255);
  int colorB = (int)random(255);

  int strokeWeight = (int) random(sqrt(loopStop));
  strokeWeight(strokeWeight);
  stroke(colorR, colorG, colorB, alpha);

  int len = (int) random(width);
  if(len < strokeWeight) len = strokeWeight / 2;
  
  for(int i = 0; i < l; i++) {
    num = precalc.get(i);
    if(num % 2 == 0) {
      line(0, 0, len, -len);
      translate(len, -len);
      rotate(degStep);
    } else {
      line(0, 0, -len, -len);
      translate(-len, -len);
      rotate(-degStep);
    }
  }
  
  if(it > loopStop) {
    save("data/save_"+ nf(alpha, 3) + ".png");
    alpha = getNextAlpha();
    if(alpha == -1) {
      noLoop();
      println("Done");
      return;
    }
    background(2);
    it = 1;
  }
}

public int collatz(int num) {
  return (num % 2 == 0) ? num / 2 : num * 3 + 1; 
}

int getNextAlpha() {
  return (this.alphaIndex++ < this.alphas.length - 1) ? this.alphas[alphaIndex] : -1;
}
