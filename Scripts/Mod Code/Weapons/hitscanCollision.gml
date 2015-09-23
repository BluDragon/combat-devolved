/* Common hitscan collision detection function, shared by all weapons with hitscan fire.
** 
** Function Arguments:
** argument0 = x position of the start of the hitscan line
** argument1 = y position of the start of the hitscan line
** argument2 = the direction of the hitscan line (remember to precalc if based off image_angle)
** argument3 = weapon's hitscan range in pixels
**             (if -1, it will determine the range to be to the end of the map in the direction it's facing)
** argument4 = whether to ignore things that take damage and just hit an obstacle instead
** 
** Created 'return' variables:
** shotx2 = x position of the end of the hitscan line (used for drawing)
** shoty2 = y position of the end of the hitscan line (used for drawing)
** hitType = object ID of the object that's been hit (used for determining what we hit so damage can be applied properly)
** hitID = instance ID of the object that's been hit (used for damaging it)
*/

{
    // HITSCAN LASER TIME
    var xIntersect, yIntersect;
    
    // we default to having hit nothing (in case a shot falls short)
    hitType = -1;
    hitID = -1;
    
    var hit, x1, y1, xm, ym, len;
    var hitline, colID;
    /*
    // angle precalc
    theta = image_angle;    // use the current angle of the weapon rather than the char's aimDirection
    if (image_xscale < 0) theta -= 180;
    */
    
    // calculate the range
    // if the range is -1, set it to be to the edge of the map
    if (argument3 == -1) {
        // figure out where it'd fall off the map edge
        // vert and horiz cases first
        if (argument2 == 0) {
            // get the distance to the right edge
            len = background_width[0] * background_xscale[0] - argument0;
        } else if (argument2 == 90) {
            // get the distance to the top edge
            len = argument1;
        } else if (argument2 == 180) {
            // get the distance to the left edge
            len = argument0;
        } else if (argument2 == 270) {
            // get the distance to the bottom edge
            len = background_height[0] * background_yscale[0] - argument1;
        } else {
            // do line intersection checks
            // horizontal first
            if (argument2 > 0) && (argument2 < 180) {
                // check vs. top edge
                findLineIntersection(argument0, argument1, -argument2, 0, 0, 0);
                xIntersect = getLineIntersectX();
                yIntersect = getLineIntersectY();
            } else {
                // check vs. bottom edge
                findLineIntersection(argument0, argument1, -argument2, background_width[0] * background_xscale[0], background_height[0] * background_yscale[0], 0);
                xIntersect = getLineIntersectX();
                yIntersect = getLineIntersectY();
            }
            // check if the intersection is within the region, and if not, do the vertical checks instead
            if !((xIntersect >= 0) && (xIntersect <= background_width[0] * background_xscale[0])) {           
                if (argument2 > 90) && (argument2 < 270) {
                    // check vs. left edge
                    findLineIntersection(argument0, argument1, -argument2, 0, 0, 90);
                    xIntersect = getLineIntersectX();
                    yIntersect = getLineIntersectY();
                } else {
                    // check vs. right edge
                    findLineIntersection(argument0, argument1, -argument2, background_width[0] * background_xscale[0], background_height[0] * background_yscale[0], 90);
                    xIntersect = getLineIntersectX();
                    yIntersect = getLineIntersectY();
                }
            }
            // the intercepts should be correct, so use them to get the distance
            len = point_distance(argument0, argument1, xIntersect, yIntersect);
        }
    } else {
        // the max range is already defined
        len = argument3;
    }
    
    x1 = argument0;
    y1 = argument1;
    shotx2 = argument0 + lengthdir_x(len, argument2);
    shoty2 = argument1 + lengthdir_y(len, argument2);
    
    while (len > 1) {
        xm = (x1 + shotx2) / 2;
        ym = (y1 + shoty2) / 2;
        
        hitline = false;
        with (owner) {
            // check Obstacles first
            if (!hitline) {
                colID = collision_line(x1, y1, xm, ym, Obstacle, true, true);
                if (colID >= 0) {
                    other.hitType = Obstacle;
                    other.hitID = colID;
                    hitline = true;
                }
            }
            
            // check Characters next
            if (!hitline) && (!argument4) {
                colID = collision_line(x1, y1, xm, ym, Character, true, true)
                if (colID >= 0) {
                    // only proceed if the object's not an ally
                    if (!onSameTeam(player, colID.player)) {
                        other.hitType = Character;
                        other.hitID = colID;
                        hitline = true;
                    }
                }
            }
            
            // check Helmets
            if (!hitline) && (!argument4) {
                colID = collision_line(x1, y1, xm, ym, Helmet, true, true)
                if (colID >= 0) {
                    // make sure it's not the owner's own head and it's not an ally's helmet
                    if (colID.owner != other.owner) && (!onSameTeam(player, colID.ownerPlayer)) {
                        other.hitType = Helmet;
                        other.hitID = colID;
                        hitline = true;
                    }
                }
            }
            
            // TeamGate objects
            if (!hitline) {
                colID = collision_line(x1, y1, xm, ym, TeamGate, true, true)
                if (colID >= 0) {
                    other.hitType = TeamGate;
                    other.hitID = colID;
                    hitline = true;
                }
            }
            
            // IntelGate objects
            if (!hitline) {
                colID = collision_line(x1, y1, xm, ym, IntelGate, true, true)
                if (colID >= 0) {
                    other.hitType = IntelGate;
                    other.hitID = colID;
                    hitline = true;
                }
            }
            
            // ControlPointSetupGate objects
            if (!hitline) {
                colID = collision_line(x1, y1, xm, ym, ControlPointSetupGate, true, true)
                if (colID >= 0) {
                    if ControlPointSetupGate.solid == true {
                        other.hitType = ControlPointSetupGate;
                        other.hitID = colID;
                        hitline = true;
                    }
                }
            }
            
            // BulletWall objects
            if (!hitline) {
                colID = collision_line(x1, y1, xm, ym, BulletWall, true, true)
                if (colID >= 0) {
                    other.hitType = BulletWall;
                    other.hitID = colID;
                    hitline = true;
                }
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
}
