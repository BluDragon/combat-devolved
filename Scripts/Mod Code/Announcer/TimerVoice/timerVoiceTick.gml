// this script is called each step of the objects that handle the timer

{
    var i;
    
    if (timerJustStarted == false) {
        for (i = 0; i < timerNumTimes; i += 1) {
            if ((timerSaidTime[i] == false) and (timerVoiceTime[i] >= timer)) {
                if (timerVoiceTime[i] == 1800) announcerQueue(VOX_CDMIN);
                else if (timerVoiceTime[i] == 900) announcerQueue(VOX_CDTHIRTY);
                else if (timerVoiceTime[i] == 300) announcerQueue(VOX_CDTEN);
                timerSaidTime[i] = true;
            }
        }
    } else {
        // allow a step to pass so all the voices don't clammer at once when
        // a round begins or is joined
        for (i = 0; i < timerNumTimes; i += 1) {
            if (timerVoiceTime[i] >= timer) timerSaidTime[i] = true;
        }
        
        timerJustStarted = false;
    }

}
