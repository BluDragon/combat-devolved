{
    // create the Queue object used to keep track of what sounds to play
    voiceQueue = ds_queue_create();
    // currently talking
    speaking = false;
    
    // init all the sounds and their delays
    voxSound[VOX_FLAGGET] = global.IntelGetSnd;
    voxDelay[VOX_FLAGGET] = 32;
    
    voxSound[VOX_FLAGCAP] = global.IntelPutSnd;
    voxDelay[VOX_FLAGCAP] = 42;
    
    voxSound[VOX_FLAGDROP] = global.IntelDropSnd;
    voxDelay[VOX_FLAGDROP] = 39;
    
    voxSound[VOX_FLAGRESET] = global.IntelResetSnd;
    voxDelay[VOX_FLAGRESET] = 45;
    
    voxSound[VOX_CPGET] = global.CPCapturedSnd;
    voxDelay[VOX_CPGET] = 51;
    
    voxSound[VOX_CPLOST] = global.CPLostSnd;
    voxDelay[VOX_CPLOST] = 45;
    
    voxSound[VOX_GAMEWIN] = global.VictorySnd;
    voxDelay[VOX_GAMEWIN] = 45;
    
    voxSound[VOX_GAMELOSE] = global.FailureSnd;
    voxDelay[VOX_GAMELOSE] = 45;
    
    voxSound[VOX_CDMIN] = global.OneMinLeftSnd;
    voxDelay[VOX_CDMIN] = 45;
    
    voxSound[VOX_CDTHIRTY] = global.ThirtySecondsLeftSnd;
    voxDelay[VOX_CDTHIRTY] = 48;
    
    voxSound[VOX_CDTEN] = global.TenSecondsLeftSnd;
    voxDelay[VOX_CDTEN] = 54;
    
    voxSound[VOX_ROUNDEND] = global.RoundOverSnd;
    voxDelay[VOX_ROUNDEND] = 45;
    
    voxSound[VOX_GAINLEAD] = global.GainedLeadSnd;
    voxDelay[VOX_GAINLEAD] = 30;
    
    voxSound[VOX_LOSTLEAD] = global.LostLeadSnd;
    voxDelay[VOX_LOSTLEAD] = 36;
    
    voxSound[VOX_HILLGET] = global.HillGetSnd;
    voxDelay[VOX_HILLGET] = 39;
    
    voxSound[VOX_HILLFIGHT] = global.HillFightSnd;
    voxDelay[VOX_HILLFIGHT] = 33;
    
    voxSound[VOX_HILLMOVE] = global.HillMoveSnd;
    voxDelay[VOX_HILLMOVE] = 23;
    
    voxSound[VOX_MEDAL_2KILL] = global.DoubleKillSnd;
    voxDelay[VOX_MEDAL_2KILL] = 25;
    
    voxSound[VOX_MEDAL_3KILL] = global.TripleKillSnd;
    voxDelay[VOX_MEDAL_3KILL] = 24;
    
    voxSound[VOX_MEDAL_4KILL] = global.OverkillSnd;
    voxDelay[VOX_MEDAL_4KILL] = 32;
    
    voxSound[VOX_MEDAL_5KILL] = global.KilltacularSnd;
    voxDelay[VOX_MEDAL_5KILL] = 45;
    
    voxSound[VOX_MEDAL_6KILL] = global.KilltrocitySnd;
    voxDelay[VOX_MEDAL_6KILL] = 43;
    
    voxSound[VOX_MEDAL_SPREE1] = global.KillingSpreeSnd;
    voxDelay[VOX_MEDAL_SPREE1] = 28;
    
    voxSound[VOX_MEDAL_SPREE2] = global.KillingFrenzySnd;
    voxDelay[VOX_MEDAL_SPREE2] = 35;
    
    voxSound[VOX_MEDAL_SPREE3] = global.RunningRiotSnd;
    voxDelay[VOX_MEDAL_SPREE3] = 33;
    
    voxSound[VOX_MEDAL_SPREE4] = global.RampageSnd;
    voxDelay[VOX_MEDAL_SPREE4] = 39;
    
    voxSound[VOX_MEDAL_SPREE5] = global.UntouchableSnd;
    voxDelay[VOX_MEDAL_SPREE5] = 42;
    
    voxSound[VOX_MEDAL_SPREE6] = global.InvincibleSnd;
    voxDelay[VOX_MEDAL_SPREE6] = 69;
    
    voxSound[VOX_MEDAL_EXTERM] = global.ExterminationSnd;
    voxDelay[VOX_MEDAL_EXTERM] = 60;
    
    voxSound[VOX_MEDAL_KJOY] = global.KilljoySnd;
    voxDelay[VOX_MEDAL_KJOY] = 36;
    
    voxSound[VOX_MATCH_GEN] = global.MatchGenSnd;
    voxDelay[VOX_MATCH_GEN] = 21;
    
    voxSound[VOX_MATCH_CTF] = global.MatchCTFSnd;
    voxDelay[VOX_MATCH_CTF] = 46;
    
    voxSound[VOX_MATCH_KOTH] = global.MatchKOTHSnd;
    voxDelay[VOX_MATCH_KOTH] = 51;
    
    voxSound[VOX_MATCH_ARENA] = global.MatchArenaSnd;
    voxDelay[VOX_MATCH_ARENA] = 28;
    
    voxSound[VOX_MATCH_CP] = global.MatchCPSnd;
    voxDelay[VOX_MATCH_CP] = 43;
    
    
    /****** MATCH ANNOUNCE ******/
    // Set the wait timer to 1 second and add the appropriate match name to the vox queue
    speaking = true;
    alarm[0] = 30;
    
    if (instance_exists(ScorePanel)) announcerQueue(VOX_MATCH_CTF);
    if (instance_exists(ControlPointHUD)) announcerQueue(VOX_MATCH_CP);
    if (instance_exists(ArenaHUD)) announcerQueue(VOX_MATCH_ARENA);
    if (instance_exists(KothHUD) || instance_exists(DKothHUD)) announcerQueue(VOX_MATCH_KOTH);
    if (instance_exists(GeneratorHUD)) announcerQueue(VOX_MATCH_GEN);
}
