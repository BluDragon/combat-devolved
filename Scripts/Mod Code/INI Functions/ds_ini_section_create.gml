/* Creates a new section in the INI.
** If the section already exists, the function returns false.
**
** argument0 = INI map handle
** argument1 = section name
*/
{
    if (ds_ini_section_exists(argument0, argument1)) return false;
    ds_map_add(argument0, argument1, ds_map_create());
    return true;
}
