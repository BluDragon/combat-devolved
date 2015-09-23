/* Draws the cursor
*/
{
    var xoffset, yoffset, xsize, ysize;
    var colID, curWeap, zoomed, dualWielding;
    var npx, npy;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    // by default we're not zoomed
    zoomed = false;
    dualWielding = false;
    
    // if the cursor is not the default pointer we do some extra checks
    if (sprite_index != CrosshairS) {
        // first, check if we exist as a character
        if (myCharExists()) {
            // we do exist as a character and we're wielding a weapon
            image_index = 0;    // the frame defaults to the standard frame
            curWeap = global.myself.object.weapons[global.myself.object.currentWeapon];
            
            // check if we're dual-wielding
            dualWielding = (global.myself.object.state == CHAR_STATE_DUALWIELD);
            
            // get if we're zoomed
            zoomed = global.myself.object.zoomed;
            
            // first check to see if the cursor is over an enemy
            colID = collision_point(mouse_x, mouse_y, Character, false, true);
            if (colID < 0) {
                colID = collision_point(mouse_x, mouse_y, Helmet, false, true);
                if (colID > -1) colID = colID.owner;
            }
            // if it's > -1 then there's someone under the cursor, check if it's a foe
            if (colID > -1) {
                // set the default nameplate color
                draw_set_color(c_white);
                // if they're not on the same team, and not crouch-cloaked then turn the cursor red
                // also use red for the nameplate's text
                if (!onSameTeam(colID.player, global.myself) && !colID.crouchCloaked) {
                    image_index = 1;
                    draw_set_color(c_red);
                }
                
                // draw the nameplate above the character if they're not clocked
                if (!colID.crouchCloaked) {
                    draw_set_halign(fa_center);
                    npx = colID.x;
                    npy = colID.y;
                    
                    draw_text_transformed(npx, npy - 26, colID.player.name, 1, 1, 0);
                }
            }
            
            // then do weapon-specific checks
            if (curWeap.weaponType == WEAPON_SPARTANLASER) {
                // a spartan laser is being wielded, draw the charge indicator
                draw_sprite_ext(SpartanLaserReticleArrowS, image_index, mouse_x, mouse_y, 1, 1, curWeap.chargeLevel / curWeap.maxCharge * 180, c_white, 1);
            }
        }
    }
    
    // draw the cursor
    if (zoomed) {
        // always draw the cursor in the dead center if we're zoomed in
        draw_sprite_ext(sprite_index, image_index, xoffset + xsize / 2, yoffset + ysize / 2, 1, 1, 0, c_white, 1);
        // draw the additional reticle, if it's not the same sprite
        if ((dualWielding) && (sprite_index != dualWieldSprite)) {
            draw_sprite_ext(dualWieldSprite, image_index, xoffset + xsize / 2, yoffset + ysize / 2, 1, 1, 0, c_white, 1);
        }
    } else {
        // draw the cursor normally
        draw_sprite_ext(sprite_index, image_index, mouse_x, mouse_y, 1, 1, 0, c_white, 1);
        // draw the additional reticle
        if ((dualWielding) && (sprite_index != dualWieldSprite)) {
            draw_sprite_ext(dualWieldSprite, image_index, mouse_x, mouse_y, 1, 1, 0, c_white, 1);
        }
    }
}
