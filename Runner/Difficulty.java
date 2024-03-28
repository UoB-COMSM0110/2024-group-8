public enum Difficulty {
    // Definition of each difficulty and what you start with
    EASY(100, 5, 200),   // ( Start Lives ; Number of Rounds ; Start Coins)
    MEDIUM(70, 10, 150),
    HARD(40, 20, 100);

    private int numberOfRounds;
    private int numberOfLives;
    private int numberOfCoins;

    Difficulty(int numberOfLives, int numberOfRounds, int numberOfCoins) {
        this.numberOfLives = numberOfLives;
        this.numberOfRounds = numberOfRounds;
        this.numberOfCoins = numberOfCoins;
    }

    public int getNumberOfLives() {
        return numberOfLives;
    }

    public int getNumberOfRounds() {
        return numberOfRounds;
    }

    public int getNumberOfCoins() {
        return numberOfCoins;
    }
}
