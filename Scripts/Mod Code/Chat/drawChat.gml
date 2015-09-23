// Draws the chat box
{
    var xoffset, yoffset, xsize, ysize;
    var color, cursorPos;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    draw_set_alpha(1);
    bColor = make_color_rgb(148, 191, 242);
    
    draw_sprite_ext(ChatWindowS, 0, xoffset + x, yoffset + ysize / 2, 1, 1, 0, c_white, alpha);
    
    // if the player is typing
    if (global.chatControl && (global.myself != -1)) {
        // TODO: Set the color based on the team and game mode
        // For now, just set the color to solid white (free for all mode)
        color = c_white;
        
        // draw the chat surface
        draw_surface_ext(entrySurface, xoffset + x + 19, yoffset + ysize / 2 - 78 - 6, 1, 1, 0, c_white, alpha);
        // draw the cursor
        draw_set_font(fnt_chat);
        cursorPos = min(string_width(keyboard_string), chatWidth - 3) + 1;
        draw_set_font(fnt_gg2);
        
        if (cursor > 15) {
            draw_rectangle_color(xoffset + x + 19 + cursorPos, yoffset + ysize / 2 - 78 - 6, xoffset + x + 19 + cursorPos + 1, yoffset + ysize / 2 - 78 + 6, color, color, color, color, false);
        }
    }
    
    // draw the log surface
    draw_surface_ext(logSurface, xoffset + x + 19, yoffset + ysize / 2 - 61, 1, 1, 0, c_white, alpha);
}
