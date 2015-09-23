/* Common weapon-firing input script for characters, offloaded and called from CharacterBeginStep
** due to the fact that there's a lot of logic going on here that is shared amongst all character states.
**
** argument0 = instance ID of the weapon being checked for firing
** argument1 = character control keycode used in the checks
** argument2 = the side of the screen to flash ammo warnings on (false = right, true = left)
*/

{
    // different logic for charging and non-charging weapons
    // weapons can only charge up if they are ready-to-fire and not overheated (if they can overheat)
    if (argument0.chargesUp && argument0.readyToShoot) && !(argument0.overheats && argument0.overheated) {
        // charging logic
        // if a grenade toss operation is not occuring...
        if (grenadeTossFrame == -1) {
            if (argument0.chargeLevel == 0) {
                // weapon's charge is currently 0
                
                // check to see if we should begin charging
                if (((keyState & argument0.fullAuto) | pressedKeys) & argument1) && (argument0.ammoCount > 0) {
                    // begin charging
                    argument0.chargeLevel += 1;
                    argument0.chargeSoundID = playsound(x, y, argument0.chargingSound);
                } else if (pressedKeys & argument1) && (argument0.ammoCount == 0) && (argument0.reserveAmmo == 0) {
                    // the key to fire was pressed, BUT there's no ammo at all
                    if (player == global.myself) {
                        // play the no-ammo sound and display the no-ammo warning
                        FMODSoundPlay(global.NoAmmoClickSnd);
                        ammoWarningCheck(argument0, argument2, true);     // flash the ammo warning
                    }
                }
                
            } else if (argument0.chargeLevel >= argument0.maxCharge) {
                // weapon's charge is >= max
                
                // if the weapon auto-fires on a full charge
                if (argument0.autoFireOnFullCharge) {
                    // Fire! (Spartan Laser does this)
                    with (argument0) event_user(1);
                } else {
                    // overcharge or fire (Plasma Pistol does this)
                    if (releasedKeys & argument1) {
                        // fire button's released, so fire
                        // the weapon fires and any charging sound is killed
                        if (FMODInstanceIsPlaying(argument0.chargeSoundID)) FMODInstanceStop(argument0.chargeSoundID);
                        with (argument0) event_user(1);
                    } else {
                        // overcharging, burn through ammo and maintain loop
                        argument0.ammoCount = max(0, argument0.ammoCount - 1);
                        
                        // check if there's still ammo left
                        if (argument0.ammoCount > 0) {
                            loopsoundmaintain(x, y, argument0.chargeSoundID);
                        } else {
                            // if you lose your last ammo, you lose all your charge
                            argument0.chargeLevel = 0;
                            if (FMODInstanceIsPlaying(argument0.chargeSoundID)) FMODInstanceStop(argument0.chargeSoundID);
                        }
                    }
                }
            } else {
                // charge is between 0 and max
                
                // check if the fire button has been released
                if (releasedKeys & argument1) {
                    // fire button's released, check what to do for this weapon
                    if (argument0.onlyFireOnFullCharge) {
                        // the weapon only fires on a full charge, reset the charge and kill the charge sound
                        argument0.chargeLevel = 0;
                        if (FMODInstanceIsPlaying(argument0.chargeSoundID)) FMODInstanceStop(argument0.chargeSoundID);
                    } else {
                        // the weapon fires and any charging sound is killed
                        if (FMODInstanceIsPlaying(argument0.chargeSoundID)) FMODInstanceStop(argument0.chargeSoundID);
                        with (argument0) event_user(1);
                    }
                } else {
                    // keep charging the weapon
                    argument0.chargeLevel = min(argument0.chargeLevel + 1, argument0.maxCharge);
                    // maintain the charging sound
                    loopsoundmaintain(x, y, argument0.chargeSoundID);
                    // if the weapon reached full charge and doesn't auto-fire on full, switch to the
                    // charged sound and loop it
                    if (argument0.chargeLevel == argument0.maxCharge) && (!argument0.autoFireOnFullCharge) {
                        // kill the old sound first
                        FMODInstanceStop(argument0.chargeSoundID);
                        // then start the new one
                        argument0.chargeSoundID = loopsoundstart(x, y, argument0.chargedSound);
                    }
                }
            }
        } else {
            // grenade tossing, set charge level to 0
            argument0.chargeLevel = 0;
            if (FMODInstanceIsPlaying(argument0.chargeSoundID)) FMODInstanceStop(argument0.chargeSoundID);
        }
    // non-chargering weapons that are not overheated (if they can overheat)
    } else if (!argument0.chargesUp) && !(argument0.overheats && argument0.overheated) {
        // non-charging logic
        if (((keyState & argument0.fullAuto) | pressedKeys) & argument1) && (argument0.ammoCount > 0) {
            with (argument0) event_user(1);
        } else if (pressedKeys & argument1) && (argument0.ammoCount == 0) && (argument0.reserveAmmo == 0) {
            // the key to fire was pressed, BUT there's no ammo at all
            if (player == global.myself) {
                // play the no-ammo sound and display the no-ammo warning
                // except if it's an Energy Sword
                if (argument0.weaponType != WEAPON_ENERGYSWORD) FMODSoundPlay(global.NoAmmoClickSnd);
                ammoWarningCheck(argument0, argument2, true);     // flash the ammo warning
            }
        }
    }
    // weapon fire reset event (for things like muzzle spread reset and range reset)
    // fires on key release or weapon reload
    if ((releasedKeys & argument1) || (argument0.alarm[4] == argument0.reloadTime - 1)) {
        with (argument0) event_user(2);
    }
}
