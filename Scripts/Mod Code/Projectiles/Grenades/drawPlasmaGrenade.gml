// Draw the Plasma Grenade

{
    var xr, yr, coronaColor, ratio;
    
    xr = round(x);
    yr = round(y);
    
    // if armed, the corona lightens towards white
    if (armed) {
        ratio = 1 - (alarm[0] / fuseLength);
        coronaColor = make_color_rgb(ratio * 255, 212 + ratio * 43, 212 + ratio * 43);
    } else {
        coronaColor = make_color_rgb(0, 212, 212);
    }
    
    // draw the corona
    draw_sprite_ext(SmokeBallS, effectFrame, xr, yr, 1, 1, direction + 135, coronaColor, 1);
    // draw the grenade
    draw_sprite_ext(sprite_index, image_index, xr, yr, 1, 1, image_angle, c_white, 1);
    
    // if the grenade is armed, fade towards white
    if (armed) {
        var alpha;
        alpha = 1 - (alarm[0] / fuseLength);
        
        draw_set_alpha(alpha);
        draw_circle_color(xr - 0.5, yr - 0.5, 4, c_white, c_white, false);
        draw_set_alpha(1);
        draw_sprite_ext(PlasmaGArmingSparksS, effectFrame, xr, yr, 1.5, 1.5, 0, c_white, alpha);
    }
}
