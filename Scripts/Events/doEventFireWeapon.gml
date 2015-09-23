/* Performs a weapon fire event
**
** argument0 = The player whose weapon was fired
** argument1 = Random seed (0 - 65535)
** argument2 = The array index of the weapon being fired (0, 1 = normal, 2 = dual-wield)
**
*/

{
    var old_seed;
    
    old_seed = random_get_seed();
    random_set_seed(argument1);
    
    // fire the specified weapon
    with (argument0.object.weapons[argument2]) event_user(3);
    
    random_set_seed(old_seed);
}
