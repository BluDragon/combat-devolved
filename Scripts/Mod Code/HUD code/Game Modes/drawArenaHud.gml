// Draw the Arena HUD
{
    var xoffset, yoffset, xsize, ysize;
    var teamBar, perBar, timeString, myTeamPrefix, redMax, blueMax;
    var tColor, sColor;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    if instance_exists(WinBanner) with WinBanner instance_destroy();
    
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
    if ((ArenaControlPoint.team == -1) && (ArenaControlPoint.cappingTeam != -1) && (ArenaControlPoint.capping > 0)) {
        // the point is unowned and someone is capping
        teamBar = ArenaControlPoint.cappingTeam;
        perBar = ArenaControlPoint.capping / ArenaControlPoint.capTime;
        xr = xoffset + xsize / 2 - 94;
        yr = yoffset + ysize - 35;
        drawCapBar(xr, yr, teamBar, perBar);
    } else if ((ArenaControlPoint.team != -1) && (ArenaControlPoint.capping > 0)) {
        // show the bar as being the player's team
        teamBar = global.myself.team mod 2;
        if (ArenaControlPoint.team == teamBar) {
            perBar = (ArenaControlPoint.capTime - ArenaControlPoint.capping) / KothControlPoint.capTime;
        } else {
            perBar = ArenaControlPoint.capping / ArenaControlPoint.capTime;
        }
        xr = xoffset + xsize / 2 - 94;
        yr = yoffset + ysize - 35;
        drawCapBar(xr, yr, teamBar, perBar);    
    }
    
    // only draw the arrow if the point is unlocked
    if (ArenaControlPoint.locked == false) {
        //drawFlagPointer(ArenaControlPoint.x, ArenaControlPoint.y, global.myself.team, 0, 0, HaloKothIconsS, ArenaControlPoint.team + 1, -1);
    }

    // assume there is at least 1 person on each team (to avoid /0 errors)
    maxRed = max(1, redteam);
    maxBlue = max(1, blueteam);
    
    // draw the bottom (losing team) bar, default to ENEMY if there's a tie
    if (redteamCharacters > blueteamCharacters) {
        teamBar = TEAM_BLUE;
        perBar = blueteamCharacters / maxBlue;
        timeString = string(blueteamCharacters);
        if (global.myself.team == TEAM_BLUE) timeString = myTeamPrefix + timeString;
    } else if (redteamCharacters < blueteamCharacters) {
        teamBar = TEAM_RED;
        perBar = redteamCharacters / maxRed;
        timeString = string(redteamCharacters);
        if (global.myself.team == TEAM_RED) timeString = myTeamPrefix + timeString;
    } else {
        // a tie
        teamBar = (global.myself.team mod 2) xor 1;
        if (teamBar == TEAM_RED) {
            perBar = redteamCharacters / maxRed;
            timeString = string(redteamCharacters);
        }
        if (teamBar == TEAM_BLUE) {
            perBar = blueteamCharacters / maxBlue;
            timeString = string(blueteamCharacters);
        }
    }
    // draw the empty bar and then the portion of the full bar
    xr = xoffset + xsize - 120;
    yr = yoffset + ysize - 36;
    // in the case of a tie, draw the large shine
    if (redteamCharacters == blueteamCharacters) {
        drawTeamBar(xr, yr, teamBar, perBar, 0);
    } else {
        drawTeamBar(xr, yr, teamBar, perBar, 1);
    }
    draw_text_shadow(xr - 8, yr + 8, timeString, 1.7, 1.7, 0, tColor, sColor, 1);
    
    // draw the top (winning team) bar, default to PLAYER if there's a tie   
    if (redteamCharacters > blueteamCharacters) {
        teamBar = TEAM_RED;
        perBar = redteamCharacters / maxRed;
        timeString = string(redteamCharacters);
        if (global.myself.team == TEAM_RED) timeString = myTeamPrefix + timeString;
    } else if (redteamCharacters < blueteamCharacters) {
        teamBar = TEAM_BLUE;
        perBar = blueteamCharacters / maxBlue;
        timeString = string(blueteamCharacters);
        if (global.myself.team == TEAM_BLUE) timeString = myTeamPrefix + timeString;
    } else {
        // a tie
        teamBar = (global.myself.team mod 2);
        if (teamBar == TEAM_RED) {
            perBar = redteamCharacters / maxRed;
            timeString = string(redteamCharacters);
        }
        if (teamBar == TEAM_BLUE) {
            perBar = blueteamCharacters / maxBlue;
            timeString = string(blueteamCharacters);
        }
        if (global.myself.team != TEAM_SPECTATOR) timeString = myTeamPrefix + timeString;
    }
    // draw the empty bar and then the portion of the full bar
    xr = xoffset + xsize - 120;
    yr = yoffset + ysize - 58;
    drawTeamBar(xr, yr, teamBar, perBar, 0);
    draw_text_shadow(xr - 8, yr + 8, timeString, 1.7, 1.7, 0, tColor, sColor, 1);

    // draw the prompt thing if the round has not yet started
    if (roundStart > 0) {
        draw_set_halign(fa_center);
        draw_text(xoffset + xsize / 2, yoffset + ysize / 2,"Game will start in " + string(floor(roundStart / 30)) + " seconds");
        draw_set_halign(fa_right);
    }
    // inform the player they can spawn next round
    if (global.myself.object == -1) && (roundStart == 0) && (winners == TEAM_SPECTATOR) && (global.winners == -1) && (endCount == 0) && (!instance_exists(DeathCam)) && (global.myself.team != TEAM_SPECTATOR) {
        draw_set_halign(fa_center);
        draw_text(xoffset + xsize / 2, yoffset + ysize / 2, "You can spawn when the next round starts");
        draw_set_halign(fa_right);
    }
    
    // draw the timer
    xr = xoffset + xsize - 20;
    yr = yoffset + ysize - 72;
    if (overtime == 1) {
        draw_text_shadow(xr, yr, "OVERTIME", 1.7, 1.7, 0, tColor, sColor, 1);
    } else {
        timeString = string_time(timer);
        draw_text_shadow(xr, yr, timeString, 1.7, 1.7, 0, tColor, sColor, 1);
    }
    
    // draw the MVP stuff if end-of-round
    if ((endCount > 0) && (global.winners == -1) && (!instance_exists(ScoreTableController))) {
        if instance_exists(DeathCam) {
            with DeathCam instance_destroy();
        }
    
        draw_set_alpha(1);    
        draw_set_halign(fa_left);
        draw_set_color(c_white);

        offset = 20;
        if winners == TEAM_RED {
            if endCount < 150 {
                draw_sprite_ext(MVPBannerS,0,xoffset+xsize/2,yoffset+ysize/2,1,1,0,c_white,0.8);
                for (i=0; i<redMVPs; i+=1) {
                    draw_text(xoffset+xsize/2-250,yoffset+ysize/2+71+offset*i,redMVPName[i]);
                    draw_text(xoffset+xsize/2-28,yoffset+ysize/2+71+offset*i,redMVPKills[i]);
                    draw_text(xoffset+xsize/2+96,yoffset+ysize/2+71+offset*i,redMVPHealed[i]);
                    draw_text(xoffset+xsize/2+215,yoffset+ysize/2+71+offset*i,redMVPPoints[i]);
                }
            }
            else if endCount >= 150 {
                draw_sprite_ext(MVPBannerS,1,xoffset+xsize/2,yoffset+ysize/2,1,1,0,c_white,0.8);
                for (i=0; i<blueMVPs; i+=1) {
                    draw_text(xoffset+xsize/2-250,yoffset+ysize/2+71+offset*i,blueMVPName[i]);
                    draw_text(xoffset+xsize/2-28,yoffset+ysize/2+71+offset*i,blueMVPKills[i]);
                    draw_text(xoffset+xsize/2+96,yoffset+ysize/2+71+offset*i,blueMVPHealed[i]);
                    draw_text(xoffset+xsize/2+215,yoffset+ysize/2+71+offset*i,blueMVPPoints[i]);
                }
            }
        }
        else if winners == TEAM_BLUE {
            if endCount < 150 {
                draw_sprite_ext(MVPBannerS,2,xoffset+xsize/2,yoffset+ysize/2,1,1,0,c_white,0.8);
                for (i=0; i<blueMVPs; i+=1) {
                    draw_text(xoffset+xsize/2-250,yoffset+ysize/2+71+offset*i,blueMVPName[i]);
                    draw_text(xoffset+xsize/2-28,yoffset+ysize/2+71+offset*i,blueMVPKills[i]);
                    draw_text(xoffset+xsize/2+96,yoffset+ysize/2+71+offset*i,blueMVPHealed[i]);
                    draw_text(xoffset+xsize/2+215,yoffset+ysize/2+71+offset*i,blueMVPPoints[i]);
                }
            }
            else if endCount >= 150 {
                draw_sprite_ext(MVPBannerS,3,xoffset+xsize/2,yoffset+ysize/2,1,1,0,c_white,0.8);
                for (i=0; i<redMVPs; i+=1) {
                    draw_text(xoffset+xsize/2-250,yoffset+ysize/2+71+offset*i,redMVPName[i]);
                    draw_text(xoffset+xsize/2-28,yoffset+ysize/2+71+offset*i,redMVPKills[i]);
                    draw_text(xoffset+xsize/2+96,yoffset+ysize/2+71+offset*i,redMVPHealed[i]);
                    draw_text(xoffset+xsize/2+215,yoffset+ysize/2+71+offset*i,redMVPPoints[i]);
                }
            }
        }
        draw_set_color(make_color_rgb(227,226,225));
        draw_set_halign(fa_right);
        draw_text_transformed(xoffset+384,yoffset+315,redWins,3.5,3.5,0);
        draw_set_halign(fa_left);
        draw_text_transformed(xoffset+415,yoffset+315,blueWins,3.5,3.5,0);
    }
}
