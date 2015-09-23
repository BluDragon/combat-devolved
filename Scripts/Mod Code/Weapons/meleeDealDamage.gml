/* Common melee damage function
** 
** argument0 = Instance ID of the character that was damaged
** argument1 = How much damage to inflict
*/

{
    var damageBleed;
    
    // first check to see if the victim was hit in the back
    if (argument0.image_xscale == 1 && x < argument0.x) || (argument0.image_xscale == -1 && x > argument0.x) {
        // victim was hit in the back, instakill
        argument0.hp = 0;
        argument0.shieldHp = 0;
        
        argument0.lastDamageDealer = player;
        argument0.lastDamageSource = MELEE_BACKSTAB;
    } else {
        // normal damage behaviour from weaponDealDamage
        if (argument0.shieldHp > 0) argument0.shieldFlash = 8;
        
        // calculate the damage bleed-through for shields and HP
        damageBleed = max(0, argument1 - argument0.shieldHp);
        
        // damage the shields and HP
        argument0.shieldHp = max(0, argument0.shieldHp - argument1);
        argument0.hp -= damageBleed;
        
        argument0.timeUnscathed = 0;
        // TODO: implement GG2's assist killing code
        argument0.lastDamageDealer = player;
        argument0.lastDamageSource = MELEE_STRIKE;
        
        // force the target to uncrouch if crouched
        if (argument0.crouched) {
            with (argument0) {
                toggleCrouch(false);
            }
        }
    }
}
