public class Pencil_Launcher extends Tower{
  public Pencil_Launcher(float x, float y,Map map){
    super(x,y,map);
    towerName = "Pencil Launcher";
    damage = 3;
    radius = 5;
    attackSpeed = 1;
    cost = 300;
    cooldown = (int)(attackSpeed*60);
    towerImage = loadImage("Pencil_Launcher.png");
    upgrades = new ArrayList<Upgrade>();
    upgrades.add(new Upgrade("Sharper Pencils", 3, 0, 0, 200));
    upgrades.add(new Upgrade("Faster Pencils", 1, 1, 0.25, 400));
    upgrades.add(new Upgrade("Tougher Wood", 5, 1, 0, 1000));
    upgrades.add(new Upgrade("Ticonderoga King", 10, 5, 0.25, 2000));
    currentUpgrade = upgrades.get(upgradeNum);
  }

  public boolean attack(){
    if (findMob() != null){
      Mob targetMob = findMob();
      moveProjectile(targetMob);
      targetMob.applyDamage((int)damage);
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
    PVector pencilPos = new PVector(coordX, coordY);
    PVector mobPos = new PVector(targetMob.getX(), targetMob.getY());
    PVector direction = PVector.sub(mobPos, pencilPos);
    PVector velocity = new PVector(0,0);
    for (int i = 0; i < 50; i++){
      direction.normalize();
      velocity.add(direction);
      pencilPos.add(velocity);
      displayProjectile(pencilPos.x,pencilPos.y);
    }
  }
  
  public void displayProjectile(float x, float y){
    fill(255,255,0);
    noStroke();
    circle(x,y,10);
  }
  
}
