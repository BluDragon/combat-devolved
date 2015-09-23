/* Sends a weapon swap event
**
** argument0 = The player who's picking up a weapon (by instance ID)
** argument1 = The array index of the weapon being picked up/swapped out (0,1 = normals, 2 = dual wield)
** argument2 = The weapon powerup (by instance ID)
**
*/

write_ubyte(global.sendBuffer, WEAPON_PICKUP);

write_ubyte(global.sendBuffer, ds_list_find_index(global.players, argument0));
write_ubyte(global.sendBuffer, argument1);
write_ushort(global.sendBuffer, ds_list_find_index(global.weaponPowerups, argument2));
