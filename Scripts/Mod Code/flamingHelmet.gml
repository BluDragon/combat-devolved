// figure out which of the players is wearing the flaming helmet and then mark their
// character object as having it
{
    var player, i, highest;
    
    highest = -1;
    // iterate through the list
    for (i = 0; i < ds_list_size(global.players); i += 1) {
        player = ds_list_find_value(global.players, i);
        // reset who has the hat
        if (player.object != -1) player.object.hasFieryHat = false;
        // check if they qualify
        if (player.stats[POINTS] >= 20) {
            if (highest == -1) {
                // first to reach the rank
                highest = i;
            } else {
                // not the first
                if (player.stats[POINTS] > ds_list_find_value(global.players, highest).stats[POINTS]) {
                    highest = i;
                }
            }
        }
    }
    
    // now that we're done iterating, set their character (if they have one) to have the hat
    if (highest != -1) {
        player = ds_list_find_value(global.players, highest);
        if (player.object != -1) player.object.hasFieryHat = true;
    }
    
    /*
    // ACHIEVEMENT CODE
    var earnThatMVP;
    earnThatMVP = true;
    // if the current player exists in the game, and if they don't have the MVP cheevo yet...
    if ((global.myself != -1) && (global.achieveStep[ACH_MVP] < global.achieveEarnSteps[ACH_MVP])) {
        // check to see if we are the only one at or above 20 points
        if (global.myself.stats[POINTS] >= 20) {
            for (i = 0; i < ds_list_size(global.players); i += 1) {
                player = ds_list_find_value(global.players, i);
                if ((player != global.myself) && (player.stats[POINTS] >= 20)) {
                    earnThatMVP = false;
                    break;
                }
            }
            
            // we are, we've earned it
            if (earnThatMVP) achieveIncrement(ACH_MVP);
        }
    }
    */
}
