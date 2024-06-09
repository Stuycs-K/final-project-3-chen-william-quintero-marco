int baseHP;
float cash;
Map map;
ArrayList<PathTile> path;
ArrayList<GrassTile> grass;
PImage grassTile;
PImage pathTile;
ArrayList<Tower> towerListData;
ArrayList<Tower> towerList;
ArrayList<Projectile> projectiles;
String[][] TOWER_STATS;
static int NO_TOWER = 0;
static int PENCIL_LAUNCHER = 1;
static int RULER_POLICE = 2;
static int TOWER_MODE = NO_TOWER;
static String TOWER_PLACING = "None";
Mob goon;
ArrayList<Mob> goonList;
ArrayList<int[]> waves = new ArrayList<int[]>(20);
int countdown = 0;
int cornerTile = 0;
int wave = 0;
float xDiff = 0;
float yDiff = 0;
boolean activeWave = false;
int numGoon = 0;
int startX = 1375;
int startY = 740;
int startL = 200;
int startW = 100;
//boolean draggingTower = false;
boolean towerSelected = false;
GrassTile selectTowerTile;
Tower selectedTower;
int Pencil_LauncherX = 1375;
int Pencil_LauncherY = 190;
PImage Pencil_LauncherImage;
int Ruler_PoliceX = 1485;
int Ruler_PoliceY = 190;
int TowerButtonSize = 100;
PImage Ruler_PoliceImage;
int towerInfoX = 800;
int towerInfoY = 640;
int towerInfoL = 500;
int towerInfoW = 250;
int sellXY = 825;
int sellL = 125;
int sellW = 50;
int upgradeX = sellXY+175;
int upgradeY = sellXY;
int upgradeL = 200;
int upgradeW = sellW;
int exitX = towerInfoX+450;
int exitY = towerInfoY;
int exitLW = 50;
PImage youWon;
PImage youLost;
PFont font, health;
void setup(){
  size(1600,900);
  background(255);
  baseHP = 100;
  cash = 1000000;
  map = new Map(27, 18, 1350, height);
  grassTile = loadImage("GrassTile.png");
  pathTile = loadImage("PathTile.png");
  grassTile.resize(50,50);
  pathTile.resize(50,50);
  path = map.getPath();
  grass = map.getGrass();
  towerListData = new ArrayList<Tower>();
  towerListData.add(new Pencil_Launcher(0,0,map));
  towerListData.add(new Ruler_Police(0,0,map));
  Pencil_LauncherImage = towerListData.get(0).getTowerImage();
  Ruler_PoliceImage = towerListData.get(1).getTowerImage();
  towerList = new ArrayList<Tower>();
  projectiles = new ArrayList<Projectile>();
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
  //waves.add(new int[]{0,1,2,3,4});
  waves.add(new int[]{0,0,0,0,0});
  waves.add(new int[]{0,0,0,0,0,0,0,0,0});
  waves.add(new int[]{0,0,0,0,0,1,1,1,1,1});
  waves.add(new int[]{2,2,2,2,2,2,2,2,2,2});
  waves.add(new int[]{0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2});
  waves.add(new int[]{2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2});
  waves.add(new int[]{0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3});
  waves.add(new int[]{2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2});
  waves.add(new int[]{3,3,3,3,3});
  waves.add(new int[]{0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,0,0,0,0,0,3,3,3,3,3});
  waves.add(new int[]{0,0,0,0,0,1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4});
  waves.add(new int[]{2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2});
  waves.add(new int[]{2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2});
  youWon = loadImage("YouWon.jpg");
  youLost = loadImage("YouLost.png");
  youWon.resize(1600,900);
  youLost.resize(1600,900);
  font = createFont("Naleni-rv318.ttf", 128);
  health = createFont("NostalgiaRegular-pg3lK.ttf", 128);
  textFont(font);
}

void keyPressed() {
  if (key == '0' || key == 'q' || key == 'Q'){
    TOWER_MODE = NO_TOWER;
    TOWER_PLACING = "None";
    for (Tower t : towerList){
      t.setSelected(false);
    }
    towerSelected = false;
  }else if (key == '1' || key == '2'){
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
    Tile clickTile = map.getTile(0, 0);
    if (inMap(mouseX,mouseY)){
      inMap = true;
      clickTile = map.getTile(tileX,tileY);
    }
    if (inMap){
      if (TOWER_MODE != 0 && TOWER_MODE <= towerListData.size() && clickTile.getType() == 2 && !clickTile.hasEntity() && !towerSelected){
        newTower = new Pencil_Launcher(mouseX,mouseY,map);
        System.out.println(mouseX +" "+mouseY);
        if (TOWER_MODE == PENCIL_LAUNCHER){
          newTower = new Pencil_Launcher(mouseX,mouseY,map);
        }
        if (TOWER_MODE == RULER_POLICE){
          newTower = new Ruler_Police(mouseX,mouseY,map);
        }
        if (cash >= newTower.getCost() && inMap){
          towerList.add(newTower);
          newTower.place();
          System.out.println(newTower.getTileX() + " " + newTower.getTileY());
          System.out.println(newTower.getX() + " " + newTower.getY());
          cash -= newTower.getCost();
        }
      }else if (clickTile.getType() == 2 && clickTile.hasEntity()){
      //CLICK ON UNITS TO SHOW THEIR RANGE
        for (int i = 0; i < grass.size(); i++){
        //clickTile.getX() == grass.get(i).getX() && clickTile.getY() == grass.get(i).getY()
          if (clickTile.equals(grass.get(i))){
            selectTowerTile = grass.get(i);
            selectedTower = selectTowerTile.getTower();
            System.out.println("Tower Selected: "+selectedTower.getTowerName());
          }
        }
        if (!selectedTower.getSelected()){
          for (Tower t : towerList){
            t.setSelected(false);
          }
          selectedTower.setSelected(true);
          towerSelected = true;
        }else{
          selectedTower.setSelected(false);
          towerSelected = false;
        }
      //WORK ON THIS ONLY FOR POLISHING
      }
      if (towerSelected){
        if (overSellButton()){
          selectedTower.getTowerTile().removeEntity();
          cash += selectedTower.getCost()/2;
          towerList.remove(selectedTower);
          towerSelected = false;
        }
        if (overExitButton()){
          selectedTower.setSelected(false);
          towerSelected = false;
        }
        if (overUpgradeButton() && cash >= selectedTower.getCurrentUpgrade().getUpgradeCost()){
          cash -= selectedTower.getCurrentUpgrade().getUpgradeCost();
          selectedTower.upgradeTower();
        }
      }
      
    }else{
      if (overStartButton() && !activeWave){
        activeWave = true;
        wave++;
      }
      if (overPencilLauncherButton()){
        TOWER_MODE = PENCIL_LAUNCHER;
      }
      if (overRulerPoliceButton()){
        TOWER_MODE = RULER_POLICE;
      }
      if (TOWER_MODE != 0){
        TOWER_PLACING = towerListData.get(TOWER_MODE-1).getTowerName();
      }
    }
  }
}

void draw(){
  background(255);
  if (baseHP > 0 && wave <= waves.size()){
    for (int i = 0; i < 27; i++){
      for (int j = 0; j < 18; j++){
        if(map.getTile(i, j).getType() == 2){
          image(grassTile,map.getTile(i, j).getX(), map.getTile(i, j).getY());
        }else if (map.getTile(i, j).getType() == 1 || map.getTile(i, j).getType() == 3){
          image(pathTile,map.getTile(i, j).getX(), map.getTile(i, j).getY());
        }
      }
    }
    if (activeWave && goonList.size() == waves.get(wave - 1).length){
      int numDead = 0;
      for (int i = 0; i < goonList.size(); i++){
       if(goonList.get(i).getHealth() == 0 || goonList.get(i).getY() >= 900){
          numDead++;
        }
      }
      if (numDead == goonList.size()){
        activeWave = false;
        cash += wave*100;
      }
    }
    
    if (countdown > 0){
      countdown--;
    }
    if (activeWave && goonList.size() < waves.get(wave - 1).length && countdown == 0){
      countdown += 30;
      int goonType = waves.get(wave - 1)[numGoon];
      if(goonType == 0){
        goon = new Mob(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
      }else if (goonType == 1){
        goon = new Project(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
      }else if (goonType == 2){
        goon = new Textbook(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
      }else if (goonType == 3){
        goon = new Whiteboard(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
      }else if (goonType == 4){
        goon = new Test(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
      }
      goonList.add(goon);
      numGoon++;
    }
    for (Tower t : towerList){
      //t.place();
      t.display();
      if (t.getCooldown() == 0 && activeWave){
        if (t.findMob() != null){
          projectiles.add(t.createProjectile(t.findMob()));
          t.attack();
          cash += t.getDamage();
        }
        t.setCooldown((int)(t.getAttackSpeed()*60));
      }else if (activeWave){
        t.setCooldown(t.getCooldown()-1);
      }
      if (t.getSelected()){
        TOWER_MODE = NO_TOWER;
        TOWER_PLACING = "None";
        for (int i = t.getTileX()-(int)t.getRadius(); i <= t.getTileX()+(int)t.getRadius(); i++){
          for (int j = t.getTileY()-(int)t.getRadius(); j <= t.getTileY()+(int)t.getRadius(); j++){
            if (i >= 0 && j >= 0 && i < map.getMapRow() && j < map.getMapCol()){
              if (i != t.getTileX() || j != t.getTileY()){
                tint(0, 153, 204, 126);
                image(grassTile,map.getTile(i, j).getX(), map.getTile(i, j).getY());
              }
              tint(255, 255);
            }
          }
        }
        fill(255);
        rect(towerInfoX,towerInfoY,towerInfoL,towerInfoW,10);
        image(t.getTowerImage(),towerInfoX+10,towerInfoY+10,150,150);
        fill(0);
        textSize(40);
        text(t.getTowerName(),towerInfoX+160,towerInfoY+50);
        textSize(25);
        if (t.getUpgradeNum() < t.getUpgrades().size()){
          text("Upgrade " + (t.getUpgradeNum()+1) + ": " + t.getCurrentUpgrade().getUpgradeName(),towerInfoX+160,towerInfoY+80);
          textSize(20);
          text("Damage: " + t.getDamage() + " + " + t.getCurrentUpgrade().getAddDamage(),towerInfoX+160,towerInfoY+110);
          text("Radius: " + t.getRadius() + " + " + t.getCurrentUpgrade().getAddRadius(),towerInfoX+160,towerInfoY+140);
          text("Attack Speed: " + t.getAttackSpeed() + " - " + t.getCurrentUpgrade().getAddAttackSpeed(),towerInfoX+160,towerInfoY+170);
          fill(0,150,0);
          if (overUpgradeButton()){
            fill(0, 180, 0);
          }else{
            fill(0,150,0);
          }
          rect(upgradeX,upgradeY,upgradeL,upgradeW,10);
          textSize(40);
          fill(0);
          text("$" + t.getCurrentUpgrade().getUpgradeCost(),upgradeX+40,upgradeY+40);
        }else{
          text("Upgrade: MAXED",towerInfoX+160,towerInfoY+80);
          textSize(20);
          text("Damage: " + t.getDamage(),towerInfoX+160,towerInfoY+110);
          text("Radius: " + t.getRadius(),towerInfoX+160,towerInfoY+140);
          text("Attack Speed: " + t.getAttackSpeed(),towerInfoX+160,towerInfoY+170);
        }
        fill(255,0,0);
        if (overSellButton()){
          fill(255,0,0);
        }else{
          fill(225,0,0);
        }
        rect(sellXY,sellXY,sellL,sellW,10);
        if (overExitButton()){
          fill(255,0,0);
        }else{
          fill(225,0,0);
        }
        rect(exitX,exitY,exitLW,exitLW,10);
        fill(0);
        textSize(20);
        text("Sell for $"+(t.getCost()/2),sellXY+5,sellXY+(sellW/2)+5);
        textSize(40);
        text("X",exitX+15,exitY+35);
      }
    }
    for(int i = 0; i < projectiles.size(); i++){
      Projectile p = projectiles.get(i);
       p.move();
       p.displayProjectile();
       if (!inMap(p.getPosition().x,p.getPosition().y)){
        projectiles.remove(p);
       }
    }
    if (goonList.size() > 0){
      for(int i = 0; i < goonList.size(); i++){
        /*if (goonList.get(i).getY() >= 900){
        baseHP -= 100;
        }*/
        Mob currentGoon = goonList.get(i);
        if (goonList.get(i).getHealth() > 0 && goonList.get(i).getX() < map.getMapWidth() && goonList.get(i).getY() < map.getMapLength()){
          goonList.get(i).move();
          goonList.get(i).display();
          currentGoon.setCurrentTile(currentGoon.getX(),currentGoon.getY());
          fill(255);
          textFont(health,20);
          text(currentGoon.getMobName(), currentGoon.getX()-34, currentGoon.getY()-40);
          fill(0, 200, 0);
          textSize(30);
          text(currentGoon.getHealth(), currentGoon.getX()-17, currentGoon.getY()+10);
          textFont(font,20);
        }else{
          currentGoon.getCurrentTile().removeEntity();
          if (goonList.get(i).getHealth() != 0 && goonList.get(i).getX() >= map.getMapWidth() || goonList.get(i).getY() >= map.getMapLength()){
            baseHP -= currentGoon.getHealth();
            goonList.get(i).applyDamage(100000000);
          }
        }
          //if (goonList.size() > 1){
          //  goonList.remove(currentGoon);
          //  System.out.println("bruh");
          //}
        if(currentGoon.getCorner() < 11 && map.nearCorner(currentGoon.getX() - 25, currentGoon.getY() - 25, currentGoon.getCorner())){
          currentGoon.changePosition(map.getCorner(currentGoon.getCorner()).getX() + 25, map.getCorner(currentGoon.getCorner()).getY() + 25);
        }
        int hasCorner = map.findCorner(goonList.get(i).getX() - 25, goonList.get(i).getY() - 25);
        if(hasCorner != -1){
          xDiff = map.getCorner(goonList.get(i).getCorner() + 1).getX() - map.getCorner(goonList.get(i).getCorner()).getX();
          yDiff = map.getCorner(goonList.get(i).getCorner() + 1).getY() - map.getCorner(goonList.get(i).getCorner()).getY();
          goonList.get(i).changeDirection(xDiff, yDiff, currentGoon.getCorner());
          goonList.get(i).changeCorner();
        }
        //currentGoon.applyDamage(1);
      }
      fill(0);
      text(goonList.get(0).getX() + "," + goonList.get(0).getY(), 20, 20);
      text("Current Corner: " + goonList.get(0).getCorner(), 20, 40);
      //text("Near Corner: " + map.nearCorner(goonList.get(0).getX() - 25, goonList.get(0).getY() - 25, goonList.get(0).getCorner()), 20, 60);
      text("numGoon: " + numGoon, 20, 60);
      text("wave number: " + wave, 20, 80);
      text("activeWave?: " + activeWave, 20, 100);
      if(!activeWave){
        goonList = new ArrayList<Mob>();
        numGoon = 0;
      }
    }
    textSize(30);
    fill(255,0,0);
    text("HP: "+baseHP, 1375, 45); 
    fill(133,187,101);
    text("Cash: $"+cash, 1375, 100);
    fill(0);
    text("Towers: ", 1375, 155);
    if (overPencilLauncherButton()){
      image(Pencil_LauncherImage,Pencil_LauncherX,Pencil_LauncherY,TowerButtonSize+10,TowerButtonSize+10);
    }else{
      image(Pencil_LauncherImage,Pencil_LauncherX,Pencil_LauncherY,TowerButtonSize,TowerButtonSize);
    }
    if (overRulerPoliceButton()){
      image(Ruler_PoliceImage,Ruler_PoliceX,Ruler_PoliceY,TowerButtonSize+10,TowerButtonSize+10);
    }else{
      image(Ruler_PoliceImage,Ruler_PoliceX,Ruler_PoliceY,TowerButtonSize,TowerButtonSize);
    }
    //square(1375,300,TowerButtonSize);
    //square(1485,300,TowerButtonSize);
    fill(0);
    text("Tower Info: ", 1375, 440);
    text(TOWER_PLACING, 1375, 470);
    if (TOWER_MODE != 0){
      for (int i = 0; i < TOWER_STATS[TOWER_MODE].length; i++){
        text(TOWER_STATS[0][i] + TOWER_STATS[TOWER_MODE][i], 1375, 500 + (i*35));
      }
    }
    text("Wave: " + wave + "/" + waves.size(), 1375, 650);
    if (!activeWave && wave != 0){
      text("Wave "+wave+" Ended.", 1375, 680);
      fill(0, 150, 0);
      text("$"+wave*100+" rewarded.", 1375, 710);
    }
    if (overStartButton()){
      fill(0, 180, 0);
    }else{
      fill(0, 150, 0);
    }
    rect(startX, startY, startL, startW,10);
    fill(0);
    text("START", 1435, 800);
  }else if (baseHP <= 0){
    image(youLost,0,0);
    fill(255,0,0);
    textSize(100);
    text("GAME OVER! YOUR GRADES ARE HORRIBLE!", 15, 450);
    text("HAVE FUN WORKING AT MCDONALDS!", 100, 575);
  }else if (wave > waves.size()){
    image(youWon,0,0);
    fill(0,200,0);
    textSize(100);
    text("YOU WON! Your grades are... Acceptable.", 25, 450);
  }
}

boolean inMap(float x, float y){
  return (x < map.getMapWidth() && y < map.getMapLength() && x >= 0 && y >= 0);
}
boolean overStartButton(){
  return (mouseX >= startX && mouseX <= startX+startL && mouseY >= startY && mouseY <= startY+startW);
}
  
boolean overPencilLauncherButton(){
  return (mouseX >= Pencil_LauncherX && mouseX <= Pencil_LauncherX+TowerButtonSize && mouseY >= Pencil_LauncherY && mouseY <= Pencil_LauncherY+TowerButtonSize);
}

boolean overRulerPoliceButton(){
  return (mouseX >= Ruler_PoliceX && mouseX <= Ruler_PoliceX+TowerButtonSize && mouseY >= Ruler_PoliceY && mouseY <= Ruler_PoliceY+TowerButtonSize);
}

boolean overSellButton(){
  return (mouseX >= sellXY && mouseX <= sellXY+sellL && mouseY >= sellXY && mouseY <= sellXY+sellW);
}

boolean overUpgradeButton(){
  return (mouseX >= upgradeX && mouseX <= upgradeX+upgradeL && mouseY >= upgradeY && mouseY <= upgradeY+upgradeW);
}

boolean overExitButton(){
  return (mouseX >= exitX && mouseX <= exitX+exitLW && mouseY >= exitY && mouseY <= exitY+exitLW);
}
