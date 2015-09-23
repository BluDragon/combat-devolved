/* Toggles whether the character is crouched or standing
**
** argument0 = Whether to transition to/from crouching
**              If true, the character will use the transition anim
**              If false, the user will instantly be standing/crouched again (i.e. if shot while crouched)
*/
{
    // toggle crouch state
    crouched = !crouched;
    
    // animation-related
    if (argument0) {
        // and start the crouch frame thing
        crouchFrame = 2;
        // use the sprite index of the lowering animation (for collision box)
        sprite_index = ArmorLoweringColorS;
    } else {
        // instantly pop up/down (if shot while transitioning)
        crouchFrame = -1;
        animationImage = 0; // reset the image index to 0
        
        // use the proper sprite index for the desired state
        if (crouched) {
            sprite_index = ArmorCrouchColorS;
        } else {
            sprite_index = ArmorWalkColorS;
        }
    }
    
    // speed-related
    if (crouched) {
        runPower = 0.6;
    } else {
        runPower = 1;
    }
}
