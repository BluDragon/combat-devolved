/* Returns if a key exists within a given section.
**
** argument0 = INI map handle
** argument1 = section name
** argument2 = key name
*/
{
    if (ds_ini_section_exists(argument0, argument1) == false) return (false);
    return (ds_map_exists(ds_map_find_value(argument0, argument1), argument2));
}
