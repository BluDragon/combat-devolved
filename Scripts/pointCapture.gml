//argument0 = the effected control point no.

var soundPlayed;
soundPlayed=false;

point = global.cp[argument0];
capList = ds_list_create();

var imInvolved;
imInvolved = false;
with(Character) {
    if(cappingPoint == other.point) {
        if(player.team == other.point.cappingTeam) {
            ds_list_add(other.capList, player);
            player.stats[CAPS] +=1;
            player.roundStats[CAPS] +=1;
            player.stats[POINTS] += 2;
            player.roundStats[POINTS] += 2;
            if (player == global.myself) imInvolved = true;
        }

    }
}

var capperList;
capperList = "";

for(i=0; i<ds_list_size(capList); i+=1) {
    player = ds_list_find_value(capList,i);            
        
    if (i == 0) {
        capperList=capperList + player.name;
    } else {
        if i == ds_list_size(capList)-1 capperList=capperList + " and " + player.name;
        else capperList=capperList + ", " + player.name;
    }
}    
    
recordEventInLog(1, point.cappingTeam, capperList, imInvolved);
ds_list_destroy(capList);

// count up all the owned points each side has (BEFORE the cap occurs)
var redCaps, blueCaps;
var gainedLead;
var lostLead;

// check if we gained the lead (only for modes 0 and 1) and NEVER for 2-point games
gainedLead = false;
lostLead = false;
if ((point.mode == 0) || (point.mode == 1)) {
    if (global.totalControlPoints != 2) {
        redCaps = 0;
        blueCaps = 0;
        for (i = 1; i <= global.totalControlPoints; i += 1) {
            if (global.cp[i].team == TEAM_RED) {
                redCaps += 1;
            } else if (global.cp[i].team == TEAM_BLUE) {
                blueCaps += 1;
            }
        }
        if (global.myself != -1) {
            if ((cappingTeam == TEAM_RED) && ((redCaps == blueCaps) || (redCaps + 1 == blueCaps))) {
                if (global.myself.team == TEAM_RED) {
                    gainedLead = true;
                } else if (global.myself.team == TEAM_BLUE)  {
                    lostLead = true;
                }
            }
            if ((cappingTeam == TEAM_BLUE) && ((redCaps == blueCaps) || (redCaps == blueCaps + 1))) {
                if (global.myself.team == TEAM_BLUE) {
                    gainedLead = true;
                } else if (global.myself.team == TEAM_RED) {
                    lostLead = true;
                }
            }
        }
    }
}

with point {
    team = cappingTeam;
    capping = 0;
}

if ((global.myself != -1) && ((point.mode == 0) || (point.mode == 1))) {
    if ((global.myself.team == TEAM_SPECTATOR) || (global.myself.team == cappingTeam)) {
        announcerQueue(VOX_CPGET);
    } else {
        announcerQueue(VOX_CPLOST);
    }
}
// In KOTH and DKOTH, say HILL CONTROLLED
if ((point.mode == 3) || (point.mode == 4)) {
    announcerQueue(VOX_HILLGET);
}
// in DKOTH mode, we also say HILL MOVED if:
// Your team has capped this point and now it's 50/50
// Your team has lost this point and now the opposing team has them all
if ((global.myself != -1) && (point.mode == 4)) {
    // this is kinda crude, but I'm tired right now and want a quick fix
    var myTeam;
    myTeam = global.myself.team mod 2;
    
    // capped and now 50/50
    if ((point.team == myTeam) && (global.cp[1].team + global.cp[2].team == 1)) {
        announcerQueue(VOX_HILLMOVE);
    }
    
    // lost point and opposing has all
    if ((point.team != myTeam) && (global.cp[1].team == global.cp[2].team)) {
        announcerQueue(VOX_HILLMOVE);
    }
}

// if we gained the lead in this manuever, say so!
if (gainedLead) announcerQueue(VOX_GAINLEAD);
if (lostLead) announcerQueue(VOX_LOSTLEAD);

/*
// If the user capped the point, check the timer for Gotta Catch Em All
// and then set it if it's zero, or award the cheevo if non-zero
if (imInvolved) {
    if (AchievementController.catchEmAllTimer > 0) {
        // give the achievement
        achieveIncrement(ACH_CATCHALL);
    } else {
        // give them 10 seconds to cap another point for the cheevo
        AchievementController.catchEmAllTimer = 300;
    }
}
*/
