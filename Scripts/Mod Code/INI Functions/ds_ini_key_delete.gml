/* Deletes a key from the INI map
**
** argument0 = INI map handle
** argument1 = section name
** argument2 = key name
*/
{
    if (ds_ini_key_exists(argument0, argument1, argument2) == false) exit;
    ds_map_delete(ds_map_find_value(argument0, argument1), argument2);
}
