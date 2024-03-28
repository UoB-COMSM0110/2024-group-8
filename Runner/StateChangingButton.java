public class StateChangingButton extends PressableButton {
    GameState requiredGameState;
    GameState desiredStateOnPress;


    StateChangingButton(int x, int y, int buttonWidth, int buttonHeight, GameState desired, Runner runner) {
        super(x, y, buttonWidth, buttonHeight, runner);
        this.requiredGameState = runner.currentGameState;
        this.desiredStateOnPress = desired;
    }

    void changeStates() {
        if (this.onButton() && (runner.currentGameState == this.requiredGameState)) {
            runner.currentGameState = desiredStateOnPress;
        }
    }
}
