/* This script handles kills for the medal controller
**
** argument0 = victim player, used for checking if they were the flag bearer, and for Extermination checks
*/

{
    var exterminator, i, p, enemyCount;
    
    with (MedalController) {
        // increment the spree and multi counters
        multikillCounter += 1;
        spreeCounter += 1;
    
        // set the countdown alarm for the multikill counter
        alarm[0] = 120;
        
        // check if the victim was holding the flag
        if (argument0.object.intel) {
            // flag defender!
            recordMedal(FlagDefenderM, "Flag Defender!");
        }
        
        // since the kill events happen one at a time, we only need to check
        // for when the counters hit the exact amounts
        
        // multikill counter
        switch (multikillCounter) {
            case 2:
                announcerQueue(VOX_MEDAL_2KILL);
                recordMedal(DoubleKillM, "Double Kill!");
                //achieveIncrement(ACH_DOUBLEKILL);
                break;
            case 3:
                announcerQueue(VOX_MEDAL_3KILL);
                recordMedal(TripleKillM, "Triple Kill!");
                //achieveIncrement(ACH_TRIPLEKILL);
                break;
            case 4:
                announcerQueue(VOX_MEDAL_4KILL);
                recordMedal(OverkillM, "Overkill!");
                //achieveIncrement(ACH_OVERKILL);
                break;
            case 5:
                announcerQueue(VOX_MEDAL_5KILL);
                recordMedal(KilltacularM, "Killtacular!");
                break;
            case 6:
                announcerQueue(VOX_MEDAL_6KILL);
                recordMedal(KilltrocityM, "Killtrocity!");
                break;
        }
        
        // spree counter
        switch (spreeCounter) {
            case 5:
                announcerQueue(VOX_MEDAL_SPREE1);
                recordMedal(KillingSpreeM, "Killing Spree!");
                break;
            case 10:
                announcerQueue(VOX_MEDAL_SPREE2);
                recordMedal(KillingFrenzyM, "Killing Frenzy!");
                break;
            case 15:
                announcerQueue(VOX_MEDAL_SPREE3);
                recordMedal(RunningRiotM, "Running Riot!");
                break;
            case 20:
                announcerQueue(VOX_MEDAL_SPREE4);
                recordMedal(RampageM, "Rampage!");
                break;
            case 25:
                announcerQueue(VOX_MEDAL_SPREE5);
                recordMedal(UntouchableM, "Untouchable!");
                break;
            case 30:
                announcerQueue(VOX_MEDAL_SPREE6);
                recordMedal(InvincibleM, "Invincible!");
                break;
        }
        
        // Extermination check
        // the first type of check is only performed in Arena mode (killed all of the enemy team by myself)
        if (instance_exists(ArenaHUD)) {
            // check to see if the opposing team is wiped out
            // (we check to see if the value is 1, because the ArenaHUD will update on the NEXT step)
            if (((global.myself.team == TEAM_RED) && (ArenaHUD.blueteamCharacters == 1)) || 
                ((global.myself.team == TEAM_BLUE) && (ArenaHUD.redteamCharacters == 1))) {
                
                // the opposing team was wiped out
                // check to see if I am the only player who scored any kills
                exterminator = true;
                
                for(i = 0; i < ds_list_size(global.players); i += 1) {
                    p = ds_list_find_value(global.players, i);
                    if ((p.team == global.myself.team) && (p.stats[KILLS] > 0) && (p != global.myself)) {
                        exterminator = false;
                        break;
                    }
                }
                
                if (exterminator == true) {
                    // I AM the exterminator!
                    announcerQueue(VOX_MEDAL_EXTERM);
                    recordMedal(ExterminationM, "Extermination!");
                }
            }
        } else {
            // We're not in Arena mode, so we check to see if we managed to kill ALL members of the opposing team
            // within 4 seconds of each other, only counting each player ONCE
            // (so if you re-kill someone, it does NOT reset the 4 second timer)
            
            // check to see if the victim is not within the list of killed players
            if (ds_list_find_index(killedPlayers, argument0) == -1) {
                // he is not, so add him
                ds_list_add(killedPlayers, argument0);
                
                // check to see if all the members of the opposing team are on this list
                exterminator = true;
                enemyCount = 0;
                for (i = 0; i < ds_list_size(global.players); i += 1) {
                    p = ds_list_find_value(global.players, i);
                    if (p.team != global.myself.team) {
                        // increment the enemy counter
                        enemyCount += 1;
                        if (ds_list_find_index(killedPlayers, p) == -1) {
                            // someone is not, no exterminator for us yet
                            exterminator = false;
                            // set the timer for the next kill
                            alarm[1] = 120;
                        }
                    }
                }
                
                // only earn the medal if 3+ players are on the enemy team
                if ((exterminator == true) && (enemyCount > 2)) {
                    // I AM the exterminator!
                    announcerQueue(VOX_MEDAL_EXTERM);
                    recordMedal(ExterminationM, "Extermination!");
                    // clear the list for the next time
                    ds_list_clear(killedPlayers);
                }
            }
        } // END EXTERMINATION CHECKS
        
    }
}
