/* Performs a needle pop event
**
** argument0 = The player whose attached needles will pop (by instance ID)
*/

{
    var bolt, needleCount, i, j, blastOwner, mostNeedles, curOwner;
    
    // if there are 9 or more needles stuck to the victim, we trigger an explosion at their location
    if ((ds_list_size(argument0.object.stuckNeedles)) >= 9) {
        // figure out who to credit the blast to, based on who landed the most needles
        
        needleCount = ds_list_create();
        // populate the list with 0s for each player
        for (i = 0; i < ds_list_size(global.players); i += 1) {
            ds_list_add(needleCount, 0);
        }
        // count the needles by owner
        for (i = 0; i < ds_list_size(argument0.object.stuckNeedles); i += 1) {
            // get the needle
            bolt = ds_list_find_value(argument0.object.stuckNeedles, i);
            // increment the matching owner
            ds_list_replace(needleCount, ds_list_find_index(global.players, bolt.ownerPlayer), ds_list_find_value(needleCount, ds_list_find_index(global.players, bolt.ownerPlayer)) + 1);
        }
        mostNeedles = 0;
        blastOwner = noone;
        // figure out which player has the most needles attached
        for (i = 0; i < ds_list_size(global.players); i += 1) {
            if (ds_list_find_value(needleCount, i) > mostNeedles) {
                // more than the previous
                mostNeedles = ds_list_find_value(needleCount, i);
                blastOwner = ds_list_find_value(global.players, i);
                
            } else if ((ds_list_find_value(needleCount, i) == mostNeedles) && (mostNeedles > 0)) {
                // there is a tie for most needles, the winner is whoever landed the newest needle
                curOwner = blastOwner;
                
                // iterate through the needle list to find out whose is newest
                for (j = 0; i < ds_list_size(argument0.object.stuckNeedles); j += 1) {
                    // get the needle
                    bolt = ds_list_find_value(argument0.object.stuckNeedles, j);
                    // if either the current owner or the challenger is the owner of the needle
                    if ((bolt.ownerPlayer == curOwner) || (bolt.ownerPlayer == ds_list_find_value(global.players, i))) {
                        // set the blast owner to this needle (the latest needle will be the last match)
                        blastOwner = bolt.ownerPlayer;
                    }
                }
            }
        }
        
        // destroy the list we used
        ds_list_destroy(needleCount);
        
        // explosion at the victim's location, with the strength and range of a plasma grenade burst
        explosiveDamage(argument0.object.x, argument0.object.y, 60, 50, 120, blastOwner, WEAPON_NEEDLER);
        
        // play the sound
        playsound(argument0.object.x, argument0.object.y, global.NeedlerExplodeSnd);
        
        // spawn the particles
        part_particles_create(global.weaponPS, argument0.object.x, argument0.object.y, global.needleBurstFlashPT, 4);
        part_particles_create(global.weaponPS, argument0.object.x, argument0.object.y, global.needleBurstLinePT, 13);
        part_particles_create(global.weaponPS, argument0.object.x, argument0.object.y, global.needleBurstSmokePT, 2);
        
        // destroy all the needles
        while (ds_list_size(argument0.object.stuckNeedles) > 0) {
            // get the first needle in the list
            bolt = ds_list_find_value(argument0.object.stuckNeedles, 0);
            // destroy it
            with (bolt) instance_destroy();
            // delete it from the list
            ds_list_delete(argument0.object.stuckNeedles, 0);
        }
    } else {
        // otherwise, each individual needle bursts
        while (ds_list_size(argument0.object.stuckNeedles) > 0) {
            // get the first needle in the list
            bolt = ds_list_find_value(argument0.object.stuckNeedles, 0);
            // give it the pop command
            with (bolt) event_user(1);
            // delete it from the list
            ds_list_delete(argument0.object.stuckNeedles, 0);
        }
    }
}
