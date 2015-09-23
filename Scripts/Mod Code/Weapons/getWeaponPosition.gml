/* Returns a weapon's 'position', based on the owner's dual wielding status and facing
** direction.  This is used to determine where to draw the weapon and where to spawn
** projectiles/hitscans from.
**
** argument0 == Instance ID of the weapon to check
**
** The following values are returned:
** 0 = Weapon is unequipped and stowed on the body
** 1 = Weapon is equipped and 'on top' of the character
** 2 = Weapon is equipped and 'beneath' the character
*/

{
    switch (argument0.owner.state) {
        case CHAR_STATE_NORMAL:
            if (argument0.owner.weapons[argument0.owner.currentWeapon] == argument0) {
                // on top
                return 1;
            } else {
                // unequipped weapon
                return 0;
            }
            break;
            
        case CHAR_STATE_DUALWIELD:
            if (argument0.owner.weapons[2] == argument0) {
                if (sign(argument0.image_xscale) == 1) {
                    return 2;
                } else {
                    return 1;
                }
            } else if (argument0.owner.weapons[argument0.owner.currentWeapon] == argument0) {
                if (sign(argument0.image_xscale) == 1) {
                    return 1;
                } else {
                    return 2;
                }
            } else {
                // unequipped weapon
                return 0;
            }
            break;
            
        case CHAR_STATE_HEAVYTURRET:
            // TODO: the heavy turret stuff
            return 0;
            break;
            
        case CHAR_STATE_HEAVYGUN:
            if (argument0.owner.weapons[2] == argument0) {
                // on top
                return 1;
            } else {
                // unequipped weapon
                return 0;
            }
            break;
    }
    
    return 0;
}
