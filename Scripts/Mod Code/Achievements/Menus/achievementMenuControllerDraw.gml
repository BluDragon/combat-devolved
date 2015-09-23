{
    var color, i, rx, ry, alpha, cheevoText;
    
    // Draw the Achievement Browser BG
    draw_sprite_ext(AchievementMenuS, 0, 0, 0, 1, 1, 0, c_white, 1);
    draw_set_halign(fa_middle);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_cheevo);
    
    // draw the Back and Settings labels
    color = tColor;
    // if the Back button is hovered-on, and the options menu is not open, change the color
    if (overBack) color = c_white;
    draw_text_shadow(115, 58, "Back", 1, 1, 0, color, sColor, 1);
    color = tColor;
    // now for Settings
    if (overSettings) color = c_white;
    draw_text_shadow(668, 58, "Settings", 1, 1, 0, color, sColor, 1);
    
    // draw the achievement icons
    for (i = 10 * firstRow; i < min(40, global.achieveCount - 10 * firstRow); i += 1) {
        if (global.achieveStep[i] >= global.achieveEarnSteps[i]) {
            // color it in as earned
            color = c_white;
            alpha = 1;
        } else {
            // faded cheevo
            color = c_black;
            alpha = 0.4;
        }
        
        rx = 99 + ((i - 10 * firstRow) mod 10) * 69;
        ry = 133 + floor((i - 10 * firstRow) / 10) * 75;
        draw_sprite_ext(global.achieveSprite[i], 1, rx, ry, 1, 1, 0, color, alpha);
    }
    
    // if an achievement was selected, display its info
    if (selectedCheevo != -1) {
        if (global.achieveStep[selectedCheevo] >= global.achieveEarnSteps[selectedCheevo]) {
            // color it in as earned
            color = c_white;
            alpha = 1;
        } else {
            // faded cheevo
            color = c_black;
            alpha = 0.4;
        }
        draw_sprite_ext(global.achieveSprite[selectedCheevo], 1, 192, 454, 1, 1, 0, color, alpha);
        
        // display the text
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);

        cheevoText = global.achieveDesc[selectedCheevo];
        // add the status, only if needed progression is more than 1
        if (global.achieveEarnSteps[selectedCheevo] > 1) && (global.achieveStep[selectedCheevo] < global.achieveEarnSteps[selectedCheevo]) {
            cheevoText = cheevoText + chr(13) + chr(13) + "[ Status: " + string(global.achieveStep[selectedCheevo]) + " " +
                global.achieveProgTerm[selectedCheevo] + ". ]";
        }
        
        draw_text_shadow(370, 389, global.achieveName[selectedCheevo], 1, 1, 0, tColor, sColor, 1);
        draw_text_shadow(355, 416, cheevoText, 1, 1, 0, tColor, sColor, 1);
    }
    
    // restore the game font
    draw_set_font(fnt_gg2);
}
