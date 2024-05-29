int baseHP, cash;
Map map;
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
  Map grid = new Map(27, 18, 1350, height);
  for (int i = 0; i < 27; i++){
    for (int j = 0; j < 18; j++){
      fill(255);
      stroke(133,187,101);
      square(grid.getTile(i, j).getX(), grid.getTile(i, j).getY(), 50);
    }
  }
  textSize(30);
  fill(255,0,0);
  text("HP: "+baseHP, 60, 45); 
  fill(133,187,101);
  text("Cash: $"+cash, 180, 45);
  if(left){
    
  }
}
