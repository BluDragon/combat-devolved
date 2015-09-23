// called every step to try and monitor who has gained the lead in Generator mode

{
    // only proceed if both gens exist
    if (!instance_exists(GeneratorRed) || !instance_exists(GeneratorBlue)) exit;
    if (global.myself == -1) exit;

    // if last turn, red was NOT higher than blue, and NOW it is, RED is now in the lead
    if ((lastRedHp <= lastBlueHp) && (GeneratorRed.hp > GeneratorBlue.hp)) {
        if (global.myself.team == TEAM_RED) {
            announcerQueue(VOX_GAINLEAD);
        } else {
            announcerQueue(VOX_LOSTLEAD);
        }
    }
    // if last turn, blue was NOT higher than red, and NOW it is, BLUE is now in the lead
    if ((lastRedHp >= lastBlueHp) && (GeneratorRed.hp < GeneratorBlue.hp)) {
        if (global.myself.team == TEAM_BLUE) {
            announcerQueue(VOX_GAINLEAD);
        } else {
            announcerQueue(VOX_LOSTLEAD);
        }
    }

    // update the HP
    lastRedHp = GeneratorRed.hp;
    lastBlueHp = GeneratorBlue.hp;
}
