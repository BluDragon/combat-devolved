/* Draws the team bars for the various HUD modifications
** Centralized here so any change I make here will update all the HUD modes
**
** argument0 = x position
** argument1 = y position
** argument2 = team offset
** argument3 = fill percentage
** argument4 = shine image to use (0 = large, 1 = small)
*/

{
    var shineScale;
    
    // draw the BG and bar FG
    draw_sprite_ext(HaloTeamBarsEmptyS, argument2, argument0, argument1, 1, 1, 0, c_white, 1);
    draw_sprite_part_ext(HaloTeamBarsFullS, argument2, 0, 0, 100 * argument3, 16, argument0, argument1, 1, 1, c_white, 1);
    
    // draw the shine effect, but only if the bar is not 100% filled
    if (argument3 < 1) {
        // scale the shine effect down horizontally if it would extend out past the bar
        shineScale = 1;
        if (argument3 < 0.09) {
            shineScale = (argument3 * 100 / 9);
        }
        draw_sprite_ext(HaloTeamBarsShineS, argument4, argument0 + argument3 * 100, argument1, shineScale, 1, 0, c_white, 1);
    }
}
