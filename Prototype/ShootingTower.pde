public class ShootingTower extends DefenceTower {
  int lastShotTime;

    public ShootingTower(int x, int y, int sprite, String name, int projectile){
        super(x, y, name, projectile);
        this.spriteIndex = sprite; // For image rendering
        this.lastShotTime = 0;
        determineProjectileImage();
    }
    
    public void assignIntialProperties(){
      currentUpgradeLevel = 0;
      cost = properties[0][0];
      projectileType = properties[1][0];
      damageCapability = properties[2][0];
      shotsPerSec = properties[3][0];
      range = properties[4][0];
    }
    
    @Override
    void upgradeTower(){
      if (this.currentUpgradeLevel < 3){ // If there are more possible upgrades
        if (currentGame.getCoins() >= properties[0][this.currentUpgradeLevel+1]){ // If player can afford the upgrade
            int oldProjectile = properties[1][this.currentUpgradeLevel];
            this.currentUpgradeLevel++;
            currentGame.spendCoins(properties[0][this.currentUpgradeLevel]);
            this.projectileType = properties[1][this.currentUpgradeLevel];
            this.damageCapability = properties[2][this.currentUpgradeLevel];
            this.shotsPerSec = properties[3][this.currentUpgradeLevel];
            this.range = properties[4][this.currentUpgradeLevel];
          
            if (oldProjectile != properties[1][this.currentUpgradeLevel]){ 
               // If its a tower that shoots load the new image for the new projectile
               determineProjectileImage();
            }
         }
      } 
   }
 
    @Override
    public void shoot(){
        float shotInterval = 1000.0f / this.shotsPerSec; // Find the interval at which the tower shoots
        
        Germ target = findTarget();
        if (target != null && ((millis() - this.lastShotTime) >= shotInterval)){ // If there is a valid target and its time to shoot
          // If the tower has the right projectile type to deal damage to it
          if (this.projectileType >= target.getRequiredProjectile()){
            Projectile p = new Projectile(projectileImage, this.damageCapability, target, ((this.positionX+0.5)*cellSize), ((this.positionY+0.5)*cellSize));
            p.drawShooting();
            AllProjectiles.add(p);
            this.lastShotTime = millis();
          }
        }
    }  
  
    Germ findTarget(){
       // Target germ = the germ furthest along the path, which is in range   .
       Germ target = null;
    
       for (int x = 0; x < AllGerms.size(); x++){ // Search through each germ, starting with the furthest along the path
           Germ current = AllGerms.get(x);
           
           // Adapt the germ positions to match cell of the array
           int germX = (int)(current.getGermX() / cellSize); 
           int germY = (int)(current.getGermY() / cellSize);
        
           // Calculate the distance between germ and tower
           double ac = Math.abs(germY - this.positionY);
           double cb = Math.abs(germX - this.positionX);
           double distance = Math.sqrt((ac*ac) + (cb*cb)); // Find the distance between the Tower and current germ
        
           if (distance <= this.range){ // If the current germ is within range,
               return current; // It is the tower's target
           }  
      }
      return target;
    }

}
