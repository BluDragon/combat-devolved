/* Hitscan collision searching for melee actions -- derived from and separate from the
** weapon hitscan due to the two being called by different entities (Character vs. Weapon),
** and having some different basic needs.  Also partially inspired by Dusty's implementation
** of melee functionality.
** 
** Function Arguments:
** argument0 = hitscan search range in pixels
** argument1 = hitscan search direction
**
** Returns the instance ID of the character that was hit,
** or -1 if nothing of interest was hit (basically everything else).
*/

{
    // HITSCAN LASER TIME
    var theta, shotx, shoty, shotx2, shoty2, hitID;
    
    // We don't need to transform the origin like we did with the weapons,
    // as the origin is the character itself
    shotx = x;
    shoty = y;
    
    // we default to having hit nothing (in case a shot falls short)
    hitID = -1;
    
    var hit, x1, y1, xm, ym, len;
    var hitline, colID;
    len = argument0;
    x1 = shotx;
    y1 = shoty;
    theta = argument1;
    if (image_xscale < 0) theta -= 180;
    shotx2 = shotx + lengthdir_x(len, theta);
    shoty2 = shoty + lengthdir_y(len, theta);
    
    while (len > 1) {
        xm = (x1 + shotx2) / 2;
        ym = (y1 + shoty2) / 2;
        
        hitline = false;
        // check Obstacles first
        if (!hitline) {
            colID = collision_line(x1, y1, xm, ym, Obstacle, true, true);
            if (colID >= 0) {
                hitID = -1;
                hitline = true;
            }
        }
        
        // check Characters next
        if (!hitline) {
            colID = collision_line(x1, y1, xm, ym, Character, true, true)
            if (colID >= 0) {
                // only proceed if the object's not an ally
                if (!onSameTeam(player, colID.player)) {
                    hitID = colID;
                    hitline = true;
                }
            }
        }
        
        // check Helmets
        if (!hitline) {
            colID = collision_line(x1, y1, xm, ym, Helmet, true, true)
            if (colID >= 0) {
                // make sure it's not the owner's own head and it's not an ally's helmet
                if (colID.owner != id) && (!onSameTeam(player, colID.ownerPlayer)) {
                    hitID = colID.owner;
                    hitline = true;
                }
            }
        }
        
        // TeamGate objects
        if (!hitline) {
            colID = collision_line(x1, y1, xm, ym, TeamGate, true, true)
            if (colID >= 0) {
                hitID = -1;
                hitline = true;
            }
        }
        
        // IntelGate objects
        if (!hitline) {
            colID = collision_line(x1, y1, xm, ym, IntelGate, true, true)
            if (colID >= 0) {
                hitID = -1;
                hitline = true;
            }
        }
        
        // ControlPointSetupGate objects
        if (!hitline) {
            colID = collision_line(x1, y1, xm, ym, ControlPointSetupGate, true, true)
            if (colID >= 0) {
                if ControlPointSetupGate.solid == true {
                    hitID = -1;
                    hitline = true;
                }
            }
        }
        
        // BulletWall objects
        if (!hitline) {
            colID = collision_line(x1, y1, xm, ym, BulletWall, true, true)
            if (colID >= 0) {
                hitID = -1;
                hitline = true;
            }
        }
        
        if (hitline) {
            shotx2 = xm;
            shoty2 = ym;
        } else {
            x1 = xm;
            y1 = ym;
        }
        len /= 2;
    }
    
    // Return the instance ID of what was hit (or, again, -1 if nothing of interest was hit)
    return (hitID);
}
