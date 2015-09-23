/* Sends a weapon fire event
**
** argument0 = The player whose weapon was fired
** argument1 = Random seed (0 - 65535)
** argument2 = The array index of the weapon being fired (0, 1 = normal, 2 = dual-wield)
**
*/
 
write_ubyte(global.sendBuffer, WEAPON_FIRE);
write_ubyte(global.sendBuffer, ds_list_find_index(global.players, argument0));
write_ubyte(global.sendBuffer, argument2);

write_ushort(global.sendBuffer, argument0.object.x * 5);
write_ushort(global.sendBuffer, argument0.object.y * 5);
write_short(global.sendBuffer, argument0.object.hspeed * 10);
write_short(global.sendBuffer, argument0.object.vspeed * 10);

write_ushort(global.sendBuffer, argument1);
