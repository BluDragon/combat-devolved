{
    var xoffset, yoffset, xsize, ysize, dString;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    // set the text settings
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // always draw the FPS
    dString = "FPS: " + string(fps) + " (" + string_format(fps / room_speed * 100, 3, 0) + "%)#";
    
    // if a character exists
    if (myCharExists()) {
        dString += "#---[ Character ]---#"
        dString += "state = "
        switch (global.myself.object.state) {
            case CHAR_STATE_NORMAL:
                dString += "NORMAL#";
                break;
            case CHAR_STATE_DUALWIELD:
                dString += "DUAL WIELD#";
                break;
            case CHAR_STATE_HEAVYTURRET:
                dString += "HEAVY TURRET#";
                break;
            case CHAR_STATE_HEAVYGUN:
                dString += "HEAVY GUN#";
                break;
            default:
                dString += "UNKNOWN (" + string(global.myself.object.state) + ")#";
        }
        dString += "currentWeapon = " + string(global.myself.object.currentWeapon) + "#";
    }
    
    // draw the debug string
    draw_text_outline(xoffset + 8, yoffset + 8, dString, 1, 1, 0, c_yellow, c_black);
}
