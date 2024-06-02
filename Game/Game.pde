int baseHP;
float cash;
Map map;
ArrayList<Tower> towerList;
static int NO_TOWER = 0;
static int PENCIL_LAUNCHER = 1;
static int RULER_POLICE = 2;
static int TOWER_MODE = NO_TOWER;
static String TOWER_PLACING = "None";
Mob goon;
ArrayList<Mob> goonList;
int countdown;
int cornerTile = 0;
float xDiff = 0;
float yDiff = 0;
boolean start = false;
void setup(){
  size(1600,900);
  background(255);
  baseHP = 100;
  cash = 50031233;
  towerList = new ArrayList<Tower>();
  map = new Map(27, 18, 1350, height);
  goonList = new ArrayList<Mob>();
}

void keyPressed() {
  if (key == '0'){
    TOWER_MODE = NO_TOWER;
    TOWER_PLACING = "None";
  }else if (key == '1'){
    TOWER_MODE = PENCIL_LAUNCHER;
    TOWER_PLACING = "Pencil Launcher";
  }else if (key == '2'){
    TOWER_MODE = RULER_POLICE;
    TOWER_PLACING = "Ruler Police";
  }
}

void mouseClicked() {
  if (mouseButton == LEFT){
    Tower newTower;
    boolean inMap = false;
    if (map.getMapWidth() > mouseX && map.getMapLength() > mouseY){
      inMap = true;
    }
    if (TOWER_MODE == PENCIL_LAUNCHER){
      newTower = new Pencil_Launcher(mouseX,mouseY,map);
      if (cash >= newTower.getCost() && inMap){
        towerList.add(newTower);
        cash -= newTower.getCost();
      }
    }
    if (TOWER_MODE == RULER_POLICE){
      newTower = new Ruler_Police(mouseX,mouseY,map);
      if (cash >= newTower.getCost() && inMap){
        towerList.add(newTower);
        cash -= newTower.getCost();
      }
    }
    if (mouseX > 1375 && mouseX < 1575 && mouseY > 700 && mouseY < 800){
      start = true;
    }
  }
}

void draw(){
  background(255);
  if (countdown > 0){
    countdown--;
  }
  if (start && countdown == 0){
    countdown += 300;
    goon = new Mob(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard");
    goonList.add(goon);
  }
  for (int i = 0; i < 27; i++){
    for (int j = 0; j < 18; j++){
      if(map.getTile(i, j).getType() == 2){
        fill(255);
      }else if (map.getTile(i, j).getType() == 3){
        fill(255, 0, 0);
      }else{
        fill(0);
      }
      stroke(133,187,101);
      square(map.getTile(i, j).getX(), map.getTile(i, j).getY(), 50);
    }
  }
  for (Tower t : towerList){
    t.place();
    t.display();
    t.attack();
  }
  if (goonList.size() > 0){
  for(int i = 0; i < goonList.size(); i++){
    /*if (goonList.get(i).getY() >= 900){
      baseHP -= 100;
    }*/
    if (goonList.get(i).getHealth() != 0 && goonList.get(i).getY() < 950){
      goonList.get(i).move();
      goonList.get(i).display();
    }
    int hasCorner = map.findCorner(goonList.get(i).getX() - 25, goonList.get(i).getY() - 25);
    if(hasCorner != -1){
      xDiff = map.getCorner(cornerTile + 1).getX() - map.getCorner(cornerTile).getX();
      yDiff = map.getCorner(cornerTile + 1).getY() - map.getCorner(cornerTile).getY();
      goonList.get(i).changeDirection(map.getCorner(cornerTile + 1).getX() - map.getCorner(cornerTile).getX(), map.getCorner(cornerTile + 1).getY() - map.getCorner(cornerTile).getY(), cornerTile);
      cornerTile++;
    }
    // goonList.get(i).applyDamage(1);
  }
  fill(0);
  text(goonList.get(0).getX() + "," + goonList.get(0).getY(), 20, 40);
  text(goonList.get(0).getVelocity().x + "," + goonList.get(0).getVelocity().y, 20, 80);
  }
  textSize(30);
  fill(255,0,0);
  text("HP: "+baseHP, 1375, 45); 
  fill(133,187,101);
  text("Cash: $"+cash, 1375, 100);
  fill(0);
  text("Current Tower: ", 1375, 155);
  text(TOWER_PLACING, 1375, 190);
  text(cornerTile, 20, 60);
  text(xDiff + "," + yDiff, 20, 100);
  fill(0, 150, 0);
  rect(1375, 700, 200, 100);
}
