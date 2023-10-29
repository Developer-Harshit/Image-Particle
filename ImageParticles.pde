PImage img;
ArrayList<Particle> plist = new ArrayList();
ArrayList<Repeler> rlist = new ArrayList();

void setup() {

  
  size(64*8, 64*8*2);
  int s  = round(height/2);
  colorMode(RGB, 255);
  noStroke();

  //noCursor();

  color[] pal =  { color(#4A0983), color(#C413CE), color(#DE6EC2), color(#F77594), color(#BFE5FC), color(#F7F7F7)};

  img = loadImage("data/img1.jpg");
  img.filter(BLUR);
  img.resize(s,s);
  quantImage(img, pal);


  createParticles(img);
  spreadParticles();
}
void mousePressed() {
  rlist.add(new Repeler(mouseX, mouseY));
}


void draw() {
  background(11);

  for (Particle p : plist) {
    PVector force;
    for (Repeler r : rlist) {
      force = p.flee(r.pos, 30, 3, r.mass);
      p.applyForce(force);
    }
  }


  for (Particle p : plist) {
    PVector force = p.arrive(p.target, 30, 3, 100);
    p.applyForce(force);

    p.display();
    p.update();
  }
  fill(255);
  attract();
}
