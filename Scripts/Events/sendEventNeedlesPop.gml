/* Sends a needle pop event
**
** argument0 = The player whose attached needles will pop (by instance ID)
*/

write_ubyte(global.sendBuffer, NEEDLES_POP);

write_ubyte(global.sendBuffer, ds_list_find_index(global.players, argument0));
