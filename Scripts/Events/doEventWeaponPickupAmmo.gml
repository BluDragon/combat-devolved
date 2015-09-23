/* Performs a weapon pickup ammo event
**
** argument0 = The player who's picking up a powerup (by instance ID)
** argument1 = The array index of the weapon that's receiving the ammo (0 - 1 for normals, 2 for dual-wielded)
** argument2 = The weapon powerup that ammo's being picked up from (by instance ID)
** argument3 = The amount of ammo that's being picked up
**
*/

{
    // grenade special-case check
    if ((argument2.weaponType >= WEAPON_FRAGGRENADE) && (argument2.weaponType <= WEAPON_FIREBOMB)) {
        var gType, hadNone, i;
        
        // it's a grenade powerup
        gType = argument2.weaponType - WEAPON_FRAGGRENADE;
        
        // if it's the player's character...
        if (myCharExists()) {
            if (argument0 == global.myself) {
                // determine if the player had no grenades prior to the pickup
                hadNone = true;
                for (i = 0; i < 4; i += 1) {
                    if (argument0.object.grenadeAmmo[i] > 0) hadNone = false;
                }
                
                // if they had none, switch to the new grenade type
                if (hadNone) argument0.object.currentGrenade = gType;
            
                // play the appropriate pickup sound
                switch (argument2.weaponType) {
                    case WEAPON_FRAGGRENADE:
                    case WEAPON_SPIKEGRENADE:
                        FMODSoundPlay(global.FragGrenadeAmmoSnd);
                        break;
                    
                    case WEAPON_PLASMAGRENADE:
                    case WEAPON_FIREBOMB:
                        FMODSoundPlay(global.PlasmaGrenadeAmmoSnd);
                        break;
                }
            }
        }
        
        // increase the player's appropriate grenade stock
        argument0.object.grenadeAmmo[gType] += argument3;
        
    } else {
        // it's a regular weapon powerup
        var weap, weap2, reloadAmt;
        
        // get the weapon instance
        weap = argument0.object.weapons[argument1];
        
        // if the weapon had no ammo prior to pickup we need to force it to reload if it can
        if (weap.reserveAmmo + weap.ammoCount == 0) {
            // time to deal with edge cases! whoopie!
            
            // if the player is dual-wielding and the two guns are sharing an ammo pool we need to check
            // if the reload amount is enough to put ammo in both guns' magazines, in which case we'd
            // try to trigger a reload for the second gun (the reload check for the first will happen regardless)
            if (argument0.object.state == CHAR_STATE_DUALWIELD) {
                // dual-wielding, check if this is one of the equipped guns
                if (getWeaponPosition(weap) != 0) {
                    // check if it and its partner are sharing an ammo pool
                    if (argument0.object.weapons[argument0.object.currentWeapon].weaponType == argument0.object.weapons[2].weaponType) {
                        // check if the reload amount is greater than the size of a full mag
                        if (argument3 > weap.maxAmmo) {
                            // there is enough for the secondary to reload, too, so do the check on that
                            weap2 = argument0.object.weapons[2];
                            if (weap2.alarm[0] == -1) && (weap2.alarm[8] == -1) && (weap2.alarm[4] == -1) {
                                with (weap2) {
                                    // if we're dual-wielded, add some extra time
                                    alarm[4] = floor(reloadTime * Iif(owner.state == CHAR_STATE_DUALWIELD, global.dualWieldReloadFactor, 1));
                                    if (ownerPlayer == global.myself) {
                                        // play the reload and kill zoom if the player was zoomed in
                                        reloadSoundID = FMODSoundPlay(reloadSound);
                                        if (owner.zoomed) {
                                            owner.zoomed = false;
                                            undoZoomCursor();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            // even in the case of dual-wielding, the 'primary' will always get a reload first, so perform
            // this check anyways, but also consider if a reload is scheduled already
            // (in case the secondary is what we're reloading now, yay confusing shit!)
            if (weap.alarm[0] == -1) && (weap.alarm[8] == -1) && (weap.alarm[4] == -1) && (getWeaponPosition(weap) != 0) {
                with (weap) {
                    // if we're dual-wielded, add some extra time
                    alarm[4] = floor(reloadTime * Iif(owner.state == CHAR_STATE_DUALWIELD, global.dualWieldReloadFactor, 1));
                    if (ownerPlayer == global.myself) {
                        // play the reload and kill zoom if the player was zoomed in
                        reloadSoundID = FMODSoundPlay(reloadSound);
                        if (owner.zoomed) {
                            owner.zoomed = false;
                            undoZoomCursor();
                        }
                    }
                }
                
            }
        
        }
        
        // add the ammo
        weap.reserveAmmo += argument3;
        
        // if the character belongs to the player, perform the necessary UI effects
        if (myCharExists()) {
            if (argument0 == global.myself) {
                // play the pickup sound
                FMODSoundPlay(weap.ammoPickupSound);
                // set the appropriate values and timers for the ammo pickup animation
                if (argument1 == 2) {
                    VisorHud.ammoPickupLeftTimer = 30;
                    VisorHud.ammoPickupLeftValue = argument3;
                } else if (argument1 == argument0.object.currentWeapon) {
                    VisorHud.ammoPickupRightTimer = 30;
                    VisorHud.ammoPickupRightValue = argument3;
                }
            }
        }
    }
    
    // decrement the ammo from the drop
    argument2.ammo -= argument3;
    
    // despawn the weapon drop if all ammo has been depleted from the drop, AND we're the host
    if (argument2.ammo <= 0) && (global.isHost) {
        sendEventWeaponDespawn(argument2);
        doEventWeaponDespawn(argument2);
    }
}
