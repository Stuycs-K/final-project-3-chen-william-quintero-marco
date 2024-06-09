public class Ruler_Police extends Tower{
  public Ruler_Police(float x, float y,Map map){
    super(x,y,map);
    towerName = "Ruler Police";
    damage = 2;
    radius = 1;
    attackSpeed = 0.5;
    cost = 200;
    cooldown = (int)(attackSpeed*60);
    towerImage = loadImage("Ruler_Police.png");
    upgrades = new ArrayList<Upgrade>();
    upgrades.add(new Upgrade("Sharper Ruler", 2, 0, 0, 100));
    upgrades.add(new Upgrade("Police Training", 2, 0, 0.10, 300));
    upgrades.add(new Upgrade("Hardened Plastic", 3, 0, 0, 750));
    upgrades.add(new Upgrade("THIS IS AMERICA!", 5, 1, 0.15, 1500));
    currentUpgrade = upgrades.get(upgradeNum);
  }
  
  
  public boolean attack(){
    if (findMob() != null){
      Mob targetMob = findMob();
      moveProjectile(targetMob);
      targetMob.applyDamage((int)damage);
      targetMob.changeVelocity(1);
      //System.out.println(targetMob.getHealth());
      return true;
    }
    return false;
  }
  
  
  public void display(){
    if (placed){
      towerImage.resize(70,70);
      image(towerImage,coordX-10,coordY-10);
    }
  }
  
  public void moveProjectile(Mob targetMob){
    PVector rulerPos = new PVector(coordX, coordY);
    PVector mobPos = new PVector(targetMob.getX(), targetMob.getY());
    PVector direction = PVector.sub(mobPos, rulerPos);
    PVector velocity = new PVector(0,0);
    direction.normalize();
    velocity.add(direction);
    rulerPos.add(velocity);
    displayProjectile(rulerPos.x,rulerPos.y);
  }
  
  public void displayProjectile(float x, float y){
    fill(0,255,0);
    noStroke();
    rect(x,y,20,70);
  }
}
