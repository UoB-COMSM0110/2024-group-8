import processing.core.*;

public class TitleScreen extends Display {
    PImage startPageBackground;
    boolean isStartButtonHovered = false; // Track if the start button is being hovered over
    float titleX; // X position of the title for animation
    float titleY; // Y position of the title for animation
    float titleTargetX; // Target X position of the title for animation
    float titleTargetY; // Target Y position of the title for animation
    float titleSpeed = 5; // Speed of title animation (increased)
    PImage germL;
    PImage germR;

    TitleScreen(Runner runner) {
        super(runner);
    }

    public void setup() {
        startPageBackground = runner.loadImage("data/startpage.png");
        startPageBackground.resize(runner.WIDTH, runner.HEIGHT); // Resize the image to match window dimensions

        // Load germ image
        runner.germ = runner.loadImage("data/germ.png");
        runner.germ.resize(20, 20);
        // Set initial position for the germ character
        runner.germX = (float) runner.width / 2;
        runner.germY = (float) runner.height / 2;

        // Set initial position for the title
        titleX = -500; // Offscreen initially
        titleY = (float) runner.HEIGHT / 4;
        titleTargetX = (float) runner.WIDTH / 8 - 50;
        titleTargetY = (float) runner.HEIGHT / 4;

        germL = runner.loadImage("data/germ/germ4L.png");
        germL.resize(runner.WIDTH / 5, runner.HEIGHT / 5);
        germR = runner.loadImage("data/germ/germ4R.png");
        germR.resize(runner.WIDTH / 5, runner.HEIGHT / 5);
    }

    public void draw() {
        runner.background(startPageBackground);
        runner.image(runner.germ, runner.germX, runner.germY);
        runner.textFont(runner.font);
        runner.textSize(80);
        runner.fill(255);

        // Animate the title
        if (titleX < titleTargetX) {
            titleX += titleSpeed; // Move towards the target X position
        }
        if (titleY != titleTargetY) {
            titleY = titleTargetY; // Ensure Y position matches the target Y position
        }

        runner.text("Immune System Defence", titleX, titleY);

        StateChangingButton startButton = new StateChangingButton(runner.WIDTH / 2 - 100, runner.HEIGHT / 2, 200, 60, GameState.MAP, runner);
        runner.stateChangingButtons.add(startButton);

        //Draw start button with animation
        if (startButton.onButton()) {
            runner.fill(173, 224, 255); // Lighter color when hovered over
            //runner.image(germR, runner.WIDTH/2 - 350, runner.HEIGHT/2);
        } else {
            runner.fill(153, 204, 255);
            //runner.image(germL, runner.WIDTH/2 - 350, runner.HEIGHT/2);
        }

        runner.strokeWeight(8);
        runner.strokeJoin(runner.ROUND);
        runner.stroke(153, 204, 255);
        runner.rect((float) runner.WIDTH / 2 - 100, (float) runner.HEIGHT / 2, 200, 60);

        runner.fill(255);
        runner.textSize(40);
        runner.text("START", (float) runner.WIDTH / 2 - 62, (float) runner.HEIGHT / 2 + 42);
    }

}
