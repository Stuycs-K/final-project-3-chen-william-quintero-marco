int baseHP, cash;
boolean left = false;
void keyPressed() {
  left = true;
}

void keyReleased() {
  left = false;
}

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
  Map grid = new Map(27, 18, width, height);
  for (int i = 0; i < 28; i++){
    for (int j = 0; j < 19; j++){
      fill(0);
      stroke(133,187,101);
      square(grid.getTile().getX(), grid.getTile().getY());
  if(left){
    
  }
}
