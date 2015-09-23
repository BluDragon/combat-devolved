/* Common explosive/splash damage function
**
** argument0 = x-coordinate of damage origin
** argument1 = y-coordinate of damage origin
** argument2 = damage radius in pixels
** argument3 = minimum amount of damage to deal
** argument4 = maximum amount of damage to deal
** argument5 = the 'owner' of the damage source, a player instance ID
** argument6 = the weapon type to use for the damage
*/
{
    // create the explosive dummy mask in the appropriate spot for the distance checks
    global.paramMask = instance_create(argument0, argument1, ExplosiveDummyMask);
    
    // check if the owner instance exists
    if (!instance_exists(argument5)) {
        // the owner does not exist or is noone -- anyone can be hurt by the blast
        argument5 = noone;
    }
    
    // Damage every enemy in range
    with (Character) {
        var hurtThem;
        var victimDistance;
        
        hurtThem = false;
        
        // if there is no owner, anyone in range can be hurt
        if (argument5 == noone) {
            // no owner
            // get the distance for the character and then their helmet, and use the closer
            with (headHelmet) global.paramDistance = distance_to_object(global.paramMask);
            victimDistance = min(distance_to_object(global.paramMask), global.paramDistance);
            // check if the victim is within range
            if (victimDistance < argument2) hurtThem = true;
        } else {
            // there is an owner
            // check if the victim is within range, an enemy, or the owner
            if (!onSameTeam(player, argument5) || (player == argument5)) {
                // get the distance for the character and then their helmet, and use the closer
                with (headHelmet) global.paramDistance = distance_to_object(global.paramMask);
                victimDistance = min(distance_to_object(global.paramMask), global.paramDistance);
            }
            if (victimDistance < argument2) hurtThem = true;
        }
        
        // hurt them if they're a victim
        if (hurtThem) {
            var damage, damageBleed;
            
            // calculate the damage linearly based on distance from the explosion
            damage = argument3 + (1 - victimDistance / argument2) * (argument4 - argument3);
            
            // TODO/NOTE: The rest of this was adapted from the weaponDealDamage script,
            // and thus assists and whatnot need to be implemented here, too
            // if shields take damage, do the flash
            if (shieldHp > 0) shieldFlash = 8;
            
            // damage shields and HP
            damageBleed = max(0, damage - shieldHp);
            shieldHp = max(0, shieldHp - damage);
            hp -= damageBleed;
            
            // TODO: implement GG2's assist killing code            
            timeUnscathed = 0;
            lastDamageDealer = argument5;
            lastDamageSource = argument6;
            
            // force uncrouch if crouched
            if (crouched) toggleCrouch(false);
        }
    }
    
    // destroy the explosive dummy
    with (global.paramMask) instance_destroy();
    global.paramMask = noone;
    global.paramDistance = 0;
}
