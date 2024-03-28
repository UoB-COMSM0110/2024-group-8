public class TowerB extends ShootingTower {

    protected TowerB(int x, int y, int sprite, Runner runner) {
        super(x, y, sprite, "Tower B", runner);

        // Array to hold the properties of an instance of TowerB, throught it's upgrade stages:
        this.properties = new int[][]{
                {75, 150, 225, 300}, // Cost from intial to Upgrade 3
                {1, 1, 1, 1}, // Projectile type
                {2, 2, 2, 5}, // Damage Capability
                {3, 3, 5, 5}, // Shots fired per second
                {3, 5, 5, 5}  // Range
        };
        assignIntialProperties();
    }

    public void assignIntialProperties() {
        currentUpgradeLevel = 0;
        cost = properties[0][0];
        projectileType = properties[1][0];
        damageCapability = properties[2][0];
        shotsPerSec = properties[3][0];
        range = properties[4][0];
    }

    @Override
    String getNextUpgradeAsString() {
        switch (currentUpgradeLevel) {
            case 0:
                return " WIDER RANGE";
            case 1:
                return " MORE SHOTS";
            case 2:
                return "MORE DAMAGE";
            case 3:
                return "NO MORE UPGRADES";
            default:
                return "NO MORE UPGRADES";
        }
    }

}
