with(ArenaHUD) {
    roundStart = 300;
    endCount = 0;
    cpUnlock = 1800;
    winners = TEAM_SPECTATOR;
}

ArenaControlPoint.team = -1;
ArenaControlPoint.locked = 1;
with Player humiliated = 0;
with Sentry instance_destroy();
with SentryGibs instance_destroy();
    
// this is an effort to correct the bug where a different song will start, then Wesker's will replace it
var isIngamePlaying, i;
isIngamePlaying = false;

for (i = 0; i < global.numIngameMusic; i += 1) {
    if (AudioControl.currentSong == global.IngameMusic[i]) isIngamePlaying = true;
}

if(global.ingameMusic and (isIngamePlaying == false)) {
    AudioControlPlaySong(global.IngameMusic[irandom(global.numIngameMusic - 1)], true);
}
