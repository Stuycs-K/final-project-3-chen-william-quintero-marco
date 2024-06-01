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
int tile_number = 1;
void setup(){
  size(1600,900);
  background(255);
  baseHP = 100;
  cash = 50031233;
  towerList = new ArrayList<Tower>();
  map = new Map(27, 18, 1350, height);
  goon = new Mob(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard");
  goonList = new ArrayList<Mob>();
  goonList.add(goon);
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
  }
}

void draw(){
  background(255);
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
  for(int i = 0; i < goonList.size(); i++){
    goonList.get(i).move();
    goonList.get(i).display();
  }
  textSize(30);
  fill(255,0,0);
  text("HP: "+baseHP, 1375, 45); 
  fill(133,187,101);
  text("Cash: $"+cash, 1375, 100);
  fill(0);
  text("Current Tower: ", 1375, 155);
  text(TOWER_PLACING, 1375, 190);
  text(frameCount, 20, 20);
}
