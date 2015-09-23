/* Despawns a weapon drop
**
** argument0 = Weapon drop to despawn (by instance ID)
**
*/

{   
    // remove it from the list
    ds_list_delete(global.weaponPowerups, ds_list_find_index(global.weaponPowerups, argument0));
    
    // then destroy the instance
    with (argument0) {
        instance_destroy();
    }
}
