{
    //loopsoundstop(UberIdleSnd);
    
    var newIntel, map;
    
    // destroy weapons
    with (weapons[0]) instance_destroy();
    with (weapons[1]) instance_destroy();
    if (instance_exists(weapons[2])) {
        with (weapons[2]) instance_destroy();
    }

    // destroy the attached helmet
    with (headHelmet) {
        instance_destroy();
    }
    
    // destroy the melee strike mask if it exists
    if (instance_exists(meleeStrikeMask)) {
        with (meleeStrikeMask) instance_destroy();
    }
    
    // destroy the particle emitter
    part_emitter_destroy(global.weaponPS, fireEmitter);
    
    // destroy any attached needles and then the list itself
    while (ds_list_size(stuckNeedles) > 0) {
        if (instance_exists(ds_list_find_value(stuckNeedles, 0))) {
            with (ds_list_find_value(stuckNeedles, 0)) {
                instance_destroy();
            }
        }
        ds_list_delete(stuckNeedles, 0);
    }
    ds_list_destroy(stuckNeedles);
    
    if(intel) {
        var isMe;
        isMe = (global.myself == player);
        if(team == TEAM_RED) {
            newIntel = instance_create(x,y,IntelligenceBlue);
            recordEventInLog(5, TEAM_RED, player.name, isMe);
            // MOD: reset the CTF HUD flag counter to 0
            ScorePanel.blueHold = 0;
        } else if (team == TEAM_BLUE) {
            newIntel = instance_create(x,y,IntelligenceRed);
            recordEventInLog(5, TEAM_BLUE, player.name, isMe);
            // MOD: reset the CTF HUD flag counter to 0
            ScorePanel.redHold = 0;
        }
        newIntel.alarm[0] = intelRecharge;
        if (lastDamageSource == KILL_BOX || lastDamageSource == FRAG_BOX || lastDamageSource == PITFALL) {
            if (global.isHost){
                if(team==TEAM_RED) {
                    doEventReturnIntel(TEAM_BLUE);
                    sendEventReturnIntel(TEAM_BLUE);
                } else {
                    doEventReturnIntel(TEAM_RED);
                    sendEventReturnIntel(TEAM_RED);
                }
            }
        }
        if (!instance_exists(WinBanner)) announcerQueue(VOX_FLAGDROP);
    }
    
    with(bubble) {
        instance_destroy();
    }
    
    player.object=-1;
    if (collision_point(x,y,SpawnRoom,0,0) && (lastDamageDealer == player || lastDamageDealer == -1))
        player.alarm[5] = 1;
    else 
        player.alarm[5] = global.Server_Respawntime;
    
    //part type destroy
    if(variable_local_exists("jumpFlameParticleType")) {
            part_type_destroy(jumpFlameParticleType);
    }
    
    // cleanup if this is the player character
    if (player == global.myself) {
        // restore the reticle to the default
        Cursor.sprite_index = CrosshairS;
    }
}
