public class Ruler_Police extends Tower{
  public Ruler_Police(float x, float y,Map map){
    super(x,y,map);
    towerName = "Ruler Police";
    damage = 5;
    radius = 2;
    attackSpeed = 0.5;
    cost = 200;
    cooldown = (int)(attackSpeed*60);
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
      //targetMob.applyDamage((int)damage);
      targetMob.changeVelocity(2);
      //System.out.println(targetMob.getHealth());
    }
  }
  
  
  public void display(){
    if (placed){
      PImage student = loadImage("Ruler_Police.png");
      student.resize(70,70);
      image(student,coordX,coordY);
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
