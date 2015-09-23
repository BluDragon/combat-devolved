// Characted - End Step event
{    
    // Climbing down stairs
    if (vspeed == 0) // if we aren't falling this frame
    { 
        // NOTE: This stuff is currently keyed to the 6x scaled stuff, so if we change the map scale, this'll have to change, too
        if(place_free(x,y+6))
            if(!place_free(x,y+7))
                y += 6;
            else if(speed > 6) if(place_free(x,y+12)) if(!place_free(x,y+13))
                y += 12;
    }
    xprevious = x;
    yprevious = y;
    
    if (global.isHost && hp <= 0) {
        // send and do the weapon spawn events for dropped weapons before killing the player
        if (currentWeapon == 0) {
            mult[0] = sign(image_xscale);
            mult[1] = -mult[0];
        } else {
            mult[0] = -sign(image_xscale);
            mult[1] = -mult[0];
        }
        mult[2] = 0;    // dual-wielded weapons drop straight down
        // spawn the two weapons if they have ammo remaining
        var i;
        for (i = 0; i < 3; i += 1) {
            if (instance_exists(weapons[i])) {
                if (weapons[i].ammoCount + weapons[i].reserveAmmo > 0) {
                    sendEventWeaponSpawn(weapons[i].weaponType, weapons[i].ammoCount + weapons[i].reserveAmmo, 900, x, y, mult[i] * 2, 0);
                    doEventWeaponSpawn(weapons[i].weaponType, weapons[i].ammoCount + weapons[i].reserveAmmo, 900, x, y, mult[i] * 2, 0);
                }
            }
        }
        // spawn the dropped grenades
        for (i = 0; i < 4; i += 1) {
            if (grenadeAmmo[i] > 0) {
                // grenade weapon types are contiguous and in the same order as used in this array
                // so we can use WEAPON_FRAGGRENADE as a base point for the weapon type spawn
                sendEventWeaponSpawn(WEAPON_FRAGGRENADE + i, grenadeAmmo[i], 900, x, y, i / 2 - 0.75, 0);
                doEventWeaponSpawn(WEAPON_FRAGGRENADE + i, grenadeAmmo[i], 900, x, y, i / 2 - 0.75, 0);
            }
        }
        
        var assistant;
        assistant = secondToLastDamageDealer;
        if (lastDamageDealer and instance_exists(lastDamageDealer))
            if (lastDamageDealer.object)
                if (lastDamageDealer.object.healer)
                    assistant = lastDamageDealer.object.healer;
                    
        sendEventPlayerDeath(player, lastDamageDealer, assistant, lastDamageSource);
        doEventPlayerDeath(player, lastDamageDealer, assistant, lastDamageSource);
        with(GameServer) {
            ServerBalanceTeams();
        }
        exit;
    }
        
    if (hp > maxHp) {
        hp = maxHp;
    }
    
    // Set the weapon's image scale and aim directions
    if (((aimDirection + 270) mod 360) > 180) {
        image_xscale=1;
        weapons[0].image_xscale = 1;
        weapons[0].image_angle = aimDirection;
        weapons[1].image_xscale = 1;
        weapons[1].image_angle = aimDirection;
        if (weapons[2] != noone) {
            weapons[2].image_xscale = 1;
            weapons[2].image_angle = aimDirection;
        }
    } else {
        image_xscale=-1;
        weapons[0].image_xscale = -1;
        weapons[0].image_angle = aimDirection + 180;
        weapons[1].image_xscale = -1;
        weapons[1].image_angle = aimDirection + 180;
        if (weapons[2] != noone) {
            weapons[2].image_xscale = -1;
            weapons[2].image_angle = aimDirection + 180;
        }
    }
    
    // Move the weapons
    weapons[0].x = round(x);
    weapons[0].y = round(y) + bobAmt;
    weapons[1].x = round(x);
    weapons[1].y = round(y) + bobAmt;
    if (weapons[2] != noone) {
        weapons[2].x = round(x);
        weapons[2].y = round(y) + bobAmt;
    }
            
    // Limit people to the area of the room to prevent the
    // "Falling through the floors" issue.
    if(x<0) {
        x=0;
    }
    if(x>map_width()){
        x = map_width();
    }
    if(y<0) {
        y = 0;
    }
    if(y>map_height()){
        y = map_height();
    }
    if(!place_free(x,y+1))
        moveStatus=0;
            
    // Taunts and sandwiches are no longer a thing
    /*
    if (taunting)
    {
        tauntindex += tauntspeed*0.1;
        if tauntindex >= tauntend taunting=false;
    }
        
    //sandvich
    if (omnomnomnom)
    {
        omnomnomnomindex += 0.25;
        image_xscale=xscale;
        if (hp <= maxHp)
            hp += 1.6;
        if (omnomnomnomindex >= omnomnomnomend)
            omnomnomnom=false;
    }
    */
    
    //for things polling whether the character is on a medcabinet
    onCabinet = place_meeting(x, y, HealingCabinet);
    
    // Last x/y position for death cam if player is dead
    player.lastKnownx = x;
    player.lastKnowny = y;
    
    // Here the view is set
    /*
    if (player == global.myself) {
        if (object_is_ancestor(object_index, Sniper) and zoomed) {
            var relxmouse, relymouse;
            relxmouse = min(max(window_views_mouse_get_x()-view_xview[0], 0), view_wview);
            relymouse = min(max(window_views_mouse_get_y()-view_yview[0], 0), view_hview);
            
            view_xview[0] = x+relxmouse-view_wview[0];
            view_yview[0] = y+relymouse-view_hview[0];
        }
        else
        {
            view_xview[0] = x - view_wview[0] / 2;
            view_yview[0] = y - view_hview[0] / 2;
        }
    }
    */
    // Check if the window has lost focus, and if it has, disable zoom
    if (window_handle() != getForegroundWindow()) {
        zoomed = false;
        justZoomed = false;
    }
    if (player == global.myself) && zoomed {
        if (!justZoomed) {
            var scopeDist, scopeDir;
            
            // modify the relative scope values based on how much the mouse moved off-center
            scopeRelX += mouse_x - (view_xview[0] + view_wview[0] / 2);
            scopeRelY += mouse_y - (view_yview[0] + view_hview[0] / 2);
            
            // limit the position so that it stays within range of the current weapon
            scopeDist = point_distance(0, 0, scopeRelX, scopeRelY);
            if (weapons[currentWeapon].maxZoomRange == -1) && (scopeDist > weapons[currentWeapon].maxRange) {
                if (scopeDist > weapons[currentWeapon].maxRange) {
                    // calculate the angle as well
                    scopeDir = point_direction(0, 0, scopeRelX, scopeRelY);
                    // then trim the distance and recalculate the position
                    scopeRelX = lengthdir_x(weapons[currentWeapon].maxRange, scopeDir);
                    scopeRelY = lengthdir_y(weapons[currentWeapon].maxRange, scopeDir);
                }
            } else if (weapons[currentWeapon].maxZoomRange > -1) && (scopeDist > weapons[currentWeapon].maxZoomRange) {
                if (scopeDist > weapons[currentWeapon].maxZoomRange) {
                    // calculate the angle as well
                    scopeDir = point_direction(0, 0, scopeRelX, scopeRelY);
                    // then trim the distance and recalculate the position
                    scopeRelX = lengthdir_x(weapons[currentWeapon].maxZoomRange, scopeDir);
                    scopeRelY = lengthdir_y(weapons[currentWeapon].maxZoomRange, scopeDir);
                }
            }
            
            // trim the scope so it stays within the map area
            if (x + scopeRelX < 0) {
                scopeRelX = 0 - x;
            } else if (x + scopeRelX > background_width[0] * background_xscale[0]) {
                scopeRelX = background_width[0] * background_xscale[0] - x;
            }
            if (y + scopeRelY < 0) {
                scopeRelY = 0 - y;
            } else if (y + scopeRelY > background_height[0] * background_yscale[0]) {
                scopeRelY = background_height[0] * background_yscale[0] - y;
            }
            
            // move the view to the cursor's position
            view_xview[0] = x + round(scopeRelX) - view_wview[0] / 2;
            view_yview[0] = y + round(scopeRelY) - view_hview[0] / 2;
            
            // recenter the cursor
            window_mouse_set(window_get_width() / 2, window_get_height() / 2);
        }
    } else if (player == global.myself) {
        view_xview[0] = x - view_wview[0] / 2;
        view_yview[0] = y - view_hview[0] / 2;
    }
    // clear if we just zoomed this frame
    justZoomed = false;
    
    // clear if we just dopped a dual-weapon this frame
    dualJustDropped = false;
    
    if (place_free(x, y + 1)) {
        // we're airborne, increment the counter
        airtime += 1;
    } else if (airtime > 0) {
        // we WERE airborne and are no longer
        if (airtime > 8) {
            // if we were airborne long enough, play the landing sound
            playsound(x, y, choose(global.Landing1Snd, global.Landing2Snd, global.Landing3Snd));
        }
        // reset airtime
        airtime = 0;
    }
    
    // if HP is now >= max, and stopDropGo is still okay, earn it (Disabled for now)
    /*
    if (instance_exists(AchievementController)) {
        if ((player == global.myself) && (hp >= maxHp) && (AchievementController.stopDropGoOkay)) {
            achieveIncrement(ACH_STOPDROPGO);
            stopDropGoOkay = false;
        }
    }
    */
    
    if (timeUnscathed >= 127) {
        // recharge HP and shields if enough time has passed
        hp = min(maxHp, hp + 1.5);
        shieldHp = min(maxShieldHp, shieldHp + 1.5);
    }
        
    // count down the freshly-respawned timer
    freshRespawn = max(0, freshRespawn - 1);
    
    // set alpha visiblity of the character based on if the player character exists
    // and if this character is within line-of-sight/crouched
    var cloakMe;
    cloakMe = false;  // characters default to being visible
    if (myCharExists()) {
        if (global.myself.object != id) && (crouched) {
            // character is not me and is crouched
            // check to see if they're on an opposing team
            if (!onSameTeam(global.myself, player)) {
                // check if they're behind the player
                if (sign(global.myself.object.image_xscale) != sign(x - global.myself.object.x)) {
                    // behind player
                    cloakMe = true;
                } else {
                    // in front of player
                    // finally, do a line of sight check
                    if (collision_line(global.myself.object.x, global.myself.object.y, x, y, Obstacle, true, false) > 0) {
                        cloakMe = true;
                    }
                }
            }
        }
    }
    // copy the crouch cloaking state to the crouchCloaked variable
    crouchCloaked = cloakMe;
    
    // move the flame effect emitter
    part_emitter_region(global.weaponPS, fireEmitter, x - 7, x + 7, y + 3, y + 17, ps_shape_ellipse, ps_distr_gaussian);

    // if we should be hidden, move towards cloak alpha, otherwise move towards visibility
    if (cloakMe) {
        cloakAlpha = max(cloakAlpha - 0.05, 0);
    } else {
        cloakAlpha = min(cloakAlpha + 0.05, 1);
        // if we're also on fire, spawn some flame particles
        if (firebombBurning) part_emitter_burst(global.weaponPS, fireEmitter, global.characterBurningPT, 2);
    }
}
