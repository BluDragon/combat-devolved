// Initialize all the data used by the Helmet functionality and the bobbing of helms/weapons

{
    // create some settings for the heads (max angles, etc)
    global.headMaxAngle = 40;       // farthest a character can look up
    global.headMinAngle = -28;      // farthest a character can look down
    
    // hey, let's init grenade stuff too, why not
    // the maximum and minimum angles for the grenade-throwing arm,
    // also affects the max and min angle a grenade can be thrown
    global.grenadeArmMaxAngle = 70;
    global.grenadeArmMinAngle = -70;
    
    // bob offsets (added to head's Y coordinate and gun arms' coordinates)
    global.walkBob[0] = 1;
    global.walkBob[1] = 0;
    global.walkBob[2] = 1;
    global.walkBob[3] = 2;
    global.walkBob[4] = 1;
    global.walkBob[5] = 0;
    global.walkBob[6] = 1;
    global.walkBob[7] = 2;
    global.walkBob[8] = 0;
    global.walkBob[9] = 0;
    
    // bob offsets for crouched movement
    global.crouchBob[0] = 10;
    global.crouchBob[1] = 10;
    global.crouchBob[2] = 11;
    global.crouchBob[3] = 10;
    global.crouchBob[4] = 10;
    global.crouchBob[5] = 10;
    global.crouchBob[6] = 11;
    global.crouchBob[7] = 10;
    global.crouchBob[8] = 10;
    
    // bob offsets for crouch transition
    global.loweringBob[0] = 0;
    global.loweringBob[1] = 5;
    global.loweringBob[2] = 10;
}
