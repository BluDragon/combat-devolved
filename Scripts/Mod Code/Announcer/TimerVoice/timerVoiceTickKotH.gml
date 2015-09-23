// this script is called each step of the objects that handle the timer
// this one is for KOTH mode only

{
    var i;
    
    if (timerJustStarted == false) {
        for (i = 0; i < timerNumTimes; i += 1) {
            // BLU
            if ((timerSaidTime[i] == false) and (timerVoiceTime[i] >= blueTimer)) {
                if (timerVoiceTime[i] == 1800) announcerQueue(VOX_CDMIN);
                else if (timerVoiceTime[i] == 900) announcerQueue(VOX_CDTHIRTY);
                else if (timerVoiceTime[i] == 300) announcerQueue(VOX_CDTEN);
                timerSaidTime[i] = true;
            }
            // RED
            if ((timerSaidTimeRed[i] == false) and (timerVoiceTime[i] >= redTimer)) {
                if (timerVoiceTime[i] == 1800) announcerQueue(VOX_CDMIN);
                else if (timerVoiceTime[i] == 900) announcerQueue(VOX_CDTHIRTY);
                else if (timerVoiceTime[i] == 300) announcerQueue(VOX_CDTEN);
                timerSaidTimeRed[i] = true;
            }
        }
    } else {
        // allow a step to pass so all the voices don't clammer at once when
        // a round begins or is joined
        for (i = 0; i < timerNumTimes; i += 1) {
            if (timerVoiceTime[i] >= blueTimer) timerSaidTime[i] = true;
            if (timerVoiceTime[i] >= redTimer) timerSaidTimeRed[i] = true;
        }
        
        timerJustStarted = false;
    }

}
