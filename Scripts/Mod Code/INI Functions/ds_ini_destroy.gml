/* Destroys an INI map, clearing and freeing all of its data first.
**
** argument0 = INI map handle
*/
{
    ds_ini_clear(argument0);
    ds_map_destroy(argument0);
}
