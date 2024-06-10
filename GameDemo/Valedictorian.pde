public class Valedictorian extends Tower{
  public Valedictorian(float x, float y,Map map){
    super(x,y,map);
    towerName = "Valedictorian";
    damage = 2;
    radius = 4;
    attackSpeed = 0.1;
    cost = 2000;
    cooldown = (int)(attackSpeed*60);
    towerImage = loadImage("Valedictorian.png");
    projectileImage = loadImage("Diploma.png");
    projectileImage.resize(50,35);
    upgrades = new ArrayList<Upgrade>();
    upgrades.add(new Upgrade("Stronger Seals", 1, 0, 0, 500));
    upgrades.add(new Upgrade("Aerodynamic Diploma", 1, 1, 0, 1000));
    upgrades.add(new Upgrade("GPAMaxxing", 2, 2, 0, 2000));
    upgrades.add(new Upgrade("Off To Harvard", 3, 4, 0.05, 5000));
    currentUpgrade = upgrades.get(upgradeNum);
  }

  public void attack(){
      Mob targetMob = findMob();
      targetMob.applyDamage((int)damage);
      //return true;
  }
  
  public void display(){
    if (placed){
      towerImage.resize(70,70);
      image(towerImage,coordX-10,coordY-10);
    }
  }
}
