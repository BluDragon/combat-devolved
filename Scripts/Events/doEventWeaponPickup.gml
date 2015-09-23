/* Swap a player's weapon
**
** argument0 = The player who's swapping a weapon (by instance ID)
** argument1 = The array index of the weapon being picked up/swapped out (0,1 = normals, 2 = dual wield)
** argument2 = The weapon powerup (by instance ID)
*/

{
    // NOTE: because the spawning of a new weapon is implicit with a weapon swap,
    // the host and clients can both call it within this event
    
    var wp, wp2, totalAmmo;
    
    // if a weapon already exists in that slot, spawn a new weapon powerup
    if (instance_exists(argument0.object.weapons[argument1])) {
        // spawn the new powerup
        wp = argument0.object.weapons[argument1];
        if (wp.ammoCount + wp.reserveAmmo > 0) {
            doEventWeaponSpawn(wp.weaponType, wp.ammoCount + wp.reserveAmmo, 900, argument0.object.x, argument0.object.y, 0, 0);
        }
    
        // then destroy the old weapon
        with (wp) {
            instance_destroy();
        }
    }
    
    // create a new weapon object and set its properties based on the powerup
    global.paramPlayer = argument0;
    global.paramOwner = argument0.object;
    argument0.object.weapons[argument1] = instance_create(argument0.object.x, argument0.object.y, global.weaponObject[argument2.weaponType]);
    global.paramOwner = noone;
    global.paramPlayer = noone;
    
    // now set its properties (ammo)
    wp = argument0.object.weapons[argument1];
    wp.ammoCount = min(global.weaponMaxAmmo[wp.weaponType], argument2.ammo);
    wp.reserveAmmo = min(global.weaponMaxReserve[wp.weaponType], argument2.ammo - wp.ammoCount);
    
    // set it so it's animating the swap
    with (wp) {
        alarm[2] = 15;
        readyToShoot = false;
    }
    
    // if the weapon was picked up into the auxilliary slot...
    if (argument1 == 2) {
        // if the weapon is a heavy weapon, the player is in that mode
        if (global.weaponHeavyWield[wp.weaponType]) {
            argument0.object.state = CHAR_STATE_HEAVYGUN;
            // the player also switches their active weapon to slot 2
            argument0.object.currentWeapon = 2;
        } else {
            // it's not a heavy weapon, so the player is dual wielding
            argument0.object.state = CHAR_STATE_DUALWIELD;
            // if the DW weapon and the current weapon are of the same type, combine and split their
            // ammo reserves amongst the two
            wp2 = argument0.object.weapons[argument0.object.currentWeapon];
            if (wp.weaponType == wp2.weaponType) {
                // they're both the same type, combline and split reserves
                totalAmmo = wp.reserveAmmo + wp2.reserveAmmo;
                wp2.reserveAmmo = ceil(totalAmmo / 2);  // the right hand will take the one extra if there is any
                wp.reserveAmmo = floor(totalAmmo / 2);
            }
        }
    }
    
    // destroy the weapon powerup
    doEventWeaponDespawn(argument2);
    
    // if the new weapon is not DW-compatible, and we were dual-wielding before, stop and drop
    if (!global.weaponDualWield[wp.weaponType] && (argument0.object.state == CHAR_STATE_DUALWIELD)) {
        doEventWeaponDualDrop(argument0);
    }
    
    // force the character to unzoom if they were zoomed
    if (argument0.object.zoomed) {
        argument0.object.zoomed = false;
        if (argument0 == global.myself) undoZoomCursor();
    }
    
    if (argument0 == global.myself) {
        // finally, play the equip sound for that weapon
        FMODSoundPlay(wp.equipSound);
        // and swap the cursors
        if (argument1 != 2) {
            Cursor.sprite_index = wp.reticleSprite;
        } else {
            // Set the 'additional' sprite cursor for the left-hand weapon
            Cursor.dualWieldSprite = wp.reticleSprite;
        }
    }
}
