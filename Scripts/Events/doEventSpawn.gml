/**
 * Spawn a player. If he already has a character object, destroy it
 * and respawn.
 *
 * argument0: The player who spawned
 * argument1: The spawnpoint ID
 * argument2: The spawn group
 */

var spawner, spawnpointId, spawnGroup;
spawner = argument0;
spawnpointId = argument1;
spawnGroup = argument2;

var spawnX, spawnY, character;
if(spawner.team == TEAM_RED) {
    spawnX = ds_list_find_value(global.spawnPointsRed[0,spawnGroup], spawnpointId);
    spawnY = ds_list_find_value(global.spawnPointsRed[1,spawnGroup], spawnpointId);
} else {
    spawnX = ds_list_find_value(global.spawnPointsBlue[0,spawnGroup], spawnpointId);
    spawnY = ds_list_find_value(global.spawnPointsBlue[1,spawnGroup], spawnpointId);
}

if(spawner.object != -1) {
    with(spawner.object) {
        instance_destroy();
    }
    spawner.object=-1;
}

global.paramPlayer = spawner;
spawner.object = instance_create(spawnX,spawnY, Character);
global.paramPlayer = noone;

if (instance_exists(RespawnTimer)) {
    with(RespawnTimer) {
        done = true;
    }
}

playsound(spawnX, spawnY, global.RespawnSnd);
