// called every step to try and monitor who has gained the lead in Arena mode

{
    // leave if unhandle-able shit is going on
    if (global.myself == -1) exit;
    // also wait 1/3 of a second into the round, so it won't say GAINED THE LEAD sometimes when the round starts
    if ((roundStart > 0) || (redteamCharacters == 0) || (blueteamCharacters == 0) || (cpUnlock > 1790)) {
        lastRedTeam = redteamCharacters;
        lastBlueTeam = blueteamCharacters;
        exit;
    }
    
    // if last turn, red was NOT higher than blue, and NOW it is, RED is now in the lead
    if ((lastRedTeam <= lastBlueTeam) && (redteamCharacters > blueteamCharacters)) {
        if (global.myself.team == TEAM_RED) {
            announcerQueue(VOX_GAINLEAD);
        } else {
            announcerQueue(VOX_LOSTLEAD);
        }
    }
    // if last turn, blue was NOT higher than red, and NOW it is, BLUE is now in the lead
    if ((lastRedTeam >= lastBlueTeam) && (redteamCharacters < blueteamCharacters)) {
        if (global.myself.team == TEAM_BLUE) {
            announcerQueue(VOX_GAINLEAD);
        } else {
            announcerQueue(VOX_LOSTLEAD);
        }
    }

    lastRedTeam = redteamCharacters;
    lastBlueTeam = blueteamCharacters;
}
