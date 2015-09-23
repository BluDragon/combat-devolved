    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    if distance_to_point(xoffset+xsize/2,yoffset+ysize/2) > 800 exit;

    var xr, yr, bobFrame, bobAmt, color;
    
    xr = round(x);
    yr = round(y);
    
    draw_sprite_ext(stealthSprite, 0, xr, yr, 1, 1, 0, c_white, 1);
