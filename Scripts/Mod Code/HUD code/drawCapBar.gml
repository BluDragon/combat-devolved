/* Draws the cap bars for the various HUD modifications
** Centralized here so any change I make here will update all the HUD modes
**
** argument0 = x position
** argument1 = y position
** argument2 = team offset
** argument3 = fill percentage
*/

{
    var pxL, pxR, pyL, pyR;
    
    draw_sprite_ext(HaloCapBarsEmptyS, argument2, argument0, argument1, 1, 1, 0, c_white, 1);
    draw_sprite_part_ext(HaloCapBarsFullS, argument2, 0, 0, 188 * argument3, 15, argument0, argument1, 1, 1, c_white, 1);
    
    // draw the shining leading edge of the cap bar
    // calculate the sides
    pxL = floor(min(max(3, 188 * argument3 - 8), 184));
    pxR = floor(min(max(3, 188 * argument3), 184));
    
    // calculate the tops (the bottoms are always at 12)
    pyL = 2 + max(13 - pxL, 0) + max(pxL - 174, 0);
    pyR = 2 + max(13 - pxR, 0) + max(pxR - 174, 0);
    
    // draw the shiny area
    draw_primitive_begin(pr_trianglefan);
    draw_vertex_color(argument0 + pxL, argument1 + pyL, c_white, 0);
    draw_vertex_color(argument0 + pxR, argument1 + pyR, c_white, 1);
    draw_vertex_color(argument0 + pxR, argument1 + 12, c_white, 1);
    draw_vertex_color(argument0 + pxL, argument1 + 12, c_white, 0);
    draw_primitive_end();
}
