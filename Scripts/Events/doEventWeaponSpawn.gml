/* Spawns a weapon drop powerup
**
** argument0 = Weapon type constant
** argument1 = Ammo remaining in the weapon
** argument2 = Frames before the server despawns the weapon
** argument3 = x position to spawn the weapon at
** argument4 = y position to spawn the weapon at
** argument5 = initial x-velocity of the weapon
** argument6 = initial y-velocity of the weapon
**
** Returns the instance ID of the weapon powerup (needed by weapon spawners)
*/
{
    var pId;
    
    // spawn the weapon powerup
    global.paramWeaponType = argument0;
    global.paramWeaponAmmo = argument1;
    global.paramWeaponLifetime = argument2;
    pId = instance_create(argument3, argument4, WeaponDrop);
    pId.hspeed = argument5;
    pId.vspeed = argument6;
    
    // and add its instance ID to the list of powerups
    ds_list_add(global.weaponPowerups, pId);
    
    return pId;
}
