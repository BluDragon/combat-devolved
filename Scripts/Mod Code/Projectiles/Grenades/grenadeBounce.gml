/* Physics reaction for a grenade striking an object it should bounce off
**
** argument0 = Type of the object that was struck
*/
{
    var sid;
    
    // if the grenade hasn't armed yet, detonate in 1 second
    if (!armed) {
        armed = true;
        alarm[0] = fuseLength;
        sid = playsound(x, y, armedSound);
        // register the armed sound for autopan
        registerAutopanSound(sid, x, y);
    }
    
    // play the bounce sound only if it's been aloft long enough
    if (airtime > 3) playsound(x, y, bounceSound);
    airtime = 0;
    
    // move the grenade to contact with the obstacle
    move_contact_solid(direction, speed);
    
    // cut down speed
    speed *= bounceCoefficient;
    
    // react differently based on what was hit
    switch (argument0) {
        case TeamGate:
            // return to the previous position and then reflect horizontally
            x = xprevious;
            y = yprevious;
            if (hspeed != 0) hspeed = -hspeed;
            break;
        
        case Character:
            // reflect properly
            // vertical check with the object
            if (vspeed != 0) && ((bbox_bottom >= other.bbox_top) || (bbox_top <= other.bbox_bottom)) {
                // vertical collision
                vspeed = -vspeed;
            }
            // horizontal check with the object
            if (hspeed != 0) && ((bbox_right >= other.bbox_left) || (bbox_left <= other.bbox_right)) {
                // horizontal collision
                hspeed = -hspeed;
                // if the new horizontal speed is less than the other, make them match
                if (abs(hspeed) < abs(other.hspeed)) hspeed = other.hspeed * 1.1;
            }            
            
            // return to the previous position
            x = xprevious;
            y = yprevious;
            break;
        
        default:
            // crude physics adapted from characterHitObstacle
            if (vspeed != 0 && !place_free(x, y + sign(vspeed))) {
                // we hit a ceiling or floor
                vspeed = -vspeed;
            }
    
            if (hspeed != 0 && !place_free(x + sign(hspeed), y)) {
                // we hit a wall
                hspeed = -hspeed;
            }
            break;
    }
}
