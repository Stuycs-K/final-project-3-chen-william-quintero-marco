int baseHP;
float cash;
Map map;

ArrayList<Tower> towerListData;
ArrayList<Tower> towerList;
String[][] TOWER_STATS;
static int NO_TOWER = 0;
static int PENCIL_LAUNCHER = 1;
static int RULER_POLICE = 2;
static int TOWER_MODE = NO_TOWER;
static String TOWER_PLACING = "None";

void setup(){
  size(1600,900);
  background(255);
  baseHP = 100;
  cash = 2169420;
  map = new Map(27, 18, 1350, height);
  towerListData = new ArrayList<Tower>();
  towerListData.add(new Pencil_Launcher(0,0,map));
  towerListData.add(new Ruler_Police(0,0,map));
  towerList = new ArrayList<Tower>();
  TOWER_STATS = new String[towerListData.size()+1][5];
  for (int i = 0; i < TOWER_STATS.length; i++){
    if (i == 0){
      TOWER_STATS[i] = new String[]{"Damage: ","Radius: ","Attack Speed: ","Cost: "};
    }else{
      Tower towerData = towerListData.get(i-1);
      TOWER_STATS[i] = new String[]{""+towerData.getDamage(),""+towerData.getRadius(),""+towerData.getAttackSpeed(),""+towerData.getCost()};
    }
  }
}

void keyPressed() {
  if (key == '0'){
    TOWER_MODE = NO_TOWER;
    TOWER_PLACING = "None";
  }else{
    if (key == '1'){
      TOWER_MODE = PENCIL_LAUNCHER;
    }
    if (key == '2'){
      TOWER_MODE = RULER_POLICE;
    }
    TOWER_PLACING = towerListData.get(TOWER_MODE-1).getTowerName();
  }
}

void mouseClicked() {
  if (mouseButton == LEFT){
    Tower newTower;
    boolean inMap = false;
    int tileX = (int)(mouseX/50);
    int tileY = (int)(mouseY/50);
    Tile tile = map.getTile(tileX,tileY);
    if (map.getMapWidth() > mouseX && map.getMapLength() > mouseY){
      inMap = true;
    }
    if (TOWER_MODE != 0 && tile.getType() == 2 && !tile.hasEntity()){
      newTower = new Pencil_Launcher(mouseX,mouseY,map);
      if (TOWER_MODE == PENCIL_LAUNCHER){
        newTower = new Pencil_Launcher(mouseX,mouseY,map);
      }
      if (TOWER_MODE == RULER_POLICE){
        newTower = new Ruler_Police(mouseX,mouseY,map);
      }
      if (cash >= newTower.getCost() && inMap){
          towerList.add(newTower);
          cash -= newTower.getCost();
      }
    }else{
      //CLICK ON UNITS TO SHOW THEIR RANGE
      if (inMap){
        Tile clickTile = map.getTile(tileX,tileY);
        if (clickTile.getType() == 2 && clickTile.hasEntity()){
          
        }
      }
      //WORK ON THIS ONLY FOR POLISHING
    }
  }
}

void draw(){
  background(255);
  for (int i = 0; i < 27; i++){
    for (int j = 0; j < 18; j++){
      if(map.getTile(i, j).getType() == 2){
        fill(255);
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
    float countdown = t.getAttackSpeed();
    if(countdown > 0){
      countdown--;
    }
    if (countdown == 0){
      t.attack();
      System.out.println("SHOT");
      countdown = t.getAttackSpeed();
    }
  }
  textSize(30);
  fill(255,0,0);
  text("HP: "+baseHP, 1375, 45); 
  fill(133,187,101);
  text("Cash: $"+cash, 1375, 100);
  fill(0);
  text("Current Tower: ", 1375, 155);
  text(TOWER_PLACING, 1375, 190);
  if (TOWER_MODE != 0){
    for (int i = 0; i < TOWER_STATS[TOWER_MODE].length; i++){
      text(TOWER_STATS[0][i] + TOWER_STATS[TOWER_MODE][i], 1375, 225 + (i*35));
    }
  }
}
