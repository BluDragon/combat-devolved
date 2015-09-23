// argument0 = buffer
{
    // Server, sends data to joining player as an update
    var i, player, drop;

    write_ubyte(argument0, JOIN_UPDATE);
    write_ubyte(argument0, ds_list_size(global.players));
    write_ubyte(argument0, global.currentMapArea);
    
    ServerChangeMap(global.currentMap, global.currentMapMD5, socket);
    
    for (i = 0; i < ds_list_size(global.players); i += 1) {
        player = ds_list_find_value(global.players, i);
        ServerPlayerJoin(player, argument0);
        ServerPlayerChangeteam(i, player.team, argument0);
    }
    
    // Send weapon spawn events for each weapon drop
    for (i = 0; i < ds_list_size(global.weaponPowerups); i += 1) {
        // only send it if it exists and remove references to non-existent powerups (bugfix)
        drop = ds_list_find_value(global.weaponPowerups, i);
        if (instance_exists(drop)) {
            // send the event with the basic info -- the rest of the info (age, speed, etc.) will be sycned on the full update
            sendEventWeaponSpawn(drop.weaponType, drop.ammo, drop.alarm[0], drop.x, drop.y, drop.hspeed, drop.vspeed, argument0);
        } else {
            // the instance doesn't exist, something has gone pear-shaped
            // remove the instance from the list
            // NOTE: We may need to send a message to the clients to delete it too, but I'm not sure
            ds_list_delete(global.weaponPowerups, ds_list_find_index(global.weaponPowerups, argument0));
            i -= 1;
        }
    }
    
    serializeState(FULL_UPDATE, argument0);
}
