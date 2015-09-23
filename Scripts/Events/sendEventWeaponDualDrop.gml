/* Sends a dual-wield weapon drop event
**
** argument0 = The player who's leaving dual-wield mode and dropping the weapon (by instance ID)
*/

write_ubyte(global.sendBuffer, WEAPON_DUALDROP);

write_ubyte(global.sendBuffer, ds_list_find_index(global.players, argument0));
