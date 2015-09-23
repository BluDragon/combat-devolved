/* Sets the value of a key in an INI section.
** If the key doesn't exist, it is added.
** If the key already exists, it is updated.
**
** argument0 = INI map handle
** argument1 = section name
** argument2 = key name
** argument3 = key value
*/
{
    // remove any leading whitespace from the key name
    argument2 = string_trim(argument2);
    if (ds_ini_key_exists(argument0, argument1, argument2)) {
        // update the key
        ds_map_replace(ds_map_find_value(argument0, argument1), argument2, argument3);
    } else {
        // add the section, if necessary
        if (ds_ini_section_exists(argument0, argument1) == false) ds_ini_section_create(argument0, argument1);
        
        // add the key
        ds_map_add(ds_map_find_value(argument0, argument1), argument2, argument3);
    }
}
