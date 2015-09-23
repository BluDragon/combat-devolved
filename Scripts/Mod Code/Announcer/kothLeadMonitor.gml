// called every step to try and monitor who has gained the lead in KotH and DKotH mode

{
    if (global.myself == -1) exit;
    
    // if last turn, red was NOT lower than blue, and NOW it is, RED is now in the lead
    if ((lastRedTimer >= lastBlueTimer) && (redTimer < blueTimer)) {
        if (global.myself.team == TEAM_RED) {
            announcerQueue(VOX_GAINLEAD);
        } else {
            announcerQueue(VOX_LOSTLEAD);
        }
    }
    // if last turn, blue was NOT lower than red, and NOW it is, BLUE is now in the lead
    if ((lastRedTimer <= lastBlueTimer) && (redTimer > blueTimer)) {
        if (global.myself.team == TEAM_BLUE) {
            announcerQueue(VOX_GAINLEAD);
        } else {
            announcerQueue(VOX_LOSTLEAD);
        }
    }
    
    // update the history
    lastRedTimer = redTimer;
    lastBlueTimer = blueTimer;
}
