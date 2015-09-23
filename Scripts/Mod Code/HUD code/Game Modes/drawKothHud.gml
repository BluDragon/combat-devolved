// draw the HUD for KOTH mode
{
    var xoffset, yoffset, xsize, ysize;
    var xr, yr, teamBar, perBar, timeString, myTeamPrefix;
    var tColor, sColor;
    
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
    
    // because there is only one point to worry about we only draw one bar
    // and that bar is only drawn when the point is contested
    // if the point is unowned, show the team's bar filling
    // if the point is owned, show the owner's bar emptying
    if ((KothControlPoint.team == -1) && (KothControlPoint.cappingTeam != -1)) {
        // the point is unowned and someone is capping
        teamBar = KothControlPoint.cappingTeam;
        perBar = KothControlPoint.capping / KothControlPoint.capTime;
        xr = xoffset + xsize / 2 - 94;
        yr = yoffset + ysize - 35;
        drawCapBar(xr, yr, teamBar, perBar);
    } else if ((KothControlPoint.team != -1) && (KothControlPoint.capping > 0)) {
        // show the bar as being the player's team
        teamBar = global.myself.team mod 2;
        if (KothControlPoint.team == teamBar) {
            perBar = (KothControlPoint.capTime - KothControlPoint.capping) / KothControlPoint.capTime;
        } else {
            perBar = KothControlPoint.capping / KothControlPoint.capTime;
        }
        xr = xoffset + xsize / 2 - 94;
        yr = yoffset + ysize - 35;
        drawCapBar(xr, yr, teamBar, perBar);    
    }
    
    //if (instance_exists(WinBanner)) exit;
    
    // only draw the arrow if the point is unlocked
    if (KothControlPoint.locked == false) {
        // the color of the CP is the owner's team, unless its unowned (then its the player color)
        teamBar = KothControlPoint.team
        if (KothControlPoint.team == -1) teamBar = global.myself.team;
        //drawFlagPointer(KothControlPoint.x, KothControlPoint.y, teamBar, 0, 0, HaloKothIconsS, KothControlPoint.team + 1, -1);
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
    // in the case of a tie, draw the larger shine
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
    drawTeamBar(xr, yr, teamBar, perBar, 0);
    draw_text_shadow(xr - 8, yr + 8, timeString, 1.7, 1.7, 0, tColor, sColor, 1);
}
