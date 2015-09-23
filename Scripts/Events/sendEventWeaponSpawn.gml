/* Sends a weapon spawn event
**
** argument0 = Weapon type constant
** argument1 = Ammo remaining in the weapon
** argument2 = Frames before the server despawns the weapon
** argument3 = x position to spawn the weapon at
** argument4 = y position to spawn the weapon at
** argument5 = initial x-velocity of the weapon
** argument6 = initial y-velocity of the weapon
** argument7 = buffer (if undefined, defaults to the send buffer)
**              this is a special case for the ServerJoinUpdate script to send only to a specific socket
**
*/

var buffer;
    
if (argument7 == 0) {
    buffer = global.sendBuffer;
} else {
    buffer = argument7;
}

write_ubyte(buffer, WEAPON_SPAWN);

// write weapon type, ammo, and lifetime
write_ubyte(buffer, argument0);
write_ushort(buffer, argument1);
write_short(buffer, argument2);
// write spawn location
write_ushort(buffer, argument3 * 5);
write_ushort(buffer, argument4 * 5);
// write inital velocity
write_short(buffer, argument5 * 8.5);
write_short(buffer, argument6 * 8.5);
