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
  }
  public Mob findMob(){
    for (int i = path.size()-1; i >= 0; i--){
      PathTile pathTile = path.get(i);
      if (pathTile.hasEntity()){
        if (Math.abs(tileX - pathTile.getTileX()) <= radius && Math.abs(tileY - pathTile.getTileY()) <= radius){
          return pathTile.getMob();
        }
      }
    }
    return null;
  }
  public void attack(){
    if (findMob() != null){
      Mob targetMob = findMob();
      moveProjectile(targetMob);
      targetMob.applyDamage((int)damage);
      //System.out.println(targetMob.getHealth());
    }
  }
  
  public void display(){
    if (placed){
      towerImage.resize(70,70);
      image(towerImage,coordX,coordY);
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
