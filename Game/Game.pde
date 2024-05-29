int baseHP;
float cash;
boolean left = false;
Map map;
ArrayList<Tower> towerList;
static int NO_TOWER = 0;
static int PENCIL_LAUNCHER = 1;
static int RULER_POLICE = 2;
static int TOWER_MODE = NO_TOWER;
static String TOWER_PLACING = "None";

void setup(){
  size(1600,900);
  background(255);
  baseHP = 100;
  cash = 500;
  towerList = new ArrayList<Tower>();
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
  System.out.println(TOWER_MODE);
}

void mouseClicked() {
  if (mouseButton == LEFT){
    Tower newTower;
    if (TOWER_MODE == PENCIL_LAUNCHER){
      newTower = new Pencil_Launcher(mouseX,mouseY);
      if (cash >= newTower.getCost()){
        towerList.add(newTower);
        cash -= newTower.getCost();
      }
    }
    if (TOWER_MODE == RULER_POLICE){
      newTower = new Ruler_Police(mouseX,mouseY);
      if (cash >= newTower.getCost()){
        towerList.add(newTower);
        cash -= newTower.getCost();
      }
    }
  }
}

void draw(){
  background(255);
  for (Tower t : towerList){
    t.place();
    t.attack();
  }
  textSize(30);
  fill(255,0,0);
  text("HP: "+baseHP, 60, 45); 
  fill(133,187,101);
  text("Cash: $"+cash, 180, 45);
  fill(0);
  text("Currently Placing: "+TOWER_PLACING, 350, 45);
}
