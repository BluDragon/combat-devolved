/* Performs a dual-wield weapon drop event
**
** argument0 = The player who's leaving dual-wield mode and dropping the weapon (by instance ID)
*/

{
    var wp, wp2, amount;
    
    // if the character was in heavy-gun mode, reset the currentWeapon to 0
    if (argument0.object.state == CHAR_STATE_HEAVYGUN) {
        argument0.object.currentWeapon = 0;
        // set the equip delay for the weapon
        with (argument0.object.weapons[argument0.object.currentWeapon]) {
            alarm[2] = 15;
            readyToShoot = false;
        }
    }
    
    // the character stops dual-wielding and does so just this frame
    argument0.object.state = CHAR_STATE_NORMAL;
    argument0.object.dualJustDropped = true;
    
    wp2 = argument0.object.weapons[2];
    wp = argument0.object.weapons[argument0.object.currentWeapon];
    
    // if the two weapons were of the same type, shove as much reserve ammo from the off-hand
    // one into the first as possible before the drop (reserve ammo pooling feature)
    if (wp.weaponType == wp2.weaponType) {
        amount = min(wp2.reserveAmmo, wp.maxReserve - wp.reserveAmmo);
        wp2.reserveAmmo -= amount;
        wp.reserveAmmo += amount;
    }
    
    // spawn the dual weapon as a powerup
    
    if (wp2.ammoCount + wp2.reserveAmmo > 0) {
        doEventWeaponSpawn(wp2.weaponType, wp2.ammoCount + wp2.reserveAmmo, 900, argument0.object.x, argument0.object.y, 0, 0);
    }
    // then destroy it
    with (wp2) {
        instance_destroy();
    }
}
