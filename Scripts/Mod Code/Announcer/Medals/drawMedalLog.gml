// Draws the medal log
{
    var xoffset, yoffset, xsize, ysize;
    var tColor, sColor;
    var i, map, mSprite, age, text;
    var rot, scale, alpha;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    // define text and shadow colors
    tColor = make_color_rgb(148, 191, 242);
    sColor = make_color_rgb(73, 146, 233);
    
    // draw the medal list
    for (i = 0; i < ds_list_size(medals); i += 1) {
        map = ds_list_find_value(medals, ds_list_size(medals) - i - 1);
        mSprite = ds_map_find_value(map, "sprite");
        age = ds_map_find_value(map, "age");
        
        // if age < 15, rotate and scale it in
        rot = 0;
        alpha = 1;
        scale = 1;
        if (age < 15) {
            rot = age * 24;
            //alpha = age / 15;
            scale = age / 15;
        }
        if ((age > 20) && (age < 26)) {
            scale = 1 + ((3 - abs(23 - age)) / 10);
        }
        if (age > 120) {
            alpha = 1 - ((age - 120) / 30);
        }
        
        draw_sprite_ext(mSprite, 0, xoffset + 23 + i * 34, yoffset + ysize - 150, scale, scale, rot, c_white, alpha);
        
        // draw the newest medal's text
        if (i == 0) {
            text = ds_map_find_value(map, "text");
            draw_text_shadow(xoffset + 8, yoffset + ysize - 126, text, 1, 1, 0, tColor, sColor, alpha);
        }        
    }
}
