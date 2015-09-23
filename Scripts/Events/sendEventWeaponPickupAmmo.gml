/* Sends a weapon pickup ammo event
**
** argument0 = The player who's picking up a powerup (by instance ID)
** argument1 = The array index of the weapon that's receiving the ammo (0 - 1 for normals, 2 for dual-wielded)
** argument2 = The weapon powerup that ammo's being picked up from (by instance ID)
** argument3 = The amount of ammo that's being picked up
**
*/

write_ubyte(global.sendBuffer, WEAPON_PICKUP_AMMO);

// write the player and the weapon powerup index numbers
write_ubyte(global.sendBuffer, ds_list_find_index(global.players, argument0));
write_ubyte(global.sendBuffer, argument1);
write_ushort(global.sendBuffer, ds_list_find_index(global.weaponPowerups, argument2));
write_ushort(global.sendBuffer, argument3);
