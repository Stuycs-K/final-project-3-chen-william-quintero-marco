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
Mob goon;
ArrayList<Mob> goonList;
int countdown = 0;
int wave = 1;
float xDiff = 0;
float yDiff = 0;
boolean activeWave = false;
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
  goon = new Mob(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
  goonList = new ArrayList<Mob>();
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
    Tile tile = map.getTile(0, 0);
    if (map.getMapWidth() > mouseX && map.getMapLength() > mouseY){
      inMap = true;
      tile = map.getTile(tileX,tileY);
    }
    if (inMap){
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
    }else{
    if (mouseX > 1375 && mouseX < 1575 && mouseY > 700 && mouseY < 800){
      activeWave = true;
    }
    }
  }
}

void draw(){
  background(255);
  if (goonList.size() == 5){
  int numDead = 0;
  for (int i = 0; i < goonList.size(); i++){
    if(goonList.get(i).getHealth() == 0 || goonList.get(i).getY() > 950){
      numDead++;
    }
  }
  if (numDead == goonList.size()){
    activeWave = false;
  }
  }
  if (countdown > 0){
    countdown--;
  }
  if (goonList.size() < 5 && activeWave && countdown == 0){
    countdown += 300;
    goon = new Mob(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
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
    float countdown = t.getAttackSpeed();
    if(countdown > 0){
      countdown--;
    }
    if (countdown == 0){
      t.attack();
      countdown = t.getAttackSpeed();
    }
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
      xDiff = map.getCorner(goonList.get(i).getCorner() + 1).getX() - map.getCorner(goonList.get(i).getCorner()).getX();
      yDiff = map.getCorner(goonList.get(i).getCorner()).getY() - map.getCorner(goonList.get(i).getCorner()).getY();
      goonList.get(i).changeDirection(map.getCorner(goonList.get(i).getCorner() + 1).getX() - map.getCorner(goonList.get(i).getCorner()).getX(), map.getCorner(goonList.get(i).getCorner() + 1).getY() - map.getCorner(goonList.get(i).getCorner()).getY(), goonList.get(i).getCorner());
      goonList.get(i).changeCorner();
    }
     goonList.get(i).applyDamage(1);
  }
  fill(0);
  text(goonList.get(0).getX() + "," + goonList.get(0).getY(), 20, 20);
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
  text("Wave:" + wave, 20, 40);
  text("Active Wave?: " + activeWave, 20, 60);
  fill(0, 150, 0);
  rect(1375, 700, 200, 100);
}
