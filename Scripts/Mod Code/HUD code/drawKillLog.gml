// text order: n1, w1 sprite, str, n2

var i, map, n1, t1, w1, n2, t2, in, str, color;

draw_set_halign(fa_left);
draw_set_valign(fa_center);

// modified kill log to appear in lower-left corner

for (i = 0; i < ds_list_size(kills); i += 1) {
    map = ds_list_find_value(kills, ds_list_size(kills) - i - 1);   // new messages appear at the top
    n1 = ds_map_find_value(map, "name1"); // Name of the Player who killed
    t1 = ds_map_find_value(map, "team1"); // Their team
    w1 = ds_map_find_value(map, "weapon"); // Their weapon sprite
    n2 = ds_map_find_value(map, "name2"); // Name of the Player who died
    t2 = ds_map_find_value(map, "team2"); // Their team
    in = ds_map_find_value(map, "inthis"); // Am I involved in this event?
    str = ds_map_find_value(map, "string"); // Special text: Finish off, bid farewell, domination, revenge
    
    draw_set_alpha(1);
    if (in)
       color = make_color_rgb(36,36,36);
    else color = make_color_rgb(0,0,0);
draw_rectangle_color(view_xview[0] + 8, view_yview[0] + view_hview[0] + i * 20 - 94,
    view_xview[0] + string_width(n1 + n2 + str) + 8 + sprite_get_width(w1), view_yview[0] + view_hview[0] + i * 20 - 104 - 8, color, color, color, color, 0);
draw_rectangle_color(view_xview[0] + 6, view_yview[0] + view_hview[0] + i * 20 - 96,
    view_xview[0] + string_width(n1 + n2 + str) + 10 + sprite_get_width(w1), view_yview[0] + view_hview[0] + i * 20 - 104 - 6, color, color, color, color, 0);

    if (t1 == TEAM_RED) {
        draw_set_color(make_color_rgb(225, 0, 0));
    } else if (t1 == TEAM_BLUE) {
        draw_set_color(make_color_rgb(12, 173, 249));
    } else {
        draw_set_color(c_white);
    }
    draw_text(view_xview[0] + + 8, view_yview[0] + view_hview[0] + i * 20 - 104, n1);
    
    draw_set_halign(fa_left);
    if (w1 != -1) {
        draw_sprite(w1, in, floor(view_xview[0] + string_width(n1) + 8 + sprite_get_width(w1) / 2), floor(view_yview[0] + view_hview[0] + i * 20 - 104));
    }
    
    if (in)
        draw_set_color(c_white);
    else draw_set_color(c_white);
    draw_text(view_xview[0] + string_width(n1) + 8 + sprite_get_width(w1), view_yview[0] + view_hview[0] + i * 20 - 104, str);
    draw_set_halign(fa_left);
    
    if (t2 == TEAM_RED) {
        draw_set_color(make_color_rgb(225, 0, 0));
    } else if (t2 == TEAM_BLUE){
        draw_set_color(make_color_rgb(12, 173, 249));
    } else {
        draw_set_color(c_white);
    }
    draw_text(view_xview[0] + string_width(n1 + str) + 8 + sprite_get_width(w1), view_yview[0] + view_hview[0] + i * 20 - 104, n2);
}
