public class Upgrade{
  String upgradeName;
  float addDamage, addRadius, addAttackSpeed, upgradeCost;
  public Upgrade(String name, float addD, float addR, float addAS, float cost){
    upgradeName = name;
    addDamage = addD;
    addRadius = addR;
    addAttackSpeed = addAS;
    upgradeCost = cost;
  }
  
  public String getUpgradeName(){
    return upgradeName;
  }
  public float getAddDamage(){
    return addDamage;
  }
  
  public float getAddRadius(){
    return addRadius;
  }
  
  public float getAddAttackSpeed(){
    return addAttackSpeed;
  }
  
  public float getUpgradeCost(){
    return upgradeCost;
  }
}
