/**
 * Grab the intel.
 * Argument 0 is the player who is grabbing it.
 */

// modified for Halo Mod: if YOU grab the intel it says You

//recordEventInLog(6,argument0.team,argument0.name);
//argument0.caps += 0.5;
if (!instance_exists(WinBanner)) announcerQueue(VOX_FLAGGET);
var isMe;
isMe = (global.myself == argument0);
if global.myself == argument0 {
    // instead of the notice bar spawning, say YOU for the name
    recordEventInLog(6, argument0.team, "You", isMe);
} else {
    // not me, record the event as normal
    recordEventInLog(6, argument0.team, argument0.name, isMe);
}

if(argument0.object != -1)
{
    if(argument0.team == TEAM_RED)
    {
        argument0.object.intelRecharge = IntelligenceBlue.alarm[0];
        ScorePanel.blueHold = 120;  // Mod: for CTF HUD flag alerts
        with(IntelligenceBlue)
            instance_destroy();
    }
    else if(argument0.team == TEAM_BLUE)
    {
        argument0.object.intelRecharge = IntelligenceRed.alarm[0];
        ScorePanel.redHold = 120;   // Mod: for CTF HUD flag alerts
        with(IntelligenceRed)
            instance_destroy();
    }
    else
        exit;
    
    argument0.object.intel = true;
    argument0.object.animationOffset = CHARACTER_ANIMATION_INTEL;
}
