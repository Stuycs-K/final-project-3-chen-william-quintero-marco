int baseHP, cash;
boolean left = false;
void keyPressed() {
  left = true;
}

void keyReleased() {
  left = false;
}
Map map;

void setup(){
  size(1600,900);
  background(255);
  baseHP = 100;
  cash = 500;
  
}

void draw(){
  textSize(30);
  fill(255,0,0);
  text("HP: "+baseHP, 60, 45); 
  fill(133,187,101);
  text("Cash: $"+cash, 180, 45);
  if(left){
    
  }
}
