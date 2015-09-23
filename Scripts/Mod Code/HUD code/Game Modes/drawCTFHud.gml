// Draw the score and timer HUDs for CTF mode, as well as flag pointers
{
    var xoffset, yoffset, xsize, ysize;
    var teamBar, perBar, xr, yr, capString, myTeamPrefix;
    var tColor, sColor;
    var rFore, rBack, yFore, yBack;
    var redx, redy, bluex, bluey, redIntelStatus, blueIntelStatus, redArrow, blueArrow;
    var cLimit;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    // define text and shadow colors
    tColor = make_color_rgb(148, 191, 242);
    sColor = make_color_rgb(73, 146, 233);
    
    draw_set_alpha(1);
    draw_set_halign(fa_right);
    draw_set_valign(fa_middle);
    
    myTeamPrefix = ">";
    
    if (global.myself == -1) exit;
    
    // abort draw if the user is zoomed in -- the HUD isn't drawn if we're scoped
    if (global.myself.object != -1) {
        if (global.myself.object.zoomed) exit;
    }
    
    // draw the flag pointers
    if (instance_exists(IntelligenceRed)) {
        redx = IntelligenceRed.x;
        redy = IntelligenceRed.y;
        if ((IntelligenceRed.x == IntelligenceBaseRed.x && IntelligenceRed.y == IntelligenceBaseRed.y) || (IntelligenceRed.alarm[0] <= 0)) {
            // the flag is at home
            redIntelStatus = 0;
            redArrow = 0;
        } else {
            // the flag is dropped
            redIntelStatus = 1;
            redArrow = 1;
        }
    } else {
        for(i = 0; i < ds_list_size(global.players); i += 1) {
            player = ds_list_find_value(global.players, i);
            if ((player.team == TEAM_BLUE) && (player.object!= -1)) {
                if (player.object.intel == true) {
                    redx = player.object.x;
                    redy = player.object.y;
                }
            }
        }
        // the flag is in enemy hands        
        redIntelStatus = 2;
        redArrow = 1;
    }
    
    if (instance_exists(IntelligenceBlue)) {
        bluex = IntelligenceBlue.x;
        bluey = IntelligenceBlue.y;
        if ((IntelligenceBlue.x == IntelligenceBaseBlue.x && IntelligenceBlue.y == IntelligenceBaseBlue.y) || (IntelligenceBlue.alarm[0] <= 0)) {
            // the flag is at home
            blueIntelStatus = 0;
            blueArrow = 0;
        } else {
            // the flag is dropped
            blueIntelStatus = 1;
            blueArrow = 1;
        }
    } else {
        for(i = 0; i < ds_list_size(global.players); i += 1) {
            player = ds_list_find_value(global.players, i);
            if ((player.team == TEAM_RED) && (player.object != -1)) {
                if (player.object.intel == true) {
                    bluex = player.object.x;
                    bluey = player.object.y;
                }
            }
        }
        // the flag is in enemy hands
        blueIntelStatus = 2;
        blueArrow = 1;
    }
    
    /*
    // NOTE: Drawing disabled for Free-For-All testing
    drawFlagPointer(bluex, bluey, TEAM_BLUE, blueArrow, 45, HaloArrowIconsS, blueIntelStatus, -1);
    drawFlagPointer(redx, redy, TEAM_RED, redArrow, 45, HaloArrowIconsS, redIntelStatus, -1);
    */
    
    // reset the text alignment after the pointer drawing
    draw_set_alpha(1);
    draw_set_halign(fa_right);
    draw_set_valign(fa_middle);
    
    // draw the flag reset meters for dropped flags
    myTeam = global.myself.team mod 2;  // if spectating, default to RED
    
    // if both flags are dropped, draw both meters, with the player's team on top
    if ((redIntelStatus == 1) && (blueIntelStatus == 1)) {
        // draw the player's team
        teamBar = myTeam;
        if (teamBar == TEAM_RED) perBar = (900 - IntelligenceRed.alarm[0]) / 900;
        if (teamBar == TEAM_BLUE) perBar = (900 - IntelligenceBlue.alarm[0]) / 900;
        xr = xoffset + xsize / 2 - 94;
        yr = yoffset + ysize - 56;
        drawCapBar(xr, yr, teamBar, perBar);
        
        // draw the other team
        teamBar = myTeam xor 1;
        if (teamBar == TEAM_RED) perBar = (900 - IntelligenceRed.alarm[0]) / 900;
        if (teamBar == TEAM_BLUE) perBar = (900 - IntelligenceBlue.alarm[0]) / 900;
        xr = xoffset + xsize / 2 - 94;
        yr = yoffset + ysize - 35;
        drawCapBar(xr, yr, teamBar, perBar);
        
    } else if (redIntelStatus == 1) {
        // only red is dropped
        teamBar = TEAM_RED;
        perBar = (900 - IntelligenceRed.alarm[0]) / 900;
        xr = xoffset + xsize / 2 - 94;
        yr = yoffset + ysize - 35;
        drawCapBar(xr, yr, teamBar, perBar);
    } else if (blueIntelStatus == 1) {
        // only blue is dropped
        teamBar = TEAM_BLUE;
        perBar = (900 - IntelligenceBlue.alarm[0]) / 900;
        xr = xoffset + xsize / 2 - 94;
        yr = yoffset + ysize - 35;
        drawCapBar(xr, yr, teamBar, perBar);
    }
    
    // prevent a divide by zero error by always assuming the cap limit is at least 1
    // because some idiots actually set the cap limit to 0 for some reason
    cLimit = max(1, global.caplimit);
    // draw the bottom (losing team) bar, default to ENEMY if there's a tie
    if (global.redCaps > global.blueCaps) {
        teamBar = TEAM_BLUE;
        perBar = min(global.blueCaps / cLimit, 1);
        capString = string(global.blueCaps);
        if (global.myself.team == TEAM_BLUE) capString = myTeamPrefix + capString;
    } else if (global.redCaps < global.blueCaps) {
        teamBar = TEAM_RED;
        perBar = min(global.redCaps / cLimit, 1);
        capString = string(global.redCaps);
        if (global.myself.team == TEAM_RED) capString = myTeamPrefix + capString;
    } else {
        // a tie
        teamBar = (global.myself.team mod 2) xor 1;
        if (teamBar == TEAM_RED) {
            perBar = min(global.redCaps / cLimit, 1);
            capString = string(global.redCaps);
        }
        if (teamBar == TEAM_BLUE) {
            perBar = min(global.blueCaps / cLimit, 1);
            capString = string(global.blueCaps);
        }
    }
    // draw the empty bar and then the portion of the full bar
    xr = xoffset + xsize - 120;
    yr = yoffset + ysize - 36;
    // in the case of a tie, draw the larger shine
    if (global.redCaps == global.blueCaps) {
        drawTeamBar(xr, yr, teamBar, perBar, 0);
    } else {
        drawTeamBar(xr, yr, teamBar, perBar, 1);
    }
    draw_text_shadow(xr - 8, yr + 8, capString, 1.7, 1.7, 0, tColor, sColor, 1);
    
    // draw the top (winning team) bar, default to PLAYER if there's a tie   
    if (global.redCaps > global.blueCaps) {
        teamBar = TEAM_RED;
        perBar = min(global.redCaps / cLimit, 1);
        capString = string(global.redCaps);
        if (global.myself.team == TEAM_RED) capString = myTeamPrefix + capString;
    } else if (global.redCaps < global.blueCaps) {
        teamBar = TEAM_BLUE;
        perBar = min(global.blueCaps / cLimit, 1);
        capString = string(global.blueCaps);
        if (global.myself.team == TEAM_BLUE) capString = myTeamPrefix + capString;
    } else {
        // a tie
        teamBar = (global.myself.team mod 2);
        if (teamBar == TEAM_RED) {
            perBar = min(global.redCaps / cLimit, 1);
            capString = string(global.redCaps);
        }
        if (teamBar == TEAM_BLUE) {
            perBar = min(global.blueCaps / cLimit, 1);
            capString = string(global.blueCaps);
        }
        if (global.myself.team != TEAM_SPECTATOR) capString = myTeamPrefix + capString;
    }
    // draw the empty bar and then the portion of the full bar
    xr = xoffset + xsize - 120;
    yr = yoffset + ysize - 58;
    drawTeamBar(xr, yr, teamBar, perBar, 0);
    draw_text_shadow(xr - 8, yr + 8, capString, 1.7, 1.7, 0, tColor, sColor, 1);
    
    // draw the timer
    if (instance_exists(WinBanner)) exit;
    
    xr = xoffset + xsize - 20;
    yr = yoffset + ysize - 72;
    if (overtime == 1) {
        draw_text_shadow(xr, yr, "OVERTIME", 1.7, 1.7, 0, tColor, sColor, 1);
    } else {
        capString = string_time(timer);
        draw_text_shadow(xr, yr, capString, 1.7, 1.7, 0, tColor, sColor, 1);
    }
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // define text and shadow colors for flag alerts
    rFore = make_color_rgb(255, 0, 0);
    rBack = make_color_rgb(192, 0, 0);
    yFore = make_color_rgb(255, 255, 0);
    yBack = make_color_rgb(192, 192, 0);
    
    // draw the flag-owning alerts, but only if we're on a team
    capString = "Your team has the flag!";
    if (global.myself.object != -1) {
        if (global.myself.object.intel) capString = "You have the flag!";
    }
    if (global.myself.team == TEAM_RED) {
        if (blueHold > 0) {
            // we have the enemy's flag!
            draw_text_shadow(xoffset + xsize / 2, yoffset + ysize / 2 - 8, capString, 1, 1, 0, yFore, yBack, min(blueHold / 30, 1));
        }
        if (redHold > 0) {
            // the enemy has our flag!
            draw_text_shadow(xoffset + xsize / 2, yoffset + ysize / 2 + 8, "Your flag is stolen!!", 1, 1, 0, rFore, rBack, (redHold mod 15) / 15);
        }
    } else if (global.myself.team == TEAM_BLUE) {
        if (redHold > 0) {
            // we have the enemy's flag!
            draw_text_shadow(xoffset + xsize / 2, yoffset + ysize / 2 - 8, capString, 1, 1, 0, yFore, yBack, min(redHold / 30, 1));
        }
        if (blueHold > 0) {
            // the enemy has our flag!
            draw_text_shadow(xoffset + xsize / 2, yoffset + ysize / 2 + 8, "Your flag is stolen!!", 1, 1, 0, rFore, rBack, (blueHold mod 15) / 15);
        }
    }
}
