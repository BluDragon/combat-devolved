// Draw the surfaces for the chat window with full alpha
{
    var entryWidth, xPos, yPos, bColor, i, playerID, text, msgScope;
    var msgHeight, name;
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    bColor = make_color_rgb(148, 191, 242);
    
    // chat entry first
    surface_set_target(entrySurface);
    // clear the chat entry surface
    draw_clear_alpha(c_black, 0);
    // set the font
    draw_set_font(fnt_chat);
    // if typings
    if (global.chatControl && (global.myself != -1)) {
        // Typing color is white
        color = c_white;
        
        entryWidth = string_width(keyboard_string);
        xPos = min(0, chatWidth - 2 - entryWidth);
        draw_text_color(xPos, 6, keyboard_string, color, color, color, color, 1);
    }
    // reset stuff
    surface_reset_target();
    draw_set_font(fnt_gg2);
    
    // chat log
    surface_set_target(logSurface);
    // clear the chat log surface
    draw_clear_alpha(c_black, 0);
    // set the font
    draw_set_font(fnt_chat);
    draw_set_valign(fa_top);
    
    yPos = 0;
    for (i = 0; i < ds_list_size(global.chatLog); i += 1) {
        text = ds_list_find_value(global.chatLog, i);
        playerID = ds_list_find_value(global.chatPlayers, i);
        msgScope = ds_list_find_value(global.chatScope, i);
        name = ds_list_find_value(global.chatNames, i);
        
        // TODO: Set the color based on the team and game mode
        // For now use the Free-for-all color rules
        
        if (playerID == -1) {
            // the color is white if the player's gone
            color = c_white;
        } else {
            // the name is colored with the player's armor color
            color = global.customColor[ds_list_find_value(global.players, playerID).bodyColor];
        }
        
        // draw the name and colon
        draw_text_ext_color(0, yPos, name + ":", -1, chatWidth, color, color, color, color, 1);
        
        // then in plain white, we draw the rest of the message, positioned after the name
        // since we're using a fixed-width font, we can just set the name to be all spaces
        color = c_white;
        
        fullMsg = string_repeat(" ", string_length(name) + 2) + text;
        
        msgHeight = string_height_ext(fullMsg, -1, chatWidth);
        draw_text_ext_color(0, yPos, fullMsg, -1, chatWidth, color, color, color, color, 1);
        yPos += msgHeight + 2;
    }
    
    // reset stuff
    surface_reset_target();
    draw_set_font(fnt_gg2);
}
