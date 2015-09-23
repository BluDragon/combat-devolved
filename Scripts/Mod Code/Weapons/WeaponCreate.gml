{
    // adjust offsets
    xoffset += sprite_xoffset;
    yoffset += sprite_yoffset;
    
    // adjust barrel offset
    xbarrel -= sprite_xoffset;
    ybarrel -= sprite_yoffset;
    readyToShoot = true;        // you're able to shoot immediately after spawning
    justShot = false;
    
    // frames don't cycle.  this doesn't affect drawing, but we'll do it anyways to make debug slightly easier
    image_speed = 0;
    
    owner = global.paramOwner;
    ownerPlayer = global.paramOwner.player;
    // get the armor color and armor 'frame' from the owner
    armorColor = owner.bodyColor;
    armorFrame = owner.shoulderType;
    
    canGrenade = true;      // if the weapon is compatible with grenade throwing
    
    // Default values for ammo counters (maximum, magazines, etc)
    // Commented out because these should be defined in every weapon anyways
    /*
    maxReserve = 1;  // how much ammo can be held in reserve
    maxAmmo = 1;     // how much ammo can be loaded in
    ammoCount = maxAmmo;        // how much ammo you currently have loaded in
    reserveAmmo = maxReserve;   // how much ammo you currently have in reserve
    */
    
    // default crosshairs and scoping information
    reticleSprite = CrosshairS;
    canZoom = false;
    zoomMaskSprite = -1;
    maxZoomRange = -1;      // maximum zoom range -- if -1 it's equal to the weapon's range
    
    // refire logic
    refireTimeOverflow = 0;     // the non-integer 'overflow' of the current refire time
    currentRefireTime = 0;      // the refire time used for the current fire event
        
    // defaults for damage 
    damage = 0;                 // base damage inflicted on a hit
    shieldDamage = 0;           // shield damage inflicted on a hit
    damageBleeds = true;        // if excessive shield damage will be applied to the HP when shields die
    headshotShield = false;     // if a headshot will insta-kill if shields are down
    headshotKill = false;       // if a headshot will insta-kill regardless
    
    // muzzle jitter and spread
    muzzleJitter = 0;   // the angle to add during jitter (visual only)
    
    // defaults for sounds (i.e. equipping, reloading, melee)
    equipSound = -1;
    reloadSound = -1;
    chargingSound = -1;
    chargedSound = -1;
    ammoPickupSound = -1;
    
    // sound instance IDs
    chargeSoundID = 0;  // instance ID of the sound effect for a charging weapon
    reloadSoundID = 0;  // reloading operations
    
    // defaults for reloading logic
    reloadTime = 1;         // number of frames a reload operation takes
    reloadSingle = false;   // if we reload a single shot for each operation (i.e. shotgun)
                            // reload chains will be called until the gun is full, or the weapon is fired
    reloadInterrupt = false;    // if the current reload operation has been 'interrupted' by a shot firing
                                // (will cause a shot to go off when the operation finishes)
    
    // defaults for weaponfire
    // to disable full-auto, add 'fullAuto = false' to a weapon's creation event after the inherited event
    fullAuto = -1;   // full-auto weapons do not require repeated mouse clicks to fire, defaults to TRUE (-1)
    // defaults for the depth a weapon's drawn when it's "sheathed"
    equipOnBack = false;
    origDepth = depth;
    
    // defaults for weapon charging logic
    chargesUp = false;                  // whether clicking and holding the button will charge the weapon
                                        // or just fire it straight away (normal weapons fire straight away,
                                        // while plasma pistols and spartan lasers, etc. charge up)
    autoFireOnFullCharge = false;       // the weapon will automatically fire/discharge when it hits full charge
                                        // (spartan laser)
    onlyFireOnFullCharge = false;       // the weapon is only capable of firing if it was fully charged
                                        // (spartan laser can only fire when fully charged, plasma pistol anytime)
    chargeLevel = 0;                    // the current level of charge, incremented by 1 each frame
    maxCharge = 0;                      // the maximum charge for the weapon
    
    // defaults for weapon overheating logic
    overheats = false;      // whether the weapon can overheat from rapid use
    overheated = false;     // whether the weapon has overheated and needs to cool down before it can be fired again
    heat = 0;               // the weapon's current heat level
    maxHeat = 0;            // the weapon's max heat level
    
    // defaults for Melee
    canMelee = true;        // if the weapon is capable of a melee operation
    meleeRangeOverride = false;     // if we should override melee default range and use the weapon's max
                                    // this is used by Energy Swords for the primary fire long-range lunge
    meleeHasHit = false;    // if the previous melee operation struck a victim
}
