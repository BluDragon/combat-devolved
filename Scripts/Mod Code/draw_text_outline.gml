/* draws text scaled with an outline
** 
** argument0 = x
** argument1 = y
** argument2 = string
** argument3 = x scale
** argument4 = y scale
** argument5 = angle
** argument6 = main color
** argument7 = outline color
*/
{    
    draw_set_color(argument7);
    draw_text_transformed(argument0 + 1, argument1, argument2, argument3, argument4, argument5);
    draw_text_transformed(argument0 - 1, argument1, argument2, argument3, argument4, argument5);
    draw_text_transformed(argument0, argument1 + 1, argument2, argument3, argument4, argument5);
    draw_text_transformed(argument0, argument1 - 1, argument2, argument3, argument4, argument5);
    draw_set_color(argument6);
    draw_text_transformed(argument0, argument1, argument2, argument3, argument4, argument5);
}
