/* Draws an intel/cp target pointer on the screen
**
** argument0 = target's x
** argument1 = target's y
** argument2 = team color to use for the pointer
** argument3 = pointer status to use (solid = 0, broken = 1)
** argument4 = height above the target to draw the pointer
** argument5 = what sprite to draw by the pointer (-1 for null)
** argument6 = aux. data -- in the case of a sprite, what FRAME to draw
**                  if no sprite is specified, it will draw this number
**                  if this value is -1, it is ignored entirely
** argument7 = the color to use for the text (TEAM_RED, TEAM_BLUE, all else default to grey)
*/
{
    var xoffset, yoffset, xsize, ysize;
    var xmin, xmax, ymin, ymax, hBorder, vBorder;
    var sX, sY;
    var tColor, sColor;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    hBorder = 30;    // how many pixels away from the edge of the screen before we switch
    vBorder = 30;    // to pointing to the intel as being on-screen

    xmin = xoffset + hBorder;
    xmax = xoffset + xsize - hBorder;
    ymin = yoffset + vBorder;
    ymax = yoffset + ysize - vBorder;
    
    // set the text color that might be used
    if (argument7 == TEAM_RED) {
        tColor = make_color_rgb(242, 149, 149);
        sColor = make_color_rgb(233, 73, 73);
    } else if (argument7 == TEAM_BLUE) {
        tColor = make_color_rgb(148, 191, 242);
        sColor = make_color_rgb(73, 146, 233);
    } else {
        tColor = make_color_rgb(229, 229, 229);
        sColor = make_color_rgb(187, 187, 187);
    }    
    
    // check to see if the intel is on the screen somewhere
    if ((argument0 >= xmin) && (argument0 <= xmax) && (argument1 >= ymin) && (argument1 <= ymax)) {
        // the intel is on-screen, draw the arrow some height above it
        if (argument2 == TEAM_BLUE) {
            draw_sprite_ext(HaloIntelArrowBlueS, argument3, argument0, argument1 - argument4, 1, 1, -90, c_white, 1);
        } else {
            draw_sprite_ext(HaloIntelArrowRedS, argument3, argument0, argument1 - argument4, 1, 1, -90, c_white, 1);
        }
        
        // draw aux data (sprite or text)
        if (argument5 != -1) {
            // draw a sprite
            // get the vertical offset for the sprite's drawing
            // add 20 to account for the arrow's size (14 pixels)
            sY = -sprite_get_height(argument5) + sprite_get_yoffset(argument5) - 20;
            draw_sprite_ext(argument5, argument6, argument0, argument1 - argument4 + sY, 1, 1, 0, c_white, 1);
        } else if (argument6 != -1) { 
            // aux data (a number to draw)
            draw_set_halign(fa_middle);
            draw_set_valign(fa_bottom);
            sY = 20;
            draw_text_shadow(argument0, argument1 - sY, string(argument6), 3, 3, 0, tColor, sColor, 1);
        }
    } else {
        // the intel is off-screen
        // figure out which edge it should be drawn on
        if (argument0 < xmin) {
            // off to the left
            xr = xmin;
            yr = max(ymin, min(argument1, ymax));
            // check if it's far up or far down
            if ((argument1 < ymin) && (ymin - argument1 > xmin - argument0)) {
                // far up
                flagDir = 90;
            } else if ((argument1 > ymax) && (argument1 - ymax > xmin - argument0)) {
                // far down
                flagDir = -90;
            } else {
                // not too far up or down
                flagDir = 180;
            }
            
        } else if (argument0 > xmax) {
            // off to the right
            xr = xmax;
            yr = max(ymin, min(argument1, ymax));
            // check if it's far up or far down
            if ((argument1 < ymin) && (ymin - argument1 > argument0 - xmax)) {
                // far up
                flagDir = 90;
            } else if ((argument1 > ymax) && (argument1 - ymax > argument0 - xmax)) {
                // far down
                flagDir = -90;
            } else {
                // not too far up or down
                flagDir = 0;
            }
            
        } else {
            // up or down
            xr = argument0;
            if (argument1 < ymin) {
                yr = ymin;
                flagDir = 90;
            } else {
                yr = ymax;
                flagDir = -90;
            }
        }
        
        // determine where to draw the sprite/text based on flag direction
        if (argument5 != -1) {
            // sprites
            if (flagDir == 0) {
                sX = -sprite_get_width(argument5) + sprite_get_xoffset(argument5) - 20;
                sY = 0;
            } else if (flagDir == 90) {
                sX = 0;
                sY = sprite_get_yoffset(argument5) + 20;
            } else if (flagDir == -90) {
                sX = 0;
                sY = -sprite_get_height(argument5) + sprite_get_yoffset(argument5) - 20;
            } else if (flagDir == 180) {
                sX = sprite_get_xoffset(argument5) + 20;
                sY = 0;
            }
        } else {
            // text
            if (flagDir == 0) {
                draw_set_halign(fa_right);
                draw_set_valign(fa_middle);
                sX = -20;
                sY = 0;
            } else if (flagDir == 90) {
                draw_set_halign(fa_middle);
                draw_set_valign(fa_top);
                sX = 0;
                sY = 20;
            } else if (flagDir == -90) {
                draw_set_halign(fa_middle);
                draw_set_valign(fa_bottom);
                sX = 0;
                sY = -20;
            } else if (flagDir == 180) {
                draw_set_halign(fa_left);
                draw_set_valign(fa_middle);
                sX = 20;
                sY = 0;
            }
        }
        
        // finally draw the flag where it belongs
        if (argument2 == TEAM_BLUE) {
            draw_sprite_ext(HaloIntelArrowBlueS, argument3, xr, yr, 1, 1, flagDir, c_white, 1);
        } else {
            draw_sprite_ext(HaloIntelArrowRedS, argument3, xr, yr, 1, 1, flagDir, c_white, 1);
        }
        
        // draw aux data (sprite or text)
        if (argument5 != -1) {
            // draw a sprite
            draw_sprite_ext(argument5, argument6, xr + sX, yr + sY, 1, 1, 0, c_white, 1);
        } else if (argument6 != -1) {
            // aux data (a number to draw)
            draw_text_shadow(xr + sX, yr + sY, string(argument6), 3, 3, 0, tColor, sColor, 1);
        }
    }
}
