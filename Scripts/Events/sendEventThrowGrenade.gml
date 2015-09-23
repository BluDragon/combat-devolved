/* Sends a grenade-throw event
**
** argument0 = The player who's throwing a grenade
** argument1 = The type of grenade to throw (0 - 3)
** argument2 = Random seed (0 - 65535)
**
*/

write_ubyte(global.sendBuffer, GRENADE_THROW);
write_ubyte(global.sendBuffer, ds_list_find_index(global.players, argument0));

// write the player's position and velocity
write_ushort(global.sendBuffer, argument0.object.x * 5);
write_ushort(global.sendBuffer, argument0.object.y * 5);
write_byte(global.sendBuffer, argument0.object.hspeed * 8.5);
write_byte(global.sendBuffer, argument0.object.vspeed * 8.5);

// write the grenade type
write_ubyte(global.sendBuffer, argument1);

// write the random seed
write_ushort(global.sendBuffer, argument2);
