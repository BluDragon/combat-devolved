/* Common weapon function which calculates the point where the weapon's projectile would fire from
** if shot, creating/assigning variables for the return.
**
** No Arguments.
**
** Created 'return' variables:
** shotx = x position of the shot point
** shoty = y position of the shot point
*/
{
    var theta;
    
    theta = degtorad(image_angle);

    // Trigonometry & Transformation Matrices are quite useful!
    // This is the new version which fixes some minor bugs when facing left
    if (getWeaponPosition(id) == 2) {
        // left-hand gun formula
        shotx = x + (xoffset + xoffsetDW) * image_xscale + (cos(theta) * xbarrel * image_xscale + sin(theta) * ybarrel);
        shoty = y + (yoffset + yoffsetDW) - (sin(theta) * xbarrel * image_xscale - cos(theta) * ybarrel);
    } else {
        // original formula
        shotx = x + xoffset * image_xscale + (cos(theta) * xbarrel * image_xscale + sin(theta) * ybarrel);
        shoty = y + yoffset - (sin(theta) * xbarrel * image_xscale - cos(theta) * ybarrel);
    }
    
    // adjust shot origin for character movement speed, but not if this function is called
    // during the draw event (i.e. Spartan Laser's pointer)
    if (event_type != ev_draw) {
        shotx += owner.hspeed;
        shoty += owner.vspeed;
    }
}
