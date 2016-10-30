import ddf.minim.*;

Minim minim;
Minim minim2;
AudioInput in;
float total,minus;

AudioSample kick;
AudioSample kick2;

int r;
float power, velocity, acceleration, location, friction, angle,windRate,w,power1;
PImage img, gen,back;
PVector [] flower=new PVector[48];
ArrayList<Flower> ff;
ArrayList<blowFlower> bf;
void setup() {
  size(1000,700,P2D);
  r=16;
  
  minim = new Minim(this);
  minim2 = new Minim(this);
  in = minim.getLineIn();
  kick = minim.loadSample( "1.mp3", // filename
                            512     // buffer size
                         );
  kick2 = minim.loadSample( "2.mp3", // filename
                            512     // buffer size
                         );
  total=0;
  
  
  back=loadImage("back2.png");
  gen=loadImage("gen.png");
  ff= new ArrayList<Flower>();
  bf=new ArrayList<blowFlower>();
  for (int i=0; i<r; i++) {
    flower[i*3]=new PVector(TWO_PI/r*i, 70);
    flower[i*3+1]=new PVector(TWO_PI/r*i+PI/r, 50);
    flower[i*3+2]=new PVector(TWO_PI/r*i+3*PI/r, 90);
  }
  
  randomSeed(19);
  for (int o=0; o<48; o++) {
    img=loadImage(int(random(1, 7))+".png");
    ff.add(new Flower(img, flower[o]));
  }
}
void draw() {
 background(0);
 //image(back,width/2,height/2);
 blendMode(ADD);
 
  
  imageMode(CENTER);
  windAngle();
  branchRotate();
  if(angle<-0.2){
   w=angle;
  }else{
   w=0;
  }
  windRate=map(w,-4,-0.2,100,0);
  for (int i = ff.size()-1; i >= 0; i--) {
   Flower f=ff.get(i);
   if(random(100)>windRate){
     f.run();
   }else{
     ff.remove(i);
     bf.add(new blowFlower(f.img(),f.location(),angle));
     if(random(1)>0.5){
     kick.trigger();
     }else{
      kick2.trigger();
     }
   }
  }
  for(int o = bf.size()-1; o >= 0; o--){
   blowFlower b=bf.get(o);
   if(b.isDead()==false){
   b.blow();
   }else{
     bf.remove(o);
   }
  }
  if(ff.size()>48){
   ff.remove(0);
  }
  
  
  println(angle);
  sound(); 
  applyWind();
}

void windAngle() {

  velocity+=power;
  power=0;
  if (location<0) {
    friction=abs(location)*0.005;
  } else {
    friction=abs(location)*-0.005;
  }
  acceleration=friction;
  velocity+=acceleration;
  velocity*=0.985;
  location+=velocity;
  angle=map(location, -100, 100, -PI/4, PI/4);
}

void applyWind() {
  

  power1=constrain(map(total-minus,0,300,0,-2),-1,0);
  
  if(power1<-0.3)power=power1;
  else power=0;
  
}

void branchRotate() {
  pushMatrix();
  translate(714, 707);
  rotate(angle);
  image(gen, 0, -214);
  popMatrix();
}
void keyPressed(){
   for (int i=0; i<r; i++) {
    flower[i*3]=new PVector(TWO_PI/r*i, 70);
    flower[i*3+1]=new PVector(TWO_PI/r*i+PI/r, 50);
    flower[i*3+2]=new PVector(TWO_PI/r*i+3*PI/r, 90);
  }
  
  randomSeed(19);
  for (int o=0; o<48; o++) {
    img=loadImage(int(random(1, 7))+".png");
    ff.add(new Flower(img, flower[o]));
  }
}
void sound(){
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    
    
    if(i<1022){
    total+=abs(in.left.get(i)-in.left.get(i+1));
    }
    
    
  }
   if(frameCount%5==1){
    minus=total;
  }
}
  