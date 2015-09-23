/* Records the earning of a medal in the medal log
**
** argument0 = medal's sprite ID
** argument1 = medal's name (text displayed)
*/
{
    with (MedalController) {
        map = ds_map_create();
        ds_map_add(map, "sprite", argument0);
        ds_map_add(map, "text", argument1);
        ds_map_add(map, "age", 0);
        ds_list_add(medals, map);
        
        // if more than X medals are in the list, delete the oldest one
        if (ds_list_size(medals) > maxMedals) {
            ds_map_destroy(ds_list_find_value(medals, 0));
            ds_list_delete(medals, 0);
        }
    }
}
