// draw the HUD for Generator mode
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
    
    // draw the timer and team timer bars
    if (instance_exists(WinBanner)) exit;
    if (global.myself == -1) exit;
    // abort draw if the user is zoomed in -- the HUD isn't drawn if we're scoped
    if (global.myself.object != -1) {
        if (global.myself.object.zoomed) exit;
    }
    
    /*
    // draw the gen pointers
    if (instance_exists(GeneratorBlue)) drawFlagPointer(GeneratorBlue.x, GeneratorBlue.y, TEAM_BLUE, 0, 20, HaloGenIconsS, 1, -1);
    if (instance_exists(GeneratorRed)) drawFlagPointer(GeneratorRed.x, GeneratorRed.y, TEAM_RED, 0, 20, HaloGenIconsS, 0, -1);
    */
    
    if (instance_exists(GeneratorRed) && instance_exists(GeneratorBlue)) {
        // draw the bottom (losing team) bar, default to ENEMY if there's a tie
        if (GeneratorRed.hp > GeneratorBlue.hp) {
            teamBar = TEAM_BLUE;
            perBar = max(0, GeneratorBlue.hp / Generator.maxHp);
            timeString = string(ceil(perBar * 100)) + "%";
            if (global.myself.team == TEAM_BLUE) timeString = myTeamPrefix + timeString;
        } else if (GeneratorRed.hp < GeneratorBlue.hp) {
            teamBar = TEAM_RED;
            perBar = max(0, GeneratorRed.hp / GeneratorRed.maxHp);
            timeString = string(ceil(perBar * 100)) + "%";
            if (global.myself.team == TEAM_RED) timeString = myTeamPrefix + timeString;
        } else {
            // a tie
            teamBar = (global.myself.team mod 2) xor 1;
            if (teamBar == TEAM_RED) {
                perBar = max(0, GeneratorRed.hp / GeneratorRed.maxHp);
                timeString = string(ceil(perBar * 100)) + "%";
            }
            if (teamBar == TEAM_BLUE) {
                perBar = max(0, GeneratorBlue.hp / Generator.maxHp);
                timeString = string(ceil(perBar * 100)) + "%";
            }
        }
        // draw the empty bar and then the portion of the full bar
        xr = xoffset + xsize - 120;
        yr = yoffset + ysize - 36;
        // in the case of a tie, draw the large shine
        if (GeneratorRed.hp == GeneratorBlue.hp) {
            drawTeamBar(xr, yr, teamBar, perBar, 0);
        } else {
            drawTeamBar(xr, yr, teamBar, perBar, 1);
        }
        draw_text_shadow(xr - 8, yr + 8, timeString, 1.7, 1.7, 0, tColor, sColor, 1);
        
        // draw the top (winning team) bar, default to PLAYER if there's a tie   
        if (GeneratorRed.hp > GeneratorBlue.hp) {
            teamBar = TEAM_RED;
            perBar = max(0, GeneratorRed.hp / GeneratorRed.maxHp);
            timeString = string(ceil(perBar * 100)) + "%";
            if (global.myself.team == TEAM_RED) timeString = myTeamPrefix + timeString;
        } else if (GeneratorRed.hp < GeneratorBlue.hp) {
            teamBar = TEAM_BLUE;
            perBar = max(0, GeneratorBlue.hp / Generator.maxHp);
            timeString = string(ceil(perBar * 100)) + "%";
            if (global.myself.team == TEAM_BLUE) timeString = myTeamPrefix + timeString;
        } else {
            // a tie
            teamBar = (global.myself.team mod 2);
            if (teamBar == TEAM_RED) {
                perBar = max(0, GeneratorRed.hp / GeneratorRed.maxHp);
                timeString = string(ceil(perBar * 100)) + "%";
            }
            if (teamBar == TEAM_BLUE) {
                perBar = max(0, GeneratorBlue.hp / Generator.maxHp);
                timeString = string(ceil(perBar * 100)) + "%";
            }
            if (global.myself.team != TEAM_SPECTATOR) timeString = myTeamPrefix + timeString;
        }
        // draw the empty bar and then the portion of the full bar
        xr = xoffset + xsize - 120;
        yr = yoffset + ysize - 58;
        drawTeamBar(xr, yr, teamBar, perBar, 0);
        draw_text_shadow(xr - 8, yr + 8, timeString, 1.7, 1.7, 0, tColor, sColor, 1);
    }
    
    // draw the timer
    xr = xoffset + xsize - 20;
    yr = yoffset + ysize - 72;
    timeString = string_time(timer);
    draw_text_shadow(xr, yr, timeString, 1.7, 1.7, 0, tColor, sColor, 1);
}
