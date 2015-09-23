/* Clears an INI map of all sections and keys, freeing their memory
** 
** argument0 = INI map handle
*/
{
    var section;
    // destroy each section map and remove their keys
    repeat (ds_map_size(argument0)) {
        section = ds_map_find_first(argument0);
        ds_map_destroy(ds_map_find_value(argument0, section));
        ds_map_delete(argument0, section);
    }
}
