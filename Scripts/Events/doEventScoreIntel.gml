/**
 * The player given in argument0 has just recovered the intel for his team.
 */

announcerQueue(VOX_FLAGCAP);
var isMe;
var cLimit;
isMe = (argument0 == global.myself);
//recordEventInLog(3, argument0.team, argument0.name);
recordEventInLog(3, argument0.team, argument0.name, isMe);
if (argument0 == global.myself) recordMedal(FlagCaptureM, "Flag Captured!");
argument0.stats[CAPS] += 1;
argument0.roundStats[CAPS] += 1;
argument0.stats[POINTS] += 2;
argument0.roundStats[POINTS] += 2;
// just before we process the scoring, check to see if the teams are tied
// if they are, that means someone just GAINED THE LEAD
// DO NOT say GAINED THE LEAD if either team has 1 less than the target caps
cLimit = max(1, global.caplimit);
if (global.myself != -1) {
    if ((global.redCaps == global.blueCaps) && (global.redCaps + 1 < cLimit) && (global.blueCaps + 1 < cLimit)) {
        if (argument0.team == global.myself.team) {
            announcerQueue(VOX_GAINLEAD);
        } else {
            announcerQueue(VOX_LOSTLEAD);
        }
    }
}
if(argument0.team == TEAM_RED) {
    global.redCaps += 1;
    instance_create(IntelligenceBaseBlue.x, IntelligenceBaseBlue.y, IntelligenceBlue);
} else if(argument0.team == TEAM_BLUE) {
    global.blueCaps += 1;
    instance_create(IntelligenceBaseRed.x, IntelligenceBaseRed.y, IntelligenceRed);
} else {
    exit;
}

if(argument0.object != -1) {
    argument0.object.intel = false;
    argument0.object.animationOffset = CHARACTER_ANIMATION_NORMAL;
}

/*
// If the user capped the intel, check the timer for Gotta Catch Em All
// and then set it if it's zero, or award the cheevo if non-zero
if (isMe) {
    if (AchievementController.catchEmAllTimer > 0) {
        // give the achievement
        achieveIncrement(ACH_CATCHALL);
    } else {
        // give them 10 seconds to cap another intel for the cheevo
        AchievementController.catchEmAllTimer = 300;
    }
}
*/
