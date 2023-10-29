

int getIndex(int x, int y, PImage myimg) {
  return x + y * myimg.width;
}
float grayscale(color c) {
  return (red(c) + blue(c) + green(c))/3.0;
}
void attract() {
  for (int i =0; i<rlist.size(); i++) {
    Repeler r1 = rlist.get(i);
    r1.display();
    r1.update();

    for (int j = 0; j<rlist.size(); j++) {

      Repeler r2 = rlist.get(j);
      if (r1 == r2) continue;
      r1.interect(r2);
    }
  }
}

void spreadParticles() {

  for (Particle p : plist) {
    p.pos.x = random(-500, width+500);
    p.pos.y = random(-500, height+500);
  }
}

void createParticles(PImage img) {
  float d = 5;
  for (int y = 0; y < img.height; y+=d) {
    for (int x = 0; x < img.width; x+=d) {
      int i = (int) random(x, x+d);
      int j = (int) random(y, y+d);
      color col = img.get(i, j);
      if (grayscale(col) < 11) continue;

      Particle p = new Particle(i+width/2.0 - img.width/2.0, j+height/2.0 - img.height/2.0, col, d);
      plist.add(p);
    }
  }
}
void quantImage(PImage img, color[] palette) {


  int factor = palette.length - 1;

  push();
  colorMode(RGB, 255);

  img.loadPixels();


  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int index = getIndex(x, y, img);
      color oldColor = img.pixels[index];




      float oldV2 = green(oldColor);
      float oldV3 = blue(oldColor);
      float oldV1 = red(oldColor);
      int newV1 = round(factor * oldV1 / 255.0 ) ;
      int newV2 = round(factor *  oldV2 / 255.0 ) ;
      int newV3 =  round(factor *   oldV3 / 255.0 ) ;
      int cIdx =  round((newV1+newV2+newV3)/3.0) ;
      img.pixels[index] = palette[cIdx] ;
    }
  }


  img.updatePixels();
  pop();
}
