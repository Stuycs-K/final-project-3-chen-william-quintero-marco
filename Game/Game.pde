int baseHP;
float cash;
Map map;
PImage grassTile;
PImage pathTile;
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
int cornerTile = 0;
int wave = 0;
float xDiff = 0;
float yDiff = 0;
boolean activeWave = false;
int startX = 1375;
int startY = 740;
int startL = 200;
int startW = 100;
//boolean draggingTower = false;
int Pencil_LauncherX = 1375;
int Pencil_LauncherY = 190;
PImage Pencil_LauncherImage;
int Ruler_PoliceX = 1485;
int Ruler_PoliceY = 190;
int TowerButtonSize = 100;
PImage Ruler_PoliceImage;
void setup(){
  size(1600,900);
  background(255);
  baseHP = 100;
  cash = 500000;
  map = new Map(27, 18, 1350, height);
  grassTile = loadImage("GrassTile.png");
  pathTile = loadImage("PathTile.png");
  grassTile.resize(50,50);
  pathTile.resize(50,50);
  towerListData = new ArrayList<Tower>();
  towerListData.add(new Pencil_Launcher(0,0,map));
  towerListData.add(new Ruler_Police(0,0,map));
  Pencil_LauncherImage = towerListData.get(0).getTowerImage();
  Ruler_PoliceImage = towerListData.get(1).getTowerImage();
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
  if (key == '0' || key == 'q' || key == 'Q'){
    TOWER_MODE = NO_TOWER;
    TOWER_PLACING = "None";
    for (Tower t : towerList){
      t.setSelected(false);
    }
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
    Tile tile = map.getTile(0, 0);
    if (map.getMapWidth() > mouseX && map.getMapLength() > mouseY){
      inMap = true;
      tile = map.getTile(tileX,tileY);
    }
    if (inMap){
      if (TOWER_MODE != 0 && TOWER_MODE <= towerListData.size() && tile.getType() == 2 && !tile.hasEntity()){
        newTower = new Pencil_Launcher(mouseX,mouseY,map);
        if (TOWER_MODE == PENCIL_LAUNCHER){
          newTower = new Pencil_Launcher(mouseX,mouseY,map);
        }
        if (TOWER_MODE == RULER_POLICE){
          newTower = new Ruler_Police(mouseX,mouseY,map);
        }
        if (cash >= newTower.getCost() && inMap){
          towerList.add(newTower);
          newTower.setCurrentTile(mouseX,mouseY);
          cash -= newTower.getCost();
        }
      }else{
      //CLICK ON UNITS TO SHOW THEIR RANGE
        ArrayList<GrassTile> grass = map.getGrass();
        Tile clickTile = map.getTile(tileX,tileY);
        if (clickTile.getType() == 2 && clickTile.hasEntity()){
          GrassTile selectTowerTile;
          Tower selectedTower;
          for (int i = 0; i < grass.size(); i++){
            //clickTile.getX() == grass.get(i).getX() && clickTile.getY() == grass.get(i).getY()
            if (clickTile.equals(grass.get(i)) && grass.get(i).hasEntity()){
              selectTowerTile = grass.get(i);
              System.out.println(selectTowerTile.hasEntity());
              if (selectTowerTile != null){
                System.out.println("Tile exists");
              }
              selectedTower = selectTowerTile.getTower();
              if (selectedTower != null){
                System.out.println("Tower exists");
              }
              for (Tower t : towerList){
                t.setSelected(false);
              }
              System.out.println(towerList.size());
              selectedTower.setSelected(true);
              //System.out.println(selectedTower.getTowerName());
            }
          }
        }
        
      //WORK ON THIS ONLY FOR POLISHING
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
  if (baseHP > 0){
    for (int i = 0; i < 27; i++){
      for (int j = 0; j < 18; j++){
        if(map.getTile(i, j).getType() == 2){
          image(grassTile,map.getTile(i, j).getX(), map.getTile(i, j).getY());
        }else if (map.getTile(i, j).getType() == 1 || map.getTile(i, j).getType() == 3){
          image(pathTile,map.getTile(i, j).getX(), map.getTile(i, j).getY());
        }
      }
    }
    if ((wave == 1 && goonList.size() == 5) || (wave == 2 && goonList.size() == 5 * 4)){
      int numDead = 0;
      for (int i = 0; i < goonList.size(); i++){
       if(goonList.get(i).getHealth() == 0 || goonList.get(i).getY() > 900){
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
    if ((wave == 1 && goonList.size() < 5 || wave == 2 && goonList.size() < 5 * 4) && activeWave && countdown == 0){
      countdown += 300;
      if(wave == 2){
        goon = new Boss(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
      }else{
        goon = new Mob(map.getFirstPath().getX() + 25, map.getFirstPath().getY() + 25, 50, "standard", map);
      }
      goonList.add(goon);
    }
    for (Tower t : towerList){
      t.place();
      t.display();
      if (t.getCooldown() == 0){
        t.attack();
        t.setCooldown((int)(t.getAttackSpeed()*60));
      }else{
        t.setCooldown(t.getCooldown()-1);
      }
      if (t.getSelected()){
        fill(0);
        rect(100,100,100,100);
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
          text(currentGoon.getHealth(), currentGoon.getX()-20, currentGoon.getY()+10);
        }else{
          /*if (currentGoon.getType() == 1 && !currentGoon.isBroke()){
            Tile currentTile = currentGoon.getCurrentTile();
            Mob newGoon1 = new Mob(currentTile.getX() + 25, currentTile.getY() + 25, 50, "standard", map);
            //Mob newGoon2 = new Mob(currentTile.getX() - 25, currentTile.getY() + 25, 50, "standard", map);
            //Mob newGoon3 = new Mob(currentTile.getX() + 75, currentTile.getY() + 25, 50, "standard", map);
            int cornerIndex = map.findCorner(currentTile.getX(), currentTile.getY());
            if (currentGoon.getVelocity().x == -2){
              newGoon1.changeDirection((float)-2, (float)0, cornerIndex);
              //newGoon2.changeDirection((float)-2, (float)0, cornerIndex);
              //newGoon3.changeDirection((float)-2, (float)0, cornerIndex);
            }
            if (cornerIndex == 0 || cornerIndex == 3 || cornerIndex == 6 || cornerIndex == 9){
              //newGoon2 = new Mob(currentTile.getX() - 25, currentTile.getY() + 25, 50, "standard", map);
              //newGoon3 = new Mob(currentTile.getX() + 25, currentTile.getY() - 25, 50, "standard", map);
              if (cornerIndex == 0 || cornerIndex == 9){
                newGoon1.changeDirection((float)0, (float)-2, cornerIndex);
                //newGoon3.changeDirection((float)0, (float)-2, cornerIndex);
              }else{
                newGoon1.changeDirection((float)-2, (float)0, cornerIndex);
                //newGoon2.changeDirection((float)-2, (float)0, cornerIndex);
              }
            }else if (cornerIndex == 1 || cornerIndex == 8){
              //newGoon2 = new Mob(currentTile.getX() - 25, currentTile.getY() + 25, 50, "standard", map);
              //newGoon3 = new Mob(currentTile.getX() + 25, currentTile.getY() + 75, 50, "standard", map);
              if (cornerIndex == 1){
                newGoon1.changeDirection((float)-2, (float)0, cornerIndex);
                //newGoon2.changeDirection((float)-2, (float)0, cornerIndex);
              }else{
                newGoon1.changeDirection((float)0, (float)2, cornerIndex);
                //newGoon3.changeDirection((float)0, (float)2, cornerIndex);
              }
            }else if (cornerIndex == 2 || cornerIndex == 5 || cornerIndex == 7 || cornerIndex == 10){
              //newGoon2 = new Mob(currentTile.getX() + 75, currentTile.getY() + 25, 50, "standard", map);
              //newGoon3 = new Mob(currentTile.getX() + 25, currentTile.getY() + 75, 50, "standard", map);
              if(cornerIndex == 2 || cornerIndex == 10){
                newGoon1.changeDirection((float)0, (float)2, cornerIndex);
                //newGoon3.changeDirection((float)0, (float)2, cornerIndex);
              }
            }else if (cornerIndex == 4){
              //newGoon2 = new Mob(currentTile.getX() + 75, currentTile.getY() + 25, 50, "standard", map);
              //newGoon3 = new Mob(currentTile.getX() + 25, currentTile.getY() - 25, 50, "standard", map);
              newGoon1.changeDirection((float)0, (float)2, cornerIndex);
              //newGoon3.changeDirection((float)0, (float)2, cornerIndex);
            }else if (currentGoon.getVelocity().x == 0){
              //newGoon2 = new Mob(currentTile.getX() + 25, currentTile.getY() - 25, 50, "standard", map);
              //newGoon3 = new Mob(currentTile.getX() + 25, currentTile.getY() + 75, 50, "standard", map);
              if (currentGoon.getVelocity().y == 2){
                newGoon1.changeDirection((float)0, (float)2, cornerIndex);
                //newGoon2.changeDirection((float)0, (float)2, cornerIndex);
               // newGoon3.changeDirection((float)0, (float)2, cornerIndex);
              }else{
                //newGoon1.changeDirection((float)0, (float)-2, cornerIndex);
                //newGoon2.changeDirection((float)0, (float)-2, cornerIndex);
                //newGoon3.changeDirection((float)0, (float)-2, cornerIndex);
              }
            }
            goonList.add(newGoon1);
            //goonList.add(newGoon2);
            //goonList.add(newGoon3);
            currentGoon.breakMob();
          }*/
          currentGoon.getCurrentTile().removeEntity();
          if (goonList.get(i).getHealth() != 0 && goonList.get(i).getX() > map.getMapWidth() || goonList.get(i).getY() > map.getMapLength()){
            baseHP -= currentGoon.getHealth();
            goonList.get(i).applyDamage(100000000);
          }
        }
          //if (goonList.size() > 1){
          //  goonList.remove(currentGoon);
          //  System.out.println("bruh");
          //}
        int hasCorner = map.findCorner(goonList.get(i).getX() - 25, goonList.get(i).getY() - 25);
        if(hasCorner != -1){
          xDiff = map.getCorner(goonList.get(i).getCorner() + 1).getX() - map.getCorner(goonList.get(i).getCorner()).getX();
          yDiff = map.getCorner(goonList.get(i).getCorner()).getY() - map.getCorner(goonList.get(i).getCorner()).getY();
          goonList.get(i).changeDirection(map.getCorner(goonList.get(i).getCorner() + 1).getX() - map.getCorner(goonList.get(i).getCorner()).getX(), map.getCorner(goonList.get(i).getCorner() + 1).getY() - map.getCorner(goonList.get(i).getCorner()).getY(), goonList.get(i).getCorner());
          goonList.get(i).changeCorner();
        }
      }
      fill(0);
      text(goonList.get(0).getX() + "," + goonList.get(0).getY(), 20, 20);
      if(!activeWave){
        goonList = new ArrayList<Mob>();
      }
    }
  }else{
    fill(255,0,0);
    textSize(100);
    text("GAME OVER", 550, 450);
  }
    textSize(30);
    fill(255,0,0);
    text("HP: "+baseHP, 1375, 45); 
    fill(133,187,101);
    text("Cash: $"+cash, 1375, 100);
    fill(0);
    text("Towers: ", 1375, 155);
    if (overPencilLauncherButton()){
      Pencil_LauncherImage.resize(TowerButtonSize+10,TowerButtonSize+10);
    }else{
      Pencil_LauncherImage.resize(TowerButtonSize,TowerButtonSize);
    }
    image(Pencil_LauncherImage,Pencil_LauncherX,Pencil_LauncherY);
    if (overRulerPoliceButton()){
      Ruler_PoliceImage.resize(TowerButtonSize+10,TowerButtonSize+10);
    }else{
      Ruler_PoliceImage.resize(TowerButtonSize,TowerButtonSize);
    }
    image(Ruler_PoliceImage,Ruler_PoliceX,Ruler_PoliceY);
    //square(1375,300,TowerButtonSize);
    //square(1485,300,TowerButtonSize);
    fill(0);
    text("Current Tower: ", 1375, 440);
    text(TOWER_PLACING, 1375, 470);
    if (TOWER_MODE != 0){
      for (int i = 0; i < TOWER_STATS[TOWER_MODE].length; i++){
        text(TOWER_STATS[0][i] + TOWER_STATS[TOWER_MODE][i], 1375, 500 + (i*35));
      }
    }
    text("Wave: " + wave, 1375, 650);
    text("Active Wave: ", 1375, 680);
    text(""+activeWave, 1375, 710);
    if (overStartButton()){
      fill(0, 180, 0);
    }else{
      fill(0, 150, 0);
    }
    rect(startX, startY, startL, startW);
    fill(0);
    text("START", 1435, 800);
}


boolean overStartButton(){
  if (mouseX >= startX && mouseX <= startX+startL && mouseY >= startY && mouseY <= startY+startW){
    return true;
  }else{
    return false;
  }
}
  
boolean overPencilLauncherButton(){
  if (mouseX >= Pencil_LauncherX && mouseX <= Pencil_LauncherX+TowerButtonSize && mouseY >= Pencil_LauncherY && mouseY <= Pencil_LauncherY+TowerButtonSize){
    return true;
  }else{
    return false;
  }
}

boolean overRulerPoliceButton(){
  if (mouseX >= Ruler_PoliceX && mouseX <= Ruler_PoliceX+TowerButtonSize && mouseY >= Ruler_PoliceY && mouseY <= Ruler_PoliceY+TowerButtonSize){
    return true;
  }else{
    return false;
  }
}
