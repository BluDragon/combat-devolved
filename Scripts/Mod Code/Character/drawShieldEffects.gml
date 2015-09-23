/* Draws character shield effects.  Made into a seperate script in case I need to move it around.
**
** argument0 = instance ID of the character
*/
{
    // draw some sparks if shields are down
    if (argument0.shieldHp <= 0) {
        var xOff, yOff, rot;
        repeat (8) {
            // use the character's bounding box to get the positions of the sparks, to account for crouching, and add a little on the sides
            xOff = irandom_range(argument0.bbox_left - 1, argument0.bbox_right + 1);
            // subtract a little from the top, for the helmet, and the bottom so it doesn't clip into the ground
            yOff = irandom_range(argument0.bbox_top - 9, argument0.bbox_bottom - 2);
            rot = irandom_range(0, 15) * 22.5;
            draw_sprite_ext(ArmorShieldSparkS, 0, xOff, yOff, 1, 1, rot, c_white, argument0.cloakAlpha);
        }
    }
    
    // draw the shield recharge effects if shields are charging
    if ((argument0.timeUnscathed >= 127) && (argument0.timeUnscathed < 142) && (argument0.lastDamageSource != -1)) {
        var prog, yOff;
        
        prog = ((argument0.timeUnscathed - 127) / 15);
        yOff = 32 - prog * 80;
        
        //draw_sprite_ext(ArmorShieldRecharge, 0, round(argument0.x), round(argument0.y) + yOff, 1, 1, 0, c_white, 1);
        if (yOff > 0) {
            draw_sprite_part_ext(ArmorShieldRechargeS, 0, 0, 0, 30, max(0, 32 - yOff), round(argument0.x - 15), round(argument0.y) + (32 - max(0, 32 - yOff)), 1, 1, c_white, argument0.cloakAlpha);
        } else if (yOff < -15) {
            draw_sprite_part_ext(ArmorShieldRechargeS, 0, 0, min(40, abs(yOff + 15)), 30, 40 + (yOff + 15), round(argument0.x - 15), round(argument0.y) - 15, 1, 1, c_white, argument0.cloakAlpha);
        } else {
            draw_sprite_ext(ArmorShieldRechargeS, 0, round(argument0.x), round(argument0.y) + yOff, 1, 1, 0, c_white, argument0.cloakAlpha);
        }
    }
}
