public class Round {
    Runner runner;
    float durationInSecs;
    float numberOfEnemies;
    float dispatchInterval; // Number of time between enemies to make sure they are dispatched at equal intervals
    boolean roundInProgress;

    int startTime;
    int lastShotTime;
    int lastEnemyDispatch;
    int elapsedTime;

    boolean receivedEarnings = false;
    float earningsForCompletion;

    Round(float duration, float enemyCount, int roundStartTime, float earnings, Runner runner) {
        this.runner = runner;
        this.durationInSecs = duration;
        this.numberOfEnemies = enemyCount;
        this.dispatchInterval = (duration * 1000) / enemyCount; // Calculate dispatch interval

        this.startTime = roundStartTime;
        this.lastShotTime = 0;
        this.lastEnemyDispatch = 0;
        this.elapsedTime = 0;
        this.roundInProgress = true;

        this.earningsForCompletion = earnings;
    }

    float getDurationInSecs() {
        return this.durationInSecs;
    }

    float getNumberOfEnemies() {
        return this.numberOfEnemies;
    }

    int getEarningsForCompletion() {
        return (int) this.earningsForCompletion;
    }

    boolean inProgress() {
        return this.roundInProgress;
    }

    void setInProgress(boolean inProgress) {
        this.roundInProgress = inProgress;
    }

    boolean getReceivedEarnings() {
        return this.receivedEarnings;
    }

    void setReceivedEarnings(boolean received) {
        this.receivedEarnings = received;
    }

    int getTimeRemainingInSecs() {
        float remainingTime = this.durationInSecs - (this.elapsedTime / 1000);
        return (int) (remainingTime);
    }

    void run() {
        this.elapsedTime = runner.millis() - this.startTime; // Initialize elapsed time

        fireShots(); // Shots should be fired even if finished dispatching enemies

        if (this.elapsedTime < (this.durationInSecs * 1000)) { // While the round duration has not passed

            if ((runner.millis() - this.lastEnemyDispatch) >= this.dispatchInterval) { // If the time to dispatch is met, dispatch an enemy
                dispatchEnemies();
                this.lastEnemyDispatch = runner.millis();
            }
        } else if (runner.AllGerms.size() <= 0) { // If all enemeies for the round dispatched, but not yet all killed, round should continue
            this.roundInProgress = false;
        }
    }

    void fireShots() {
        int currentTime = runner.millis(); // Set current time so shoot() is called once every second
        // This will need to be altered when we animate projectiles to something similar to dispatchInterval
        // i.e. for each tower calculate the shotInterval, and fire at that rate

        if (currentTime - this.lastShotTime >= 1000) { // change to >= shootIntervalInMillisecs when projectiles implemented
            for (int i = 0; i < runner.AllTowers.size(); i++) {
                runner.AllTowers.get(i).shoot();
            }
            this.lastShotTime = currentTime;
        }
    }

    void dispatchEnemies() {
        runner.AllGerms.add(new GermWbc(0, runner));
    }
}
