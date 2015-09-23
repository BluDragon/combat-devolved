// increments an achievement's step
// when an achievement reaches the fully-earned state, trigger it being earned
//
// argument0 = achievement constant
{
    // only increment if we havent earned it yet
    if (global.achieveStep[argument0] >= global.achieveEarnSteps[argument0]) exit;
    
    // increment the achievment's counter
    global.achieveStep[argument0] += 1;
    // check to see if we've earned it
    if (global.achieveStep[argument0] == global.achieveEarnSteps[argument0]) {
        // we have earned the achievement!
        
        // add it to the save queue
        ds_queue_enqueue(global.achieveSaveQueue, argument0);
        
        // play the sound
        FMODSoundPlay(global.AchievementSnd);
        // let the achievement overlay know
        with (AchievementController) {
            earnedCheevo = argument0;
            earnedAge = 0;
        }
        
        // AND SAVE THAT SHIT TO THE LOCAL (in case the world ends or something)
        saveAchievements();
    }
}
