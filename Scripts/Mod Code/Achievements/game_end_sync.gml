// replace game_end calls with this function to ensure that achievement saving
// is actually finalized before the game ends
{
    // disable this stuff for now
    /*
    // save
    global.sumochiSyncFunc = SUMOSYNC_SAVE;
    // and quit
    global.sumochiSyncReturn = -1;
    // do it
    room_goto_fix(SumochiSyncRoom);
    */
    game_end();
}
