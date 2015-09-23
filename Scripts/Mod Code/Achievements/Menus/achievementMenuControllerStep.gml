{
    // reset mouse-overs
    overBack = false;
    overSettings = false;
    overCheevo = -1;
    
    // handle click events, only if the Options menu is not open
    if (instance_exists(AchievementOptionsController) == false) {
        if ((mouse_y >= 47) && (mouse_y <= 75) && (mouse_x >= 91) && (mouse_x <= 137)) overBack = true;
        if ((mouse_y >= 47) && (mouse_y <= 75) && (mouse_x >= 627) && (mouse_x <= 719)) overSettings = true;
        
        // other regions (i.e. scrolling or achievements themselves)
        if ((mouse_y >= 95) && (mouse_y <= 395) && (mouse_x >= 67) && (mouse_x <= 757)) {
            // achievement region
            // TODO: This could be slightly off, and my need some tweaking to get the horizontal portion correct >_>
            overCheevo = floor((mouse_x - 67) / 69) + floor((mouse_y - 95) / 75) * 10;
        }
        
        // handle clicking events
        if (mouse_check_button_pressed(mb_left)) {
            mouse_clear(mb_left);
            // back button
            if (overBack) {
                room_goto_fix(Menu);
                exit;
            }
            // settings button
            if (overSettings) {
                instance_create(0, 0, AchievementOptionsController);
                exit;
            }
            // cheevo cells
            if (overCheevo != -1) && (overCheevo + firstRow * 10 < global.achieveCount) {
                selectedCheevo = firstRow * 10 + overCheevo;
            }
        }
    }
}
