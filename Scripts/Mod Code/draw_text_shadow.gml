/* draws text scaled with a shadow
** 
** argument0 = x
** argument1 = y
** argument2 = string
** argument3 = x scale
** argument4 = y scale
** argument5 = angle
** argument6 = main color
** argument7 = shadow color
** argument8 = alpha
*/
{
    var alpha;
    
    // preserve existing alpha settings
    alpha = draw_get_alpha();
    
    draw_set_alpha(argument8);
    draw_set_color(argument7);
    draw_text_transformed(argument0, argument1 + 1, argument2, argument3, argument4, argument5);
    draw_set_color(argument6);
    draw_text_transformed(argument0, argument1, argument2, argument3, argument4, argument5);
    
    // restore existing alpha settings
    draw_set_alpha(alpha);
}
