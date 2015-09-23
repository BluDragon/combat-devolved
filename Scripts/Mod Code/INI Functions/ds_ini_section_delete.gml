/* Deletes a section from the INI map
**
** argument0 = INI map handle
** argument1 = section name
*/
{
    if (ds_ini_section_exists(argument0, argument1) == false) exit;
    ds_map_destroy(ds_map_find_value(argument0, argument1));
}
