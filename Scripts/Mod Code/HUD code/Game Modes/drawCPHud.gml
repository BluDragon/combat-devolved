// Draw the HUD for CP mode
{
    var xoffset, yoffset, xsize, ysize;
    var xr, yr, teamBar, perBar, capString, myTeamPrefix;
    var tColor, sColor;
    var redCaps, blueCaps, i, iStart, iStep, iEnd;
    var target;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    draw_set_alpha(1);
    draw_set_halign(fa_right);
    draw_set_valign(fa_middle);
    
    // define text and shadow colors
    tColor = make_color_rgb(148, 191, 242);
    sColor = make_color_rgb(73, 146, 233);
    
    myTeamPrefix = ">";
    
    if (global.myself == -1) exit;
    // abort draw if the user is zoomed in -- the HUD isn't drawn if we're scoped
    if (global.myself.object != -1) {
        if (global.myself.object.zoomed) exit;
    }
    
    // draw any control points that are being contested
    // iterate through the points in an order determined by the player's
    // team, and draw ascending from the bottom center
    // orders: RED: --, BLUE: ++, SPEC: --
    if ((global.myself.team == TEAM_RED) || (global.myself.team == TEAM_SPECTATOR)) {
        iStart = global.totalControlPoints;
        iStep = -1;
        iEnd = 0;
    } else if (global.myself.team == TEAM_BLUE) {
        iStart = 1;
        iStep = 1;
        iEnd = global.totalControlPoints + 1;
    }
    // iterate
    xr = xoffset + xsize / 2 - 94;
    yr = yoffset + ysize - 35;  // -21 per bar
    for (i = iStart; i != iEnd; i += iStep) {
        // if the point is unowned, show the team's bar filling
        // if the point is owned, show the owner's bar emptying
        
        if ((global.cp[i].team == -1) && (global.cp[i].cappingTeam != -1)) {
            // the point is unowned and someone is capping
            teamBar = global.cp[i].cappingTeam;
            perBar = global.cp[i].capping / global.cp[i].capTime;
            drawCapBar(xr, yr, teamBar, perBar);
            yr -= 21;
        } else if ((global.cp[i].team != -1) && (global.cp[i].capping > 0)) {
            // show the bar as the player's team
            teamBar = global.myself.team mod 2;
            if (global.cp[i].team == teamBar) {
                perBar = (global.cp[i].capTime - global.cp[i].capping) / global.cp[i].capTime;
            } else {
                perBar = global.cp[i].capping / global.cp[i].capTime;
            }
            drawCapBar(xr, yr, teamBar, perBar);
            yr -= 21;
        }
    }
    
    // count up all the owned points each side has
    redCaps = 0;
    blueCaps = 0;
    for (i = 1; i <= global.totalControlPoints; i += 1) {
        if (global.cp[i].team == TEAM_RED) {
            redCaps += 1;
        } else if (global.cp[i].team == TEAM_BLUE) {
            blueCaps += 1;
        }
    }
    
    /* --- NEW CP POINTER CODE --- */
    // draw arrows pointing to all the unlocked points
    for (i = 1; i <= global.totalControlPoints; i += 1) {
        if (global.cp[i].locked == false) {
            // draw an arrow pointing to it
            teamBar = global.cp[i].team
            if (global.cp[i].team == -1) teamBar = global.myself.team;
            if (global.myself.team == TEAM_BLUE) {
                perBar = global.totalControlPoints - i + 1;
            } else {
                perBar = i;
            }
            //drawFlagPointer(global.cp[i].x, global.cp[i].y, teamBar, 0, 0, -1, perBar, global.cp[i].team);
        }
    }
    
    // reset the text alignment after drawing the pointers
    draw_set_halign(fa_right);
    draw_set_valign(fa_middle);
    
    // draw the timer and team point bars    
    // draw the bottom (losing team) bar, default to PLAYER'S ENEMY if there's a tie
    if (redCaps > blueCaps) {
        teamBar = TEAM_BLUE;
        perBar = blueCaps / global.totalControlPoints;
        capString = string(blueCaps);
        if (global.myself.team == TEAM_BLUE) capString = myTeamPrefix + capString;
    } else if (redCaps < blueCaps) {
        teamBar = TEAM_RED;
        perBar = redCaps / global.totalControlPoints;
        capString = string(redCaps);
        if (global.myself.team == TEAM_RED) capString = myTeamPrefix + capString;
    } else {
        // a tie
        teamBar = (global.myself.team mod 2) xor 1;
        if (teamBar == TEAM_RED) {
            perBar = redCaps / global.totalControlPoints;
            capString = string(redCaps);
        }
        if (teamBar == TEAM_BLUE) {
            perBar = blueCaps / global.totalControlPoints;
            capString = string(blueCaps);
        }
    }
    // draw the empty bar and then the portion of the full bar
    xr = xoffset + xsize - 120;
    yr = yoffset + ysize - 36;
    // in the case of a tie, draw the large shine
    if (redCaps == blueCaps) {
        drawTeamBar(xr, yr, teamBar, perBar, 0);
    } else {
        drawTeamBar(xr, yr, teamBar, perBar, 1);
    }
    draw_text_shadow(xr - 8, yr + 8, capString, 1.7, 1.7, 0, tColor, sColor, 1);
    
    // draw the top (winning team) bar, default to PLAYER if there's a tie   
    if (redCaps > blueCaps) {
        teamBar = TEAM_RED;
        perBar = redCaps / global.totalControlPoints;
        capString = string(redCaps);
        if (global.myself.team == TEAM_RED) capString = myTeamPrefix + capString;
    } else if (redCaps < blueCaps) {
        teamBar = TEAM_BLUE;
        perBar = blueCaps / global.totalControlPoints;
        capString = string(blueCaps);
        if (global.myself.team == TEAM_BLUE) capString = myTeamPrefix + capString;
    } else {
        // a tie
        teamBar = (global.myself.team mod 2);
        if (teamBar == TEAM_RED) {
            perBar = redCaps / global.totalControlPoints;
            capString = string(redCaps);
        }
        if (teamBar == TEAM_BLUE) {
            perBar = blueCaps / global.totalControlPoints;
            capString = string(blueCaps);
        }
        if (global.myself.team != TEAM_SPECTATOR) capString = myTeamPrefix + capString;
    }
    // draw the empty bar and then the portion of the full bar
    xr = xoffset + xsize - 120;
    yr = yoffset + ysize - 58;
    drawTeamBar(xr, yr, teamBar, perBar, 0);
    draw_text_shadow(xr - 8, yr + 8, capString, 1.7, 1.7, 0, tColor, sColor, 1);

    if (instance_exists(WinBanner)) exit;
    
    // draw the timer
    xr = xoffset + xsize - 20;
    yr = yoffset + ysize - 72;
    if (overtime == 1) {
        draw_text_shadow(xr, yr, "OVERTIME", 1.7, 1.7, 0, tColor, sColor, 1);
    } else {
        if ((mode == 1) && (global.setupTimer)) > 0 {
            // in setup mode
            capString = string_time(global.setupTimer);
            draw_text_shadow(xr, yr, capString, 1.7, 1.7, 0, tColor, sColor, 1);
        } else {
            // not in setup mode
            capString = string_time(timer);
            draw_text_shadow(xr, yr, capString, 1.7, 1.7, 0, tColor, sColor, 1);
        }
    }
}
