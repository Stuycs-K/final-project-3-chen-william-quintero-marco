public class Ruler_Police extends Tower{
  public Ruler_Police(float x, float y,Map map){
    super(x,y,map);
    towerName = "Ruler Police";
    damage = 1;
    radius = 1;
    attackSpeed = 0.5;
    cost = 200;
    cooldown = (int)(attackSpeed*60);
    towerImage = loadImage("Ruler_Police.png");
    projectileImage = loadImage("Ruler.png");
    projectileImage.resize(25,75);
    upgrades = new ArrayList<Upgrade>();
    upgrades.add(new Upgrade("Sharper Ruler", 1, 0, 0, 100));
    upgrades.add(new Upgrade("Police Training", 1, 0, 0, 300));
    upgrades.add(new Upgrade("Hardened Plastic", 1, 0, 0.10, 750));
    upgrades.add(new Upgrade("School Riot Gear", 2, 1, 0.15, 1500));
    currentUpgrade = upgrades.get(upgradeNum);
  }
  
  
  public void attack(){
      Mob targetMob = findMob();
      //moveProjectile(targetMob);
      targetMob.applyDamage((int)damage);
      targetMob.changeVelocity(1);
      //System.out.println(targetMob.getHealth());
  }
  
  
  public void display(){
    if (placed){
      towerImage.resize(70,70);
      image(towerImage,coordX-10,coordY-10);
    }
  }
}
