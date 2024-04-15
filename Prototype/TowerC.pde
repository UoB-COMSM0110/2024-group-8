protected class TowerC extends DefenceTower { 
  //int mucusPerSec;
  int lastDispenseTime = 0;
  boolean toxicMucus = false;
  ArrayList<Cell> pathCellsInRange;

    protected TowerC(int x, int y, int sprite){
        super(x, y, "Mucus Dispenser", 0);
        this.spriteIndex = sprite; // For image rendering

        // Array to hold the properties of an instance of TowerC, throught it's upgrade stages:
        this.properties = new int[][] {
                    { 150, 100, 300, 400 }, // Cost from intial to Upgrade 3
                    { 0, 0, 0, 5 }, // Damage Capability
                    { 1, 1, 3, 3 }, // Mucus Dispensed per sec
                    { 1, 3, 3, 3 }  // Range
                }; 
        assignIntialProperties();
        pathCellsInRange = new ArrayList<>();
    }

    public void assignIntialProperties(){
      currentUpgradeLevel = 0;
      cost = properties[0][0];
      damageCapability = properties[1][0];
      shotsPerSec = properties[2][0];
      mucusPerSec = properties[2][0];
      range = properties[3][0];
    }
    
    @Override
    void upgradeTower(){
      if (this.currentUpgradeLevel < 3){ // If there are more possible upgrades
        if (currentGame.getCoins() >= properties[0][this.currentUpgradeLevel+1]){ // If player can afford the upgrade
          this.currentUpgradeLevel++;
          currentGame.spendCoins(properties[0][this.currentUpgradeLevel]);
          cost = properties[0][this.currentUpgradeLevel];
          damageCapability = properties[1][this.currentUpgradeLevel];
          shotsPerSec = properties[2][this.currentUpgradeLevel];
          mucusPerSec = properties[2][this.currentUpgradeLevel];
          range = properties[3][this.currentUpgradeLevel];
          findPathCellsInRange();
       }
      }  
    }
    
    @Override
    String getNextUpgradeAsString(){
      switch (currentUpgradeLevel) {
        case 0: 
             return " WIDER RANGE";
        case 1: 
             return " MORE MUCUS";
        case 2: 
             return "TOXIC MUCUS";
        case 3: 
             return "NO MORE UPGRADES";
        default: 
             return "NO MORE UPGRADES";  
      }
    }
    
    @Override
    void shoot(){
      if (pathCellsInRange.isEmpty()){ findPathCellsInRange(); } 
      
      float dispenseInterval = 1000.0f / this.mucusPerSec; // Find the interval at which the tower dispenses mucus
      
      if (currentUpgradeLevel >= 3){ toxicMucus = true; }
      
      if ((millis() - this.lastDispenseTime) >= dispenseInterval){
        try {
            Cell nextCell = findNextAvailableCell(5);
            Mucus newMucus = new Mucus(nextCell.x, nextCell.y, toxicMucus);
            AllMucus.add(newMucus);
            this.lastDispenseTime = millis();
        } catch (Exception e) {}  
      }
    }
    
    void findPathCellsInRange(){
      for (int i = Math.max(0, positionX - range); i <= Math.min(Grid.length - 1, positionX + range); i++){
           for (int j = Math.max(0, positionY - range); j <= Math.min(Grid[i].length - 1, positionY + range); j++){
                if (Grid[i][j].isPath){ // Find the all path cells in range 
                  if (!pathCellsInRange.contains(Grid[i][j])){
                    pathCellsInRange.add(Grid[i][j]);
                  }
                }
           } 
       }  
    }
    
    Cell findNextAvailableCell(int attempts){       
        // Pick a random path cell for the range
        if (pathCellsInRange.isEmpty() || attempts <= 0){
          return null;
        } else {
          int randomIndex = (int)random(0, pathCellsInRange.size());
          if (!pathCellsInRange.get(randomIndex).containsMucus){
            pathCellsInRange.get(randomIndex).setContainsMucus(toxicMucus, true);
            return pathCellsInRange.get(randomIndex);
          } else {
            return findNextAvailableCell(attempts-1);
          }
        }
    }
    
}



class Mucus {
  PImage mucus;
  boolean toxic;
  boolean onScreen;
  int timeOfCreation;
  int duration = 5000;
  int x;
  int y;
  
  Mucus(int posX, int posY, boolean toxicity){
    onScreen = true;
    timeOfCreation = millis();
    toxic = toxicity;
    x = posX;
    y = posY;
    if (toxic){ mucus = loadImage("toxicMucus.png"); } else { mucus = loadImage("mucus.png"); }
  }
  
  void drawMucus(){
    if ((millis() - timeOfCreation) <= duration){
      image(mucus, (x*cellSize), (y*cellSize), cellSize, cellSize);
    } else {
      Grid[x][y].setContainsMucus(toxic, false);
      onScreen = false;
    }
  }
  
  
}
