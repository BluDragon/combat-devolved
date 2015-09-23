// FUN: Experiment with the blending color or alpha of the body parts,
// see what would work well for a transition to and from the state of being cloaked
{
    var stealthSuface, bobFrame, bobAmt, maskSurface;
    
    // make the temp and mask surface
    maskSurface = surface_create(64, 64);
    stealthSurface = surface_create(64, 64);
    
    // draw to the temp surface
    surface_set_target(maskSurface);
    
    // clear it to clear
    draw_clear_alpha(c_white, 0);
        
    // draw the body mask
    draw_sprite_ext(ArmorColorCQB, floor(animationImage + animationOffset), 32, 32, image_xscale, 1, 0, c_black, 1);
    // draw the helmet mask
    // bobbing frame for the body/head
    bobFrame = floor(animationImage) mod 10;
    // add 10 if the frame is negative (for whatever the fuck reason this occurs)
    if (bobFrame < 0) bobFrame += 10;
    bobAmt = global.bodyBob[bobFrame];
    draw_sprite_ext(HelmetsColor, 0, 32, 28 + bobAmt, image_xscale, 1, 0, c_black, 1);
    
    // draw to the stealth surface
    surface_set_target(stealthSurface);
    // draw the shifted background
    draw_background_ext(background_index[0], -x + 30, -y + 28, 6, 6, 0, c_white, 1);
    
    // change blending mode
    draw_set_blend_mode_ext(bm_one, bm_src_alpha);
    
    // draw the mask surface
    draw_surface(maskSurface, 0, 0);
    
    // restore the blending mode
    draw_set_blend_mode_ext(bm_src_alpha, bm_inv_src_alpha);
    
    // restore the drawing target
    surface_reset_target()
    
    // make a sprite and do stuff
    if (sprite_exists(stealthSprite)) {
        sprite_delete(stealthSprite);     
    }
    stealthSprite = sprite_create_from_surface(stealthSurface, 0, 0, 64, 64, false, false, 32, 32);
    
    // destroy the surfaces
    surface_free(maskSurface);
    surface_free(stealthSurface);
}
