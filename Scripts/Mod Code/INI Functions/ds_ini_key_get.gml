/* Gets the value of a key.
** Returns a supplied default value if the key or section doesn't exist.
**
** argument0 = INI map handle
** argument1 = section name
** argument2 = key name
** argument3 = default value
*/
{
    // remove any leading whitespace from the key name
    argument2 = string_trim(argument2);
    if (ds_ini_key_exists(argument0, argument1, argument2)) {
        return (ds_map_find_value(ds_map_find_value(argument0, argument1), argument2));
    }
    return (argument3);
}
