/* Throws a grenade
**
** argument0 = The player who's throwing the grenade.  Must have a character.
** argument1 = The type of grenade to throw (0 - 3)
** argument2 = Random seed (0 - 65535)
*/
{
    var old_seed;
    // cache the old seed
    old_seed = random_get_seed();
    random_set_seed(argument2);
    
    // toss the grenade
    with (argument0.object) {
        // perform one more grenade ammo check
        if (grenadeAmmo[argument1] > 0) {
            var gType, oid, speedMult, gx, gy, gSpawnDir, gMoveDir;
            
            speedMult = 1;
            
            switch (argument1) {
                case 0:
                    // Frag Grenade
                    gType = FragGrenade;
                    speedMult = 1.2;
                    break;
                
                case 1:
                    // Plasma Grenade
                    gType = PlasmaGrenade;
                    speedMult = 1.1;
                    break;
                
                case 2:
                    // Spike Grenade
                    gType = SpikeGrenade;
                    speedMult = 1.1;
                    break;
                
                case 3:
                    // Firebomb
                    gType = Firebomb;
                    speedMult = 1;
                    break;
            }
            
            // calculate the direction and spawn location of the grenade
            gSpawnDir = aimDirection;
            if ((aimDirection + 270) mod 360 > 180) {
                if ((gSpawnDir > 180) && ((gSpawnDir - 360) < global.grenadeArmMinAngle)) gSpawnDir = global.grenadeArmMinAngle;
                if ((gSpawnDir < 180) && (gSpawnDir > global.grenadeArmMaxAngle)) gSpawnDir = global.grenadeArmMaxAngle;
                gMoveDir = gSpawnDir;
            } else {
                if (gSpawnDir < (180 - global.grenadeArmMaxAngle)) gSpawnDir = 180 - global.grenadeArmMaxAngle;
                if (gSpawnDir > (180 - global.grenadeArmMinAngle)) gSpawnDir = 180 - global.grenadeArmMinAngle;
                gMoveDir = gSpawnDir;
                gSpawnDir += 180;
            }
            
            var xbarrel, ybarrel, theta;
            // the spawn location of the grenade, relative to the arm's origin
            xbarrel = 17;
            ybarrel = -1;
            theta = degtorad(gSpawnDir);
            
            gx = x + 4 * image_xscale + (cos(theta) * xbarrel * image_xscale + sin(theta) * ybarrel);
            gy = y - (sin(theta) * xbarrel * image_xscale - cos(theta) * ybarrel) + bobAmt;
            
            // spawn the grenade
            oid = instance_create(gx, gy, gType);
            // set the information for the grenade
            oid.owner = id;
            oid.ownerPlayer = player;
            oid.team = team;
            oid.direction = gMoveDir;
            oid.speed = 12 * speedMult;
            with (oid) {
                // if we would've gotten stuck where we spawned, pretend we spawned at the owner's origin
                if !place_free(x, y) {
                    xprevious = owner.x;
                    yprevious = owner.y;
                }
            }
            
            // decrement the ammo counter
            grenadeAmmo[argument1] -= 1;
            
            /*
            // if the current grenade is now out of ammo, cycle in reverse to the next available grenade
            if (grenadeAmmo[currentGrenade] <= 0) {
                var newType;
                
                newType = currentGrenade;
                do {
                    newType -= 1;
                    if (newType < 0) newType += 4;
                    if (grenadeAmmo[newType] > 0) currentGrenade = newType;
                } until (newType == currentGrenade);
            }
            */
            // cycle forwards
            if (grenadeAmmo[currentGrenade] <= 0) {
                var newType;
                
                newType = currentGrenade;
                // cycle to the next available grenade type, or return to the original if nothing is available
                do {
                    newType = (newType + 1) mod 4;
                    // if the new selected grenade type is in stock, set the currentGrenade to match
                    if (grenadeAmmo[newType] > 0) currentGrenade = newType;
                } until (newType == currentGrenade);
            }
        }
    }
    
    // restore the old seed
    random_set_seed(old_seed);
}
