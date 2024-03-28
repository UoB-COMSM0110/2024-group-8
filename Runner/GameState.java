public enum GameState {
    // Different phases of the game, so program knows what to draw
    TITLE,
    MAP,
    WON,
    LOST, // Will be lose screen when implemented
    // RULES, // Will be the "How to play" screen, can be navigated to at anytime before win/lose screen
    BRAIN,
    LUNG,
    HEART,
    KIDNEY;

    public boolean isGameMap() {
        return this == BRAIN || this == LUNG || this == HEART || this == KIDNEY;
    }
}
