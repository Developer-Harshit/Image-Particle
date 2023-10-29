class Particle {
  PVector pos, vel, acc;
  float mass = 1;
  float maxForce = 30;
  float maxSpeed = 10;
  float size;
  color c;
  PVector target;
  Particle(float x, float y, color _c, float _size) {
    target = new PVector(x, y);
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    size = _size;
    c = _c;
  }


  void applyForce(PVector force) {
    acc.add(force.div(mass));
  }

  void update() {


    vel.add(acc);

    pos.add(vel);

    acc.mult(0);
  }
  void display() {
   
    fill(c);
  
    ellipse(pos.x, pos.y, size, size);
   
  }

  PVector arrive(PVector target, float mSpeed, float mForce,float range) {
    PVector steer = PVector.sub(target, pos);
    
    noFill();

    if (steer.mag() > range) {



      steer.setMag(mSpeed);
      steer.sub(vel);

      steer.limit(mForce);

      return steer;
    }
    float forceMag = map(steer.mag(), 0, range, 0, mSpeed);
    steer.setMag(1);
    steer.mult(forceMag);

    steer.sub(vel);
    steer.limit(mForce);
    return steer;
  }

  PVector flee(PVector target, float mSpeed, float mForce,float range) {
    PVector steer = PVector.sub(pos, target);
    if (steer.mag() > range) {
      return new PVector(0, 0);
    }

    steer.setMag(mSpeed);
    steer.sub(vel);

    steer.limit(mForce);

    return steer;
  }
}
