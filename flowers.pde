class Flower {
  float angle2,R;
  float r;
  PVector f;
  PImage img;
  boolean wind;
  PVector location,rotate;
  Flower(PImage img_, PVector f_) {
   
    angle2=f_.x;
    r=f_.y;
    img=img_;
    
    location=new PVector(0,0);
    wind=false;
    rotate=new PVector(0,0);
    R=378;
  }
  void run() {
    
   
    drawFlower();
    
  }

  void drawFlower() {
    

      
      pushMatrix();
      
     
      location.x=sin(angle2)*r+sin(angle)*R+703;
      location.y=-cos(angle2)*r+(1-cos(angle))*R+331;
      translate(location.x,location.y);
      
      rotate(angle2+angle);
      image(img,0,0, 100, 100);
      popMatrix();
      
      
      
  }
 
  PVector location(){
    PVector loc=new PVector(location.x,location.y,angle+angle2);
    return loc;
  }
  
  PImage img(){
    return img;
  }
    
}