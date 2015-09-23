/* Calculates and returns the volume a sound should be based upon the source's distance from the
** observer (the center of the screen, or the player character)
**
** argument0 = x-coordinate of the sound source
** argument1 = y-coordinate of the sound source
** argument2 = pixel range in which the sound will play full volume (optional, default 300)
** argument3 = pixel range beyond which the sound will not be heard (optional, default 1500)
*/
{
    var xmid, ymid, dist;
    
    // if the range arguments were undefined, set their defaults
    if (argument2 == 0) argument2 = 300;
    if (argument3 == 0) argument3 = 1500;
    
    xmid = view_xview[0] + view_wview[0] / 2;
    ymid = view_yview[0] + view_hview[0] / 2;
    
    // if a character player exists, use his position rather than the view's
    if (myCharExists()) {
        xmid = global.myself.object.x;
        ymid = global.myself.object.y;
    }
    
    dist = sqrt((xmid - argument0) * (xmid - argument0) + (ymid - argument1) * (ymid - argument1));
    
    if (dist < argument2) {
        return 1;
    } else if (dist > argument3) {
        return 0;
    } else {
        // modify the volume, so it uses an exponential (GM) rather than linear (FMOD) volume scale
        return power(((argument3 - dist) / (argument3 - argument2)), 6);
    }
}
