/* Common weapon damage function -- called by Weapon objects and their projectiles
** 
** argument0 = Instance ID of the character/object that was hit
** argument1 = Amount of damage to deal to shields
** argument2 = Amount of damage to deal to HP
** argument3 = Whether damage will bleed over from the shields to the HP
** argument4 = Whether a headshot will instakill if shields are down
** argument5 = Whether a headshot will instakill regardless
** argument6 = Owner player of the damage source
** argument7 = Damage source weapon type
*/
{
    var hDamage, sDamage, headshot, victim;
    
    // determine who we hit and what part
    if (object_is_ancestor(argument0.object_index, Character) || argument0.object_index == Character) {
        headshot = false;
        victim = argument0;
    } else if (argument0.object_index == Helmet) {
        headshot = true;
        victim = argument0.owner;
    } else {
        // nothing that takes damage was hit -- exit the function
        exit;
    }
    
    // determine damage to shields and hp
    sDamage = min(argument1, victim.shieldHp);
    // if shields are still up
    if (victim.shieldHp > 0) {
        if (argument3) {
            // hp damage is bled from shields
            hDamage = argument1 - sDamage;
        } else {
            // no hp damage
            hDamage = 0;
        }
    } else {
        // hp damage is base damage
        hDamage = argument2;
    }
    
    // if the shields took damage, flash them
    if (sDamage > 0) victim.shieldFlash = 8;
    
    // headshot cases
    if (headshot && argument4 && hDamage > 0) {
        // instakill if target's shields are down or damage bleed would occur
        victim.hp = 0;
    } else if (headshot && argument5) {
        // instakill
        victim.hp = 0;
    } else {
        // normal damage
        victim.shieldHp -= sDamage;
        victim.hp -= hDamage;
    }

    // TODO: implement GG2's assist killing code
    victim.timeUnscathed = 0;
    victim.lastDamageDealer = argument6;
    victim.lastDamageSource = argument7;
    
    // force the victim to uncrouch if crouched
    if (victim.crouched) {
        with (victim) {
            toggleCrouch(false);
        }
    }
}
