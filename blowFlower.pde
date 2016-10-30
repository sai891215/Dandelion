class blowFlower {
  PImage img2;
  PVector location, acceleration, velocity;
  float ww;
  
  blowFlower(PImage img_, PVector f_,float ww_) {
  location=f_.get();
  img2=img_;
  ww=ww_;
  acceleration= new PVector(random(-0.2,0),random(-0.12,0.1));
  velocity = new PVector(ww*10,0);
  }
  void blow() {

    applyForce();
    drawFlower();
  }

  void drawFlower() {
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(location.z);
    image(img2, 0, 0, 100, 100);
    popMatrix();
    location.z-=random(ww/5);
  }
  void applyForce() {
    velocity.add(acceleration);
    location.x=location.x+velocity.x;
    location.y=location.y+velocity.y;
  }
  boolean isDead(){
    if(location.x>width||location.x<0||location.y<0||location.y>height){
      return true;
    }else{
      return false;
    }
  }
}