{
    var xoffset, yoffset, xsize, ysize;
    var xr, yr, teamBar, perBar, timeString, myTeamPrefix;
    var tColor, sColor;
    var i, iStart, iStep, iEnd;
    
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
    
    // draw arrows to the points and use the color of their owners
    // but only draw if they're unlocked
    for (i = 1; i <= 2; i += 1) {
        if (global.cp[i].locked == false) {
           //drawFlagPointer(global.cp[i].x, global.cp[i].y, global.cp[i].team, 0, 0, HaloKothIconsS, global.cp[i].team + 1, -1);
        }
    }
    
    // reset text alignment after drawing pointers
    draw_set_halign(fa_right);
    draw_set_valign(fa_middle);
    
    // draw the timer and team timer bars
    
    // draw the bottom (losing team) bar, default to ENEMY if there's a tie
    if (redTimer < blueTimer) {
        teamBar = TEAM_BLUE;
        perBar = (5400 - blueTimer) / 5400;
        timeString = string_time(blueTimer);
        if (global.myself.team == TEAM_BLUE) timeString = myTeamPrefix + timeString;
    } else if (redTimer > blueTimer) {
        teamBar = TEAM_RED;
        perBar = (5400 - redTimer) / 5400;
        timeString = string_time(redTimer);
        if (global.myself.team == TEAM_RED) timeString = myTeamPrefix + timeString;
    } else {
        // a tie
        teamBar = (global.myself.team mod 2) xor 1;
        if (teamBar == TEAM_RED) {
            perBar = (5400 - redTimer) / 5400;
            timeString = string_time(redTimer);
        }
        if (teamBar == TEAM_BLUE) {
            perBar = (5400 - blueTimer) / 5400;
            timeString = string_time(blueTimer);
        }
    }
    // draw the empty bar and then the portion of the full bar
    xr = xoffset + xsize - 120;
    yr = yoffset + ysize - 36;
    // account for OVERTIME in DKoth
    if (perBar > 1) {
        perBar = 1;
        timeString = "OVERTIME";
    }
    // in the case of a tie, draw the large shine
    if (redTimer == blueTimer) {
        drawTeamBar(xr, yr, teamBar, perBar, 0);
    } else {
        drawTeamBar(xr, yr, teamBar, perBar, 1);
    }
    draw_text_shadow(xr - 8, yr + 8, timeString, 1.7, 1.7, 0, tColor, sColor, 1);
    
    // draw the top (winning team) bar, default to PLAYER if there's a tie   
    if (redTimer < blueTimer) {
        teamBar = TEAM_RED;
        perBar = (5400 - redTimer) / 5400;
        timeString = string_time(redTimer);
        if (global.myself.team == TEAM_RED) timeString = myTeamPrefix + timeString;
    } else if (redTimer > blueTimer) {
        teamBar = TEAM_BLUE;
        perBar = (5400 - blueTimer) / 5400;
        timeString = string_time(blueTimer);
        if (global.myself.team == TEAM_BLUE) timeString = myTeamPrefix + timeString;
    } else {
        // a tie
        teamBar = (global.myself.team mod 2);
        if (teamBar == TEAM_RED) {
            perBar = (5400 - redTimer) / 5400;
            timeString = string_time(redTimer);
        }
        if (teamBar == TEAM_BLUE) {
            perBar = (5400 - blueTimer) / 5400;
            timeString = string_time(blueTimer);
        }
        if (global.myself.team != TEAM_SPECTATOR) timeString = myTeamPrefix + timeString;
    }
    // draw the empty bar and then the portion of the full bar
    xr = xoffset + xsize - 120;
    yr = yoffset + ysize - 58;
    // account for OVERTIME in DKoth
    if (perBar > 1) {
        perBar = 1;
        timeString = "OVERTIME";
    }
    drawTeamBar(xr, yr, teamBar, perBar, 0);
    draw_text_shadow(xr - 8, yr + 8, timeString, 1.7, 1.7, 0, tColor, sColor, 1);
}
