import processing.core.*;

import java.util.ArrayList;

public class GameMap {
    Runner runner;
  /*
     Starting point for the GameMap class
     Still need to:
       - Make unique paths for each map that follow the background runner.image nicely
       - Implement final boss for each map
       - Implement twist for each map
  */

    // Resizes the screen so that there is a play window and a menu bar below
    float playWindowHeight;
    float cellSize;
    float menuPosY;
    float menuHeight;

    PImage background;
    PImage path;
    PImage pathMask;

    PImage towerA;
    PImage towerB;

    PImage lastClickedTowerImage; // Stores whichever tower was last pressed
    DefenceTower lastClickedTower; // So you can see its stats/delete it in gameWindow
    int timeOfLastUpgrade = 0;

    PressableButton towerAButton;
    PressableButton towerBButton;
    PressableButton startRoundButton;

    // Variables for tower buying animation
    DefenceTower selectedTower;
    boolean towerSelected = false;
    boolean placingTower = false;
    PImage selectedTowerImage;
    int selectedTowerCost = 0;

    public GameMap(Runner runner) {
        this.runner = runner;
        playWindowHeight = (float) (runner.WIDTH * 0.65);
        cellSize = (float) runner.WIDTH / 20;
        menuPosY = playWindowHeight + 1;
        menuHeight = (runner.HEIGHT - menuPosY) - 10;
    }

    public void setup() {
        // Initialize grid
        for (int x = 0; x < runner.Grid.length; x++) {
            for (int y = 0; y < runner.Grid[0].length; y++) {
                runner.Grid[x][y] = new Cell(x, y, runner);
            }
        }

        initialisePath();

        //try {
        this.background.resize(runner.WIDTH, runner.HEIGHT);
        path = runner.loadImage("data/whiteBG.png");
        path.resize(runner.WIDTH, runner.HEIGHT);
        pathMask = runner.loadImage("data/route.png");
        pathMask.resize(runner.WIDTH, runner.HEIGHT);
        path.mask(pathMask);

        towerA = runner.TowerSprites[0];
        towerB = runner.TowerSprites[1];
//        } catch (Exception e) {
//           System.out.println("Error loading runner.image GameMap: " + e.getMessage());
//        }
    }

    public void draw() {
        runner.background(153, 204, 255);
        runner.image(background, 0, 0, runner.WIDTH, playWindowHeight);
        runner.image(path, 0, 0, runner.WIDTH, playWindowHeight);

        drawGameWindow();

        // Assign winnings:
        if (runner.currentRound != null && !runner.currentRound.inProgress()) { // If the round has finished and the player hasn't received their winnings yet, give winnings
            if (!runner.currentRound.getReceivedEarnings()) {
                runner.currentGame.earnCoins(runner.currentRound.getEarningsForCompletion());
                runner.currentRound.setReceivedEarnings(true);
            }
        }

        // Draw all towers:
        for (DefenceTower tower : runner.AllTowers) {
            tower.drawTower();
        }

        // Move germs and store those about to be deleted:
        ArrayList<Germ> germsToLeak = new ArrayList<>(); // THIS IS NECESARRY TO AVOID CONCURRENT MODIFICATION EXCEPTION DO NOT DELETE

        for (Germ germ : runner.AllGerms) {
            germ.move();
            if (germ.isLeaked()) {
                germsToLeak.add(germ);
                runner.currentGame.subtractLife();
            }
        }

        for (Germ germToLeak : germsToLeak) {
            runner.AllGerms.remove(germToLeak);
        }

        if (checkForSelectedTower()) {
            towerSelected = true;
        }
        if (placingTower) {
            placeTower();
        }


        // Handle towerPresses for Towerinfo/sale
        checkForPlacedTowerPresses();

        // Run current round
        if (runner.currentRound != null && runner.currentRound.inProgress()) {
            runner.currentRound.run();
        }

        // Navigate to win screen if necessary
        if (runner.currentGame.getRoundCounter() == runner.currentGame.getTotalRounds() && !(runner.currentRound.inProgress()) && runner.AllGerms.size() <= 0) { // If the final round is fully completed
            runner.winScreen.setup();
            runner.currentGameState = GameState.WON;
        }

        // If you press start round, and no round is in progress it will start the round
        if (runner.mousePressed && startRoundButton.onButton() && runner.currentGame.getRoundCounter() < runner.currentGame.getTotalRounds()) { // Change the roundCounter condition for RunningGame.getNumberOfRounds() later on
            runner.currentGame.selectRound();
        }

        if (runner.currentGame.getCurrentLives() <= 0) {
            runner.loseScreen.setup();
            runner.currentGameState = GameState.LOST;
        }
    }

    public void drawGameWindow() {
        // Game Window:
        runner.strokeWeight(8);
        runner.strokeJoin(runner.ROUND);
        runner.stroke(255);
        runner.noFill();
        runner.rect(10, menuPosY, (runner.WIDTH - 20), menuHeight);

        // Tower Buttons:
        runner.rect(10, menuPosY, 70, 70);
        runner.image(towerA, 20, (menuPosY + 10), 50, 50);
        towerAButton = new PressableButton(10, (int) menuPosY, 70, 70, runner);

        runner.rect(10, (menuPosY + 68), 70, 70);
        runner.image(towerB, 20, (menuPosY + 78), 50, 50);
        towerBButton = new PressableButton(20, (int) (menuPosY + 78), 70, 70, runner);

        runner.rect(80, menuPosY, 70, 70);
        // Tower C button

        runner.rect(80, (menuPosY + 68), 70, 70);
        // Tower D button

        // GameStats:
        String livesCounter = "LIVES: " + runner.currentGame.getCurrentLives();
        runner.fill(255);
        runner.textSize(30);
        runner.text(livesCounter, 815, 50);

        String coinsCounter = "COINS: " + runner.currentGame.getCoins();
        runner.text(coinsCounter, 805, 80);

        if (towerSelected) {
            selectedTowerImage = runner.TowerSprites[selectedTower.spriteIndex];
            selectedTowerImage.resize(75, 75);
            runner.image(selectedTowerImage, 170, (menuPosY + 50));
            runner.textSize(30);
            runner.text(selectedTower.name, 160, (menuPosY + 30));

            runner.noFill();
            runner.stroke(255);
            runner.rect(300, (menuPosY + 20), 250, 100);
            //// Tower Stats
            runner.textSize(20);
            runner.text("Range           ->    " + selectedTower.range, 310, (menuPosY + 45));
            runner.text("Damage       ->    " + selectedTower.damageCapability, 310, (menuPosY + 65));
            runner.text("Shots/sec   ->    " + selectedTower.shotsPerSec, 310, (menuPosY + 85));
            runner.text("Protein         ->    " + selectedTower.getProjectileTypeAsString(), 310, (menuPosY + 105));

            if (!placingTower) {
                // Buy button
                runner.fill(0, 128, 255);
                runner.stroke(0, 128, 255);
                runner.rect(620, (menuPosY + 30), 170, 75);
                PressableButton buyButton = new PressableButton(620, (int) (menuPosY + 30), 170, 75, runner);
                runner.fill(255);
                runner.textSize(30);
                runner.text("BUY", 670, (menuPosY + 60));
                if (selectedTower.getCost() <= runner.currentGame.getCoins()) {
                    runner.fill(0x00FF00);
                } else {
                    runner.fill(0xFF0000);
                }
                runner.text("Cost: " + selectedTower.getCost(), 650, (menuPosY + 90));
                if (runner.mousePressed && buyButton.onButton()) {
                    placingTower = true;
                }
            } else {
                // Cancel buy button
                runner.fill(0);
                runner.stroke(0);
                runner.rect(620, (menuPosY + 30), 170, 75);
                PressableButton cancelBuyButton = new PressableButton(620, (int) (menuPosY + 30), 170, 75, runner);
                runner.fill(255);
                runner.textSize(20);
                runner.text("PLACE HERE", 640, (menuPosY + 50));
                runner.text("TO CANCEL", 645, (menuPosY + 75));
                runner.text("PURCHASE", 650, (menuPosY + 100));
                if (runner.mousePressed && cancelBuyButton.onButton()) {
                    placingTower = false;
                    towerSelected = false;
                }
            }

            // Current tower window:
        } else if (lastClickedTower == null) {
            runner.textSize(30);
            runner.text("Press a placed tower to see it's stats", 170, (menuPosY + 40));
        } else {
            int towerX = (int) (lastClickedTower.getTowerX() * cellSize);
            int towerY = (int) (lastClickedTower.getTowerY() * cellSize);
            float towerRange = ((lastClickedTower.range * cellSize) * 2) + 1; // twice the cell range + 1 to account for the cell the tower lives in and then everything its range away
            runner.noFill();
            runner.stroke(255);
            runner.circle(towerX + (cellSize / 2), towerY + (cellSize / 2), towerRange); // Draw a circle to respresent the range of the tower before placing

            lastClickedTowerImage = runner.TowerSprites[lastClickedTower.spriteIndex];
            lastClickedTowerImage.resize(75, 75);
            runner.image(lastClickedTowerImage, 170, (menuPosY + 50));
            runner.textSize(30);
            runner.text(lastClickedTower.name, 160, (menuPosY + 30));

            runner.rect(300, (menuPosY + 20), 250, 100);
            runner.textSize(20);
            runner.text("Range           ->    " + lastClickedTower.range, 310, (menuPosY + 45));
            runner.text("Damage       ->    " + lastClickedTower.damageCapability, 310, (menuPosY + 65));
            runner.text("Shots/sec  ->    " + lastClickedTower.shotsPerSec, 310, (menuPosY + 85));
            runner.text("Protein         ->    " + lastClickedTower.getProjectileTypeAsString(), 310, (menuPosY + 105));

            if (lastClickedTower.currentUpgradeLevel < 3) {
                // Upgrade info & button
                runner.fill(0, 128, 255);
                runner.stroke(0, 128, 255);
                runner.rect(620, (menuPosY + 15), 170, 75);
                PressableButton upgradeButton = new PressableButton(620, (int) (menuPosY + 5), 170, 75, runner);
                if (runner.mousePressed && upgradeButton.onButton() && ((runner.millis() - timeOfLastUpgrade) > 2000)) {
                    lastClickedTower.upgradeTower();
                    timeOfLastUpgrade = runner.millis();
                }

                runner.fill(255);
                runner.text("UPGRADE", 655, (menuPosY + 40));
                runner.text(lastClickedTower.getNextUpgradeAsString(), 630, (menuPosY + 60));
                int upgradeCost = lastClickedTower.getUpgradeCost();
                if (upgradeCost <= runner.currentGame.getCoins()) {
                    runner.fill(0x00FF00);
                } else {
                    runner.fill(0xFF0000);
                }
                runner.text("Cost: " + upgradeCost, 665, (menuPosY + 80));
            }

            // Sell button
            runner.fill(0xFF0000);
            runner.stroke(0xFF0000);
            runner.strokeWeight(4);
            runner.rect(630, (menuPosY + 100), 150, 30);
            PressableButton sellButton = new PressableButton(630, (int) (menuPosY + 100), 150, 30, runner);
            runner.fill(255);
            int saleCost = lastClickedTower.getSaleCost();
            runner.text("SELL  ->  $" + saleCost, 645, (menuPosY + 122));

            if (runner.mousePressed && sellButton.onButton()) {
                runner.AllTowers.remove(lastClickedTower);
                runner.currentGame.earnCoins(saleCost);
                lastClickedTower = null;
            }
        }


        // Start Round/Round stats:
        if (runner.currentRound == null || !runner.currentRound.inProgress()) {
            runner.strokeWeight(8);
            runner.strokeJoin(runner.ROUND);
            runner.stroke(255);
            runner.noFill();
            runner.line(810, menuPosY + 5, 810, menuPosY + 135);
            runner.rect(815, menuPosY + 5, 170, 130);
            startRoundButton = new PressableButton(800, (int) menuPosY, 190, 340, runner);
            runner.fill(255);
            runner.textSize(40);
            runner.text("START", 835, (int) (menuPosY + 60));
            runner.text("ROUND", 825, (int) (menuPosY + 110));
        } else {
            runner.fill(255);
            runner.stroke(255);
            runner.line(815, menuPosY + 5, 815, menuPosY + 135);
            runner.textSize(40);
            runner.text("ROUND", 825, (int) (menuPosY + 40));
            runner.textSize(30);
            String currentRoundIndex = runner.currentGame.getCurrentRoundCounterAsString() + " / " + runner.currentGame.getTotalRounds();
            runner.text(currentRoundIndex, 865, (int) (menuPosY + 70));

            int timeLeft = runner.currentRound.getTimeRemainingInSecs();
            if (timeLeft > 0) {
                runner.textSize(20);
                runner.text("Time Remaining:", 830, (int) (menuPosY + 100));
                String timeRemaining = String.valueOf(timeLeft);
                runner.text(timeRemaining, 840, (int) (menuPosY + 125));
                runner.text(" Seconds!", 870, (int) (menuPosY + 125));
            } else if (timeLeft <= 0 && (runner.AllGerms.size() > 0)) { // If no more enemies to dispense, but still enemies on the grid
                runner.textSize(20);
                runner.text("No more germs ...", 825, (int) (menuPosY + 100));
                runner.text("... FOR NOW!", 850, (int) (menuPosY + 125));
            }
        }
    }


    public void initialisePath() {
        Vector[] path = new Vector[]{
                new Vector(0, 5),
                new Vector(3, 5),
                new Vector(3, 8),
                new Vector(1, 8),
                new Vector(1, 11),
                new Vector(9, 11),
                new Vector(9, 8),
                new Vector(6, 8),
                new Vector(6, 3),
                new Vector(10, 3),
                new Vector(10, 5),
                new Vector(11, 5),
                new Vector(11, 10),
                new Vector(14, 10),
                new Vector(14, 8),
                new Vector(17, 8),
                new Vector(17, 5),
                new Vector(13, 5),
                new Vector(13, 0),
        };

        runner.mapPath = new Path(path, runner);

    }

    public boolean checkForSelectedTower() {
        if (runner.mousePressed && towerAButton.onButton()) {
            selectedTower = new TowerA(0, 0, 0, runner);
            return true;
        }

        if (runner.mousePressed && towerBButton.onButton()) {
            selectedTower = new TowerB(0, 0, 1, runner);
            return true;
        }
        return false;
    }

    public void placeTower() {
        // Animation of moving tower when choosing location
        float towerRange = ((selectedTower.range * cellSize) * 2) + 1; // twice the cell range + 1 to account for the cell the tower lives in and then everything its range away
        runner.imageMode(runner.CENTER);
        runner.image(selectedTowerImage, runner.mouseX, runner.mouseY);
        runner.imageMode(runner.CORNER); // Set back to corner because all other runner.images are rendered in line w/CORNER mode
        runner.noFill();
        runner.stroke(255);
        runner.circle(runner.mouseX, runner.mouseY, towerRange); // Draw a circle to respresent the range of the tower before placing

        int currentGridX = (int) (runner.mouseX / cellSize);
        int currentGridY = (int) (runner.mouseY / cellSize);

        try {
            if (runner.mousePressed && runner.Grid[currentGridX][currentGridY].buildable()) {
                selectedTower.setTowerX(currentGridX);
                selectedTower.setTowerY(currentGridY);
                runner.Grid[currentGridX][currentGridY].buildOn(selectedTower);
                runner.currentGame.spendCoins(this.selectedTowerCost);
                this.selectedTowerCost = 0;
                towerSelected = false;
                placingTower = false;
            }
        } catch (ArrayIndexOutOfBoundsException e) { // Necessary to handle pressing off grid when tower selected
            System.out.println("Can't build there!");
        }
    }

    public void checkForPlacedTowerPresses() {
        if (runner.mousePressed) {
            int x = (int) (runner.mouseX / cellSize);
            int y = (int) (runner.mouseY / cellSize);
            if (x < runner.Grid.length && y < runner.Grid[0].length) {
                for (DefenceTower t : runner.AllTowers) {
                    if (t.positionX == x && t.positionY == y) {
                        System.out.println("Found the lastClickedTower");
                        lastClickedTower = t;
                        towerSelected = false;
                    }
                }
            }
        }
    }
}
