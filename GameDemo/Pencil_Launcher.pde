public class Pencil_Launcher extends Tower{
  public Pencil_Launcher(float x, float y,Map map){
    super(x,y,map);
    towerName = "Pencil Launcher";
    damage = 2;
    radius = 4;
    attackSpeed = 1;
    cost = 300;
    cooldown = (int)(attackSpeed*60);
    towerImage = loadImage("Pencil_Launcher.png");
    projectileImage = loadImage("Pencil.png");
    projectileImage.resize(100,75);
    upgrades = new ArrayList<Upgrade>();
    upgrades.add(new Upgrade("Sharper Pencils", 1, 0, 0, 200));
    upgrades.add(new Upgrade("Faster Pencils", 1, 1, 0.25, 400));
    upgrades.add(new Upgrade("Tougher Wood", 2, 1, 0, 1000));
    upgrades.add(new Upgrade("Ticonderoga King", 3, 2, 0.25, 2000));
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
