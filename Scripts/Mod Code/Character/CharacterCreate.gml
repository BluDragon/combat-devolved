// Character - Create event
{
    player = global.paramPlayer;
    team = player.team;
    // get the custom color and armor type from the player object
    bodyColor = player.bodyColor;
    bodyType = player.bodyType;
    helmetColor = player.helmetColor;
    helmetType = player.helmetType;
    shoulderType = player.shoulderType;
    accessoryType = player.accessoryType;
    bobAmt = 0;     // the amount to modify the Y value of child objects by for the current frame of animation
    
    state = CHAR_STATE_NORMAL;  // spawn in with the normal weapon state
    
    // set the 'default' sprite info (what to draw in the draw event)
    colorSprite = ArmorWalkColorS;
    overSprite = ArmorWalkOutlineS;
    
    // cloaking
    crouchCloaked = false;  // whether the character has received a cloak effect from crouching (from the perspective of the viewer)
    stealthSprite = -1;

    // Default properties of Characters (those where defaults make sense)
    canCloak = 0;
    runPower = 1;
    jumpStrength = 8;
    capStrength = 1;
    intelRecharge = 0;
    
    // Set default HP and Shield values
    maxHp = 45;
    maxShieldHp = 70;
    hp = maxHp;
    shieldHp = maxShieldHp;
    
    // the number of consecutive frames the player has remained unhurt, caps at 60,000 (33m 20s)
    // this is used for things like shield recharging and other effects
    timeUnscathed = 0;
    // timer for drawing the shield flash overlay
    shieldFlash = -1;
    // whether the user is crouched or not
    crouched = false;
    crouchFrame = -1;   // the current frame to use for the crouch animation
    
    // variables for tracking weapon pickups
    // nearest weapon SWAP powerup the player is having a collision event with this frame
    nearestPickupWeapon = noone;     // the instance ID of the powerup
    nearestPickupWeaponDist = 0;     // the distance in pixels
    weaponPickupKeyTimer = 0;     // the number of frames the pickup-weapon key has been held down
    // nearest weapon DUALWIELD powerup the player is having a collision event with this frame
    nearestDualWeapon = noone;      // the instance ID of the powerup
    nearestDualWeaponDist = 0;      // the distance in pixels
    weaponDualKeyTimer = 0;         // the number of frames the dual-wield weapon key has been held down
    weaponDualKeyPickedUp = false;  // whether a weapon was 'picked up' when the timer was reset (needed for the fact the key is shared with grenade cycling)
    
    // melee functionality
    meleeStrikeMask = noone; // the instance ID of the mask used for melee strikes
    meleeLungeTimer = -1;   // 'custom' timer for the lunge itself (if > -1, a lunge is occuring)
    meleeSearchTimer = -1;  // 'custom' timer for the searching prior to a lunge (when meleeing, will search for 3 frames before giving up on lunging)
    lungeXspeed = 0;        // the speed we're locked into during a lunge operation
    lungeYspeed = 0;        // the speed we're locked into during a lunge operation
    
    // Grenade functionality
    // set the stock levels for the grenade types, max 2 each
    // Order for the grenade array is: Frag, Plasma, Spike, Fire.
    var i;
    for (i = 0; i < 4; i += 1) {
        grenadeAmmo[i] = 0;     // set them all to start at 0
    }
    grenadeAmmo[0] = 2;     // everyone starts with 2 Frag Grenades
    currentGrenade = 0;     // the index of the currently-selected grenade
    grenadeCooldownTimer = -1;      // grenade cooldown timer
    grenadeTossFrame = -1;          // the current frame to use for the grenade toss animation
    grenadeTossType = -1;           // the grenade that will be spawned at toss -- locked upon pressing of the throw key
        
    // old GG2 variables that may stick around?
    flamecount = 0;
    invisible = false;
    intel = false;
    onCabinet = 0;
    
    // weapon effect stuff (i.e immolation, needles, etc.)
    firebombBurning = false;    // if the player is on fire from touching the 'core' of a firebomb glob (this does not wear off until the player dies)
    firebombedBy = -1;          // the player whose firebomb set the burning status
    // the particle emitter for the fire effects
    fireEmitter = part_emitter_create(global.weaponPS);
    part_emitter_region(global.weaponPS, fireEmitter, x - 7, x + 7, y + 3, y + 17, ps_shape_ellipse, ps_distr_gaussian);
    // list of the needle instances currently stuck to the character
    stuckNeedles = ds_list_create();
    
    /*
    //afterburn stuff
    burnIntensity = 0;
    maxIntensity = 9; //maximum afterburn intensity in DPS
    burnDuration = 0;
    maxDuration = 210; //maximum afterburn length in frames
    decayDelay = 30; //time between burning and intensity lowering
    decayDuration = 150; //time between intensity lowering and zeroing out
    durationDecay = 1; //amount that duration lowers per step
    intensityDecay = burnIntensity / decayDuration;
    burnedBy = -1;
    afterburnSource = -1;
    numFlames = 4 ; //purely cosmetic - the number of flames that someone has with max burnIntensity
    for(i = 0; i < numFlames; i += 1)
    {
        flameArray_x[i] = random_range(-(bbox_right-bbox_left)/2, (bbox_right-bbox_left)/2);
        flameArray_y[i] = random_range(-(bbox_top-bbox_bottom)/2, (bbox_top-bbox_bottom)/2);
    }
    alarm[5] = 1; //this alarm re-randomizes the flame positions
    */
    
    // controls
    keyState = 0;
    lastKeyState = 0;
    pressedKeys = 0;
    releasedKeys = 0;
    aimDirection = 0;
    netAimDirection = 0;
    // aim distance is now sent as well, so the location of the client's cursor can be determined
    // NOTE: I tried sending the raw x and y positions of the cursor, but those seemed to get
    // fudged by the character's motion, so this is the preferred solution
    aimDistance = 0;
    netAimDistance = 0;

    image_speed = 0;
    
    //animationOffset = bodyType * (CHAR_RUN_ANIM_LEN + 2);
    animationImage = 0;
    animationBase = 0;  // value added to the current animation frame for the appropriate armor type in the current animation
    
    //kill assist/finish off addition
    lastDamageDealer = -1;
    lastDamageSource = -1;
    secondToLastDamageDealer = -1;
    
    bubble = instance_create(0,0,SpeechBubbleO);
    bubble.owner = id;

    afk = false;
    
    // Cloak for Spies
    cloak = false;
    cloakAlpha = 1;

    //healer
    healer = -1;
        
    //canGrabIntel- used for droppan intel
    canGrabIntel = true;
    alarm[1] = 0;
    
    //CP
    cappingPoint = noone;
    
    // zoom/scoping function
    // This only affects HUD drawing, so it does not need to be synced at all
    zoomed = false;
    justZoomed = false;     // if we JUST started the zoom this frame
    scopeRelX = 0;          // where the scope is relative to the player
    scopeRelY = 0;
        
    //jugglin'
    //1 for rocket jump
    //2 for rocket juggle
    //3 for getting air blasted
    //4 for friendly juggles!
    moveStatus = 0;
    
    baseControl=0.85;
    // warning that baseFriction cannot be equal to 0 nor 1 or div0 will occur
    baseFriction = 1.15;
    controlFactor = baseControl;
    frictionFactor = baseFriction;
    
    // Let's spawn our weapons and our helmet
    global.paramOwner = id;
    headHelmet = instance_create(x, y, Helmet);
    // Create instances of the default weapons.  If there's a weapon mismatch on join, (i.e. when a new player is serviced)
    // then it will be solved in the FULL_UPDATE that is sent to the player by destroying the wrong weapon
    // and creating the right one
    currentWeapon = 0;      // currentWeapon is now an index for which weapon is active
                            // (in the case of dual-wielding, it will be the weapon that is being held in the right hand, while weapons[2] is the left-hand)
    dualJustDropped = false;    // if the dual-wielded weapon was dropped just now on this frame (used to fix a client-side bug)
    weapons[0] = instance_create(x, y, AssaultRifle);
    weapons[1] = instance_create(x, y, Magnum);
    weapons[2] = noone;     // this array entry holds the weapon being used while dual-wielding
    global.paramOwner = noone;
    
    // if the character belongs to the player, then change the cursor to the reticle
    if (player == global.myself) Cursor.sprite_index = weapons[currentWeapon].reticleSprite;
    
    /***** MEDAL CODE *****/
    // reset the alarm, and both kill counters if this character is the player's
    if (global.myself == player) {
        with (MedalController) {
            alarm[0] = -1;
            multikillCounter = 0;
            spreeCounter = 0;
        }
    }
    /*** END MEDAL CODE ***/
    
    // record of jumping (frames airborne)
    airtime = 0;

    // how freshly-spawned the character is, used for the Have Fun Respawning cheevo
    // decrements each frame
    freshRespawn = 120;
}
