public class Cell {
    Runner runner;
    int x;
    int y;
    boolean isPath = false;
    boolean buildable = true;

    Cell(int x, int y, Runner runner) {
        this.runner = runner;
        this.x = x;
        this.y = y;
    }

    DefenceTower occupant;

    void buildOn(DefenceTower t) {
        if (buildable() && !runner.gameWindow.onButton()) {
            this.occupant = t;
            System.out.println("Adding an occupant to: Grid[" + x + "][" + y + "]");
            runner.AllTowers.add(occupant);
            this.buildable = false;
        }
    }

    boolean buildable() {
        return (this.buildable && !this.isPath);
    }

    void outline() {
        runner.noFill();
        runner.strokeWeight(4);

        if (buildable()) {
            runner.stroke(0x00FF00);
        } else {
            runner.stroke(0xFF0000);
        }
        runner.rect(x * runner.cellSize, y * runner.cellSize, runner.cellSize, runner.cellSize);
    }

    void outlineSpecificColour(int colourR, int colourG, int colourB) {
        runner.noFill();
        runner.strokeWeight(4);
        runner.stroke(colourR, colourG, colourB);
        runner.rect(x * runner.cellSize, y * runner.cellSize, runner.cellSize, runner.cellSize);
    }

    void confetti(int confetti, int outline) { // For the win screen, colours random changing bright colours on screen
        runner.fill(confetti);
        runner.strokeJoin(runner.ROUND);
        runner.strokeWeight(4);
        runner.stroke(outline);
        runner.rect(x * runner.cellSize, y * runner.cellSize, runner.cellSize, runner.cellSize);
    }

    void setUnbuildable() { // Called where a tower has been built
        this.buildable = false;
    }

    void setPath(Vector v) { // Set the pathway at the start of the round
        runner.Grid[v.x][v.y].isPath = true;
    }

}
