{    
    var xr, yr, xoffset, yoffset, xsize, ysize;
    
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    
    if distance_to_point(xoffset + xsize / 2, yoffset + ysize / 2) > 800 exit;
    
    xr = round(x);
    yr = round(y);
        
    // use the shield overlay if shields took damage recently
    if (shieldFlash > -1) overSprite = ArmorWalkShieldsS;
    
    // draw accessories first
    switch (accessoryType) {
        case 1:
            // Hayabusa Sword
            draw_sprite_ext(AccHayabusaS, 0, xr, yr + bobAmt, image_xscale, image_yscale, image_angle, c_white, cloakAlpha);
            break;
            
        case 2:
            // Security Com
            draw_sprite_ext(AccSecurityComS, 0, xr, yr + bobAmt, image_xscale, image_yscale, image_angle, c_white, cloakAlpha);
            break;
    }
    
    // draw grenade-tossing arms next, if applicable
    if (grenadeTossFrame != -1) {
        var frame, armAngle;

        // calculate the initial frame
        frame = floor((11 - grenadeTossFrame) * (sprite_get_number(GrenadeArmColorS) / 96));
        
        // calculate the angle of the arm, except for the first two frames
        if (frame >= 2) {
            // copied from helmet angle stuff
            armAngle = aimDirection;
            if ((aimDirection + 270) mod 360 > 180) {
                if ((armAngle > 180) && ((armAngle - 360) < global.grenadeArmMinAngle)) armAngle = global.grenadeArmMinAngle;
                if ((armAngle < 180) && (armAngle > global.grenadeArmMaxAngle)) armAngle = global.grenadeArmMaxAngle;
            } else {
                if (armAngle < (180 - global.grenadeArmMaxAngle)) armAngle = 180 - global.grenadeArmMaxAngle;
                if (armAngle > (180 - global.grenadeArmMinAngle)) armAngle = 180 - global.grenadeArmMinAngle;
                armAngle += 180;
            }
        } else {
            armAngle = image_angle;
        }
        
        // recalculate the frame w/ the proper shoulder type
        frame += shoulderType * sprite_get_number(GrenadeArmColorS) / 8;
        
        draw_sprite_ext(GrenadeArmColorS, frame, xr + 4 * image_xscale, yr + bobAmt, image_xscale, image_yscale, armAngle, global.customColor[bodyColor], cloakAlpha);
        draw_sprite_ext(GrenadeArmOutlineS, frame, xr + 4 * image_xscale, yr + bobAmt, image_xscale, image_yscale, armAngle, c_white, cloakAlpha);
    }
    
    // draw the body sprites
    draw_sprite_ext(colorSprite, floor(animationBase + animationImage), xr, yr, image_xscale, image_yscale, image_angle, global.customColor[bodyColor], cloakAlpha);
    draw_sprite_ext(overSprite, floor(animationBase + animationImage), xr, yr, image_xscale, image_yscale, image_angle, c_white, cloakAlpha);
    
    // NOTE: shield effects are drawn by the Weapon object, as it's the last part of a character drawn
}
