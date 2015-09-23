{
    // draw the visor borders
    var xoffset, yoffset, xsize, ysize, tAlpha;
    var tColor, sColor;
    var zoomed, iExist, i;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    // define text and shadow colors
    tColor = make_color_rgb(148, 191, 242);
    sColor = make_color_rgb(73, 146, 233);
    
    // check if the player character exists
    iExist = myCharExists();
    
    // check if the player exists and is zoomed in
    zoomed = false;
    if (iExist) {
        zoomed = global.myself.object.zoomed;
    }
    
    if (zoomed) {
        // draw the zoom masks as necessary
        var zMaskLeft, zMaskTop, zMaskRight, zMaskBottom, zSprite;
        
        // get the rect of the zoom mask
        zSprite = global.myself.object.weapons[global.myself.object.currentWeapon].zoomMaskSprite;
        zMaskLeft = xsize / 2 - sprite_get_xoffset(zSprite);
        zMaskTop = ysize / 2 - sprite_get_yoffset(zSprite);
        zMaskRight = zMaskLeft + sprite_get_width(zSprite);
        zMaskBottom = zMaskTop + sprite_get_height(zSprite);
        
        // draw the zoom mask dead center
        draw_sprite_ext(zSprite, 0, xoffset + xsize / 2, yoffset + ysize / 2, 1, 1, 0, c_white, 1);
        
        // draw the two areas to the sides of the mask
        draw_set_color(c_black);
        draw_set_alpha(0.5);
        draw_rectangle(xoffset, yoffset, xoffset + zMaskLeft - 1, yoffset + ysize, false);
        draw_rectangle(xoffset + zMaskRight, yoffset, xoffset + xsize, yoffset + ysize, false);
        // then the two to the top and bottom
        draw_rectangle(xoffset + zMaskLeft, yoffset, xoffset + zMaskRight - 1, yoffset + zMaskTop - 1, false);
        draw_rectangle(xoffset + zMaskLeft, yoffset + zMaskBottom, xoffset + zMaskRight - 1, yoffset + ysize, false);
        
        // restore color and alpha
        draw_set_color(c_white);
        draw_set_alpha(1);
                        
    } else {
        // default drawing behaviour
        draw_sprite_ext(TopBorderS, 0, xoffset, yoffset, 1, 1, 0, c_white, 1);
        draw_sprite_ext(BottomBorderS, 0, xoffset, yoffset + ysize, 1, 1, 0, c_white, 1);
        
        // player character specific drawing
        if (iExist) {
            // draw the health HUD
            var hpPer, barLength, cOffset;
            
            // determine the color, alpha, and bar length to use
            hpPer = global.myself.object.shieldHp / global.myself.object.maxShieldHp;
            barLength = 200 * hpPer;
            tAlpha = 1;
            if (hpPer > 0.2) {
                cOffset = 0;
            } else if (hpPer != 0) {
                cOffset = 2;
            } else {
                // shields down, draw the flashing warning and the full bar will flash along with it
                cOffset = 2;
                tAlpha = 1 - (global.myself.object.timeUnscathed mod hudFlashSpeed) / hudFlashSpeed;
                draw_sprite_ext(ShieldWarningS, 0, xoffset, yoffset, 1, 1, 0, c_white, tAlpha);
                barLength = 200;
            }
            // draw the shield underlay
            draw_sprite_part_ext(ShieldBarS, cOffset + 1, 0, 0, barLength, 23, view_xview[0] + view_wview[0] / 2 - 100, view_yview[0] + 38, 1, 1, c_white, tAlpha);
            // draw the shield overlay
            draw_sprite_ext(ShieldBarS, cOffset, view_xview[0] + view_wview[0] / 2, view_yview[0] + 49, 1, 1, 0, c_white, 1);
            
            // if the ammo flash is active (for left and right)
            if (ammoFlashLeft) {
                tAlpha = 1 - ammoFlashLeftFrame / hudFlashSpeed;
                draw_sprite_ext(AmmoWarningS, 0, xoffset + xsize / 2, yoffset, -1, 1, 0, c_white, tAlpha);
            }
            if (ammoFlashRight) {
                tAlpha = 1 - ammoFlashRightFrame / hudFlashSpeed;
                draw_sprite_ext(AmmoWarningS, 0, xoffset + xsize / 2, yoffset, 1, 1, 0, c_white, tAlpha);
            }
            
            // draw the sidearm icon
            var sIconOffset, sIconSprite;
            sIconSprite = global.weaponHudIcon[global.myself.object.weapons[global.myself.object.currentWeapon xor 1].weaponType];
            sIconOffset = floor(sprite_get_width(sIconSprite) * 0.7);
            draw_sprite_ext(sIconSprite, 0, xoffset + xsize - sIconOffset - 50, yoffset + 89, 0.7, 0.7, 0, c_white, 1);
        }
    }
    
    // common player-specific drawing
    if (iExist) {
        var gAlpha;
        
        // draw the default ammo HUD
        drawAmmoHud(global.myself.object.weapons[global.myself.object.currentWeapon], false);
        
        // if dual wielding, draw the left HUD, if not, draw the grenade stock
        if (global.myself.object.state == CHAR_STATE_DUALWIELD) {
            drawAmmoHud(global.myself.object.weapons[2], true);
        } else {
            // draw the grenade stock HUD
            var haveGrenades;
            haveGrenades = false;
            
            draw_set_halign(fa_right);
            draw_set_valign(fa_middle);
            for (i = 0; i < 4; i += 1) {
                if (global.myself.object.grenadeAmmo[i] == 0) {
                    gAlpha = 0.4;
                } else {
                    gAlpha = 1;
                    haveGrenades = true;
                }
                // draw the stock number
                //draw_text_shadow(xoffset + 50 + i * 39, yoffset + 36, string(global.myself.object.grenadeAmmo[i]), 2, 2, 0, tColor, sColor, gAlpha);
                draw_text_transformed_color(xoffset + 50 + i * 39, yoffset + 36, string(global.myself.object.grenadeAmmo[i]), 2, 2, 0, tColor, tColor, tColor, tColor, gAlpha);
                // draw the grenade icon
                draw_sprite_ext(GrenadeIconsS, i, xoffset + 50 + i * 39, yoffset + 36, 1, 1, 0, c_white, gAlpha);
            }
            
            // draw the grenade selection box if we have ammo
            if (haveGrenades) draw_sprite_ext(GrenadeSelectionS, 0, xoffset + 50 + global.myself.object.currentGrenade * 39, yoffset + 36, 1, 1, 0, c_white, 1);
        }
        
        // draw the weapon switch prompt, if appropriate
        if (nearestPickupWeapon != noone) && (instance_exists(nearestPickupWeapon)) {
            var iconWidth, iconSprite;
            
            iconSprite = global.weaponHudIcon[nearestPickupWeapon.weaponType];
            iconWidth = sprite_get_width(iconSprite);
            iconHeight = sprite_get_height(iconSprite);
            
            draw_set_halign(fa_right);
            draw_set_valign(fa_middle);
            draw_text_shadow(xoffset + xsize - 34, yoffset + 104, "Hold " + keyNameString(global.keyPickup) + " to pick up", 1, 1, 0, tColor, sColor, 1);
            draw_sprite_ext(iconSprite, 0, xoffset + xsize - 104 - iconWidth / 2, yoffset + 114 + iconHeight / 2, 1, 1, 0, c_white, 1);
        }
        
        // draw the dual wield prompt, if appropriate
        if (nearestDualWeapon != noone) && (instance_exists(nearestDualWeapon)) {
            var iconWidth, iconSprite;
            
            iconSprite = global.weaponHudIcon[nearestDualWeapon.weaponType];
            iconWidth = sprite_get_width(iconSprite);
            iconHeight = sprite_get_height(iconSprite);
            
            draw_set_halign(fa_left);
            draw_set_valign(fa_middle);
            draw_text_shadow(xoffset + 34, yoffset + 104, "Hold " + keyNameString(global.keySwapGrenade) + " to dual-wield", 1, 1, 0, tColor, sColor, 1);
            draw_sprite_ext(iconSprite, 0, xoffset + 104 + iconWidth / 2, yoffset + 114 + iconHeight / 2, -1, 1, 0, c_white, 1);
        }
    }
    
}
