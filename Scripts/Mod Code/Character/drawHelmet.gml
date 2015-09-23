{
    var xviewoffset, yviewoffset, xviewsize, yviewsize;
    var overSprite;
    
    xviewoffset = view_xview[0];
    yviewoffset = view_yview[0];
    xviewsize = view_wview[0];
    yviewsize = view_hview[0];
    
    // exit if the helmet is out of view
    if distance_to_point(xviewoffset + xviewsize / 2, yviewoffset + yviewsize / 2) > 800 exit;

    var xr, yr, headXScale, headAngle;
    xr = round(x);
    yr = round(y);
    
    draw_set_alpha(1);
    overSprite = HelmetsOutline;
    
    // use the shield overlay if shields took damage recently
    if (owner.shieldFlash > -1) overSprite = HelmetsShields;
        
    // draw the frames (colored, then outline)
    draw_sprite_ext(HelmetsColor, helmetFrame, xr, yr, image_xscale, 1, image_angle, global.customColor[armorColor], owner.cloakAlpha);
    draw_sprite_ext(overSprite, helmetFrame, xr, yr, image_xscale, 1, image_angle, c_white, owner.cloakAlpha);
}
