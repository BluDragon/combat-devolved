// Initialize all the data used in the timer voice functionality
// This script also serves to reset the counters used in the actual
// timer voice thingy, as it is called everytime a new game mode starts.
// Because this is called every time a new game starts, we can keep the
// variables local

{
    // Explanation:
    // timerVoiceTime = the time (in ticks) when the voice sample should be played
    
    var i;
    i = 0;
    
    timerVoiceTime[i] = 1800;
    i += 1;
    
    timerVoiceTime[i] = 300;
    i += 1;
    
    timerVoiceTime[i] = 900;
    i += 1;
    
    // No edting required after this point, the remainder is automation
    timerNumTimes = i;
    timerJustStarted = true;
    for (i = 0; i < timerNumTimes; i += 1) {
        // the time has not been stated yet
        timerSaidTime[i] = false;
        timerSaidTimeRed[i] = false;    // for KotH mode; the other timer will be used for BLU
    }
}
