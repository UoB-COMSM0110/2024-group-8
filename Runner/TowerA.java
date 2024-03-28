public class TowerA extends ShootingTower {

    protected TowerA(int x, int y, int sprite, Runner runner) {
        super(x, y, sprite, "Tower A", runner);
        // Array to hold the properties of an instance of TowerA, throught it's upgrade stages:
        this.properties = new int[][]{{50, 100, 150, 200}, // Cost from intial to Upgrade 3
                {0, 0, 0, 2}, // Projectile type
                {1, 1, 3, 3}, // Damage Capability
                {1, 1, 1, 3}, // Shots fired per second
                {2, 3, 3, 3}  // Range
        };

        assignInitialProperties();
    }

    public void assignInitialProperties() {
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
                return "MORE DAMAGE";
            case 2:
                return "FLAME PROTEIN";
            case 3:
                return "NO MORE UPGRADES";
            default:
                return "NO MORE UPGRADES";
        }
    }
}
    
