float GConst = 200;

class Repeler {

  PVector pos, vel, acc;
  
  float mass, maxForce, maxSpeed;
  
  Repeler(float x, float y) {
    mass = random(30,40);
    maxForce = 20;
    maxSpeed = 34;
    
    pos = new PVector(x, y);
    vel = new PVector(0, 0);// PVector.random2D();

    acc = new PVector(0, 0);

    
  }
  void applyForce(PVector force) {
    acc.add(force.div(mass));
  }
  void interect(Repeler other) {

    // its unit vector pointing from other towards this
    PVector distance = new PVector(pos.x - other.pos.x, pos.y- other.pos.y);

    if (distance.mag()  < 0.8) {
     
      return;
    }

  
    float forceMag = GConst * mass * other.mass / distance.magSq();
    distance.setMag(1);
    PVector force = new PVector(forceMag*distance.x, forceMag*distance.y);
    force.limit(maxForce);
    // 01 --------> 02
    other.applyForce(force.copy());

    force.mult(-1);

    applyForce(force.copy());
  }
  void update() {
    
    edges();
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }
 
  void edges() {
    float buf = 0.2;
    float k = 0.8;
    if (pos.x < mass   ) {
      vel.x = k * abs(vel.x);
      pos.x = buf + mass;
    } else if ( pos.x > width - mass ) {
      vel.x = -k * abs(vel.x);
      pos.x = width - mass - buf;
    }


    if (pos.y < mass) {
      vel.y = k * abs(vel.y);
      pos.y = buf + mass;
    } else if ( pos.y > height - mass ) {
      vel.y = -k * abs(vel.y);
      pos.y = height-mass - buf;
    }
  }
  void display() {



    
    ellipse(pos.x,pos.y,14,14);

  }
}
