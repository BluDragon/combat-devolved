// Character - Step event
{
    // cap speed
    // NOTE: cap raised to 30 for lunging
    speed = min(speed, 30);
    
    // increment the timeUnscathed counter
    timeUnscathed = min(timeUnscathed + 1, 60000);
    
    // decrement the shield flash counter
    shieldFlash = max(-1, shieldFlash - 1);
    
    // decrement timers
    meleeLungeTimer = max(-1, meleeLungeTimer - 1);
    meleeSearchTimer = max(-1, meleeSearchTimer - 1);
    grenadeCooldownTimer = max(-1, grenadeCooldownTimer - 1);
    grenadeTossFrame = max(-1, grenadeTossFrame - 1);
    
    // update the melee strike mask position if it exists
    if instance_exists(meleeStrikeMask) {
        // update its position
        meleeStrikeMask.x = x;
        meleeStrikeMask.y = y + bobAmt;
        meleeStrikeMask.image_xscale = image_xscale;
    }
}
