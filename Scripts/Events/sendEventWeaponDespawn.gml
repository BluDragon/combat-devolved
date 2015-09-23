/* Sends a weapon despawn event
**
** argument0 = Weapon drop to despawn (by instance ID)
**
*/

write_ubyte(global.sendBuffer, WEAPON_DESPAWN);

// write the index of the item in the powerup list
write_ushort(global.sendBuffer, ds_list_find_index(global.weaponPowerups, argument0));
