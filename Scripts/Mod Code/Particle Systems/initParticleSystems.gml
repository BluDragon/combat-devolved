// initializes all the particle systems and global particle types used in the game
// note that this excludes particle types that change their attributes based on other criteria,
// such as the sniper rifle smoke particles, and the single particle used for the laser of the carbine
// as these particles alter their angle based on the direction the gun was pointing when shot
{
    var pType;
    
    // define the global particle systems used for weapon effects
    
    // define the deepest particle system, for particles that must be drawn first
    global.weaponPSLo = part_system_create();
    part_system_depth(global.weaponPSLo, -4);
    
    // define the standard particle system
    global.weaponPS = part_system_create();
    part_system_depth(global.weaponPS, -4);     // drawn above weapons
    //part_system_draw_order(global.weaponPS, false);     // draw new particles above older ones
    
    // point-of-impact particle for the carbine
    pType = part_type_create();
    global.carbinePoiPT = pType;
    part_type_shape(pType, pt_shape_sphere);
    part_type_scale(pType, 0.125, 0.125);
    part_type_color2(pType, make_color_rgb(127, 255, 127), c_lime);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_life(pType, 20, 20);
    
    // Plasma Grenade
    pType = part_type_create();
    global.plasmaGArcPT = pType;
    part_type_sprite(pType, PlasmaGArcsS, true, true, false);
    part_type_life(pType, 12, 12);
    part_type_color2(pType, c_white, make_color_rgb(128, 255, 255));
    
    pType = part_type_create();
    global.plasmaGLinePT = pType;
    part_type_sprite(pType, PlasmaGLineS, true, true, false);
    part_type_life(pType, 5, 9);
    part_type_color2(pType, c_white, make_color_rgb(0, 128, 255));
    part_type_direction(pType, 15, 165, 0, 0);
    part_type_orientation(pType, 0, 0, 0, 0, true);
    part_type_speed(pType, 0, 3, 0, 0);
    
    pType = part_type_create();
    global.plasmaGRingPT = pType;
    part_type_sprite(pType, PlasmaGRingS, true, true, false);
    part_type_life(pType, 14, 14);
    part_type_color3(pType, c_white, make_color_rgb(128, 255, 255), make_color_rgb(0, 128, 255));
    part_type_scale(pType, 1, 0.25);

    pType = part_type_create();
    global.plasmaGSparkPT = pType;
    part_type_shape(pType, pt_shape_pixel);
    part_type_life(pType, 10, 14);
    part_type_direction(pType, 5, 175, 0, 0);
    part_type_speed(pType, 6, 8, 0, 0);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_color3(pType, c_white, make_color_rgb(128, 255, 255), make_color_rgb(0, 128, 255));
    
    // Firebomb Grenade
    pType = part_type_create();
    global.firebombGFlamePT = pType;
    part_type_sprite(pType, FlamePartS, true, false, true);
    part_type_life(pType, 4, 8);
    part_type_scale(pType, 0.5, 0.5);
    part_type_size(pType, 1, 1, -0.02, 0.5);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_blend(pType, true);
    part_type_direction(pType, 90, 90, 0, 0);
    part_type_speed(pType, 2, 4, 0, 0);
    
    // Character immolation
    pType = part_type_create();
    global.characterBurningPT = pType;
    part_type_sprite(pType, FlamePartS, true, false, true);
    part_type_life(pType, 4, 8);
    part_type_scale(pType, 0.5, 0.5);
    part_type_size(pType, 1, 1, -0.02, 0.5);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_blend(pType, true);
    part_type_direction(pType, 90, 90, 0, 0);
    part_type_speed(pType, 2, 4, 0, 0);
    
    // Plasma Pistol Smoke
    pType = part_type_create();
    global.plasmaPistolSmokePT = pType;
    part_type_sprite(pType, PlasmaPistolSmokeS, true, false, true);
    part_type_life(pType, 2, 3);
    part_type_scale(pType, 0.5, 0.5);
    part_type_size(pType, 1, 1, -0.07, 0.7);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_blend(pType, true);
    part_type_direction(pType, 90, 90, 0, 0);
    part_type_speed(pType, 2, 4, 0, 0);
    
    // Plasma Pistol Charge ring
    pType = part_type_create();
    global.plasmaPistolChargeRingPT = pType;
    part_type_sprite(pType, PlasmaPistolRingS, false, false, false);
    part_type_life(pType, 2, 2);
    part_type_scale(pType, 0.25, 0.4);
    part_type_alpha1(pType, 1);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 0, 0);
    
    // Plasma Pistol Charge glow
    pType = part_type_create();
    global.plasmaPistolChargeGlowPT = pType;
    part_type_sprite(pType, PlasmaPistolGlowS, false, false, false);
    part_type_life(pType, 2, 2);
    part_type_scale(pType, 0.33, 0.4);
    part_type_alpha1(pType, 1);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 0, 0);
    
    // Plasma Pistol Charge line
    pType = part_type_create();
    global.plasmaPistolChargeLinePT = pType;
    part_type_sprite(pType, PlasmaPistolLineS, false, false, false);
    part_type_life(pType, 2, 2);
    part_type_scale(pType, 0.2, 0.1);
    part_type_alpha1(pType, 1);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 0, 0);
    
    // Plasma Pistol normal shot POI
    pType = part_type_create();
    global.plasmaPistolNormalPoiPT = pType;
    part_type_shape(pType, pt_shape_sphere);
    part_type_scale(pType, 0.125, 0.125);
    part_type_color2(pType, make_color_rgb(127, 255, 192), make_color_rgb(0, 255, 63));
    part_type_alpha3(pType, 1, 1, 0);
    part_type_life(pType, 3, 5);
    
    // Plasma Rifle POI
    pType = part_type_create();
    global.plasmaRiflePoiPT = pType;
    part_type_shape(pType, pt_shape_sphere);
    part_type_scale(pType, 0.125, 0.125);
    part_type_color2(pType, make_color_rgb(170, 204, 255), make_color_rgb(0, 102, 255));
    part_type_alpha3(pType, 1, 1, 0);
    part_type_life(pType, 3, 5);
    
    // Plasma Rifle Smoke
    pType = part_type_create();
    global.plasmaRifleSmokePT = pType;
    part_type_sprite(pType, PlasmaRifleSmokeS, true, false, true);
    part_type_life(pType, 2, 3);
    part_type_scale(pType, 0.5, 0.5);
    part_type_size(pType, 1, 1, -0.07, 0.7);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_blend(pType, true);
    part_type_direction(pType, 90, 90, 0, 0);
    part_type_speed(pType, 2, 4, 0, 0);
    
    // Fuel Rod Cannon projectile corona
    pType = part_type_create();
    global.fuelRodCannonCoronaPT = pType;
    part_type_sprite(pType, FRCCoronaS, true, false, true);
    part_type_life(pType, 9, 9);
    part_type_scale(pType, 0.8, 0.8);
    part_type_size(pType, 1, 1, -0.07, 0.7);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_blend(pType, true);
    part_type_color2(pType, make_color_rgb(17, 238, 128), make_color_rgb(21, 234, 186));
    
    // Fuel Rod Cannon projectile 'pixels'
    pType = part_type_create();
    global.fuelRodCannonPixelPT = pType;
    part_type_shape(pType, pt_shape_pixel);
    part_type_life(pType, 8, 8);
    part_type_scale(pType, 1, 1);
    part_type_size(pType, 1, 1, -0.07, 0);
    part_type_blend(pType, true);
    part_type_color2(pType, make_color_rgb(17, 238, 128), make_color_rgb(21, 234, 186));
    part_type_direction(pType, 0, 360, 0, 0);
    part_type_speed(pType, 0.5, 1.5, 0, 0);
    
    // Fuel Rod Cannon blast flare
    pType = part_type_create();
    global.fuelRodCannonFlarePT = pType;
    part_type_sprite(pType, FRCFlareS, false, false, false);
    part_type_life(pType, 3, 3);
    part_type_scale(pType, 2, 2);
    part_type_size(pType, 1.1, 0.8, -0.2, 0);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 0, false);
    
    // Fuel Rod Cannon blast smoke
    pType = part_type_create();
    global.fuelRodCannonSmokePT = pType;
    part_type_sprite(pType, SmokeBurstS, true, true, false);
    part_type_life(pType, 18, 24);
    part_type_scale(pType, 1, 1);
    part_type_size(pType, 0.8, 1.2, 0, 0);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 0, false);
    part_type_color2(pType, make_color_rgb(17, 238, 128), make_color_rgb(21, 234, 186));
    part_type_alpha3(pType, 1, 0.8, 0.4);
    
    // Fuel Rod Cannon blast sparks
    pType = part_type_create();
    global.fuelRodCannonSparkPT = pType;
    part_type_sprite(pType, FRCSparksS, true, false, true);
    part_type_life(pType, 18, 24);
    part_type_scale(pType, 3, 3);
    part_type_size(pType, 0.8, 1.2, -0.02, 0);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 0, false);
    part_type_color2(pType, make_color_rgb(17, 238, 128), make_color_rgb(21, 234, 186));
    part_type_alpha3(pType, 1, 1, 0.5);
    
    // Fuel Rod Cannon blast pixels
    pType = part_type_create();
    global.fuelRodCannonBlastPixelPT = pType;
    part_type_shape(pType, pt_shape_pixel);
    part_type_life(pType, 18, 24);
    part_type_scale(pType, 1, 1);
    part_type_size(pType, 1, 1, -0.02, 0);
    part_type_blend(pType, true);
    part_type_alpha3(pType, 1, 1, 0.5);
    part_type_color2(pType, make_color_rgb(185, 255, 220), make_color_rgb(10, 226, 123));
    part_type_direction(pType, 0, 360, 0, 0);
    part_type_speed(pType, 1, 2, 0, 0);
    
    // Spartan Laser flare
    pType = part_type_create();
    global.spartanLaserFlarePT = pType;
    part_type_sprite(pType, SpartanLaserFlareS, false, false, false);
    part_type_life(pType, 17, 20);
    part_type_scale(pType, 1, 1);
    part_type_size(pType, 1.1, 0.8, -0.02, 0);
    part_type_blend(pType, true);
    part_type_alpha3(pType, 1, 0.7, 0.2);
    part_type_orientation(pType, 0, 360, 0, 0, false);
    
    // Spartan Laser blast lines
    pType = part_type_create();
    global.spartanLaserLinePT = pType;
    part_type_sprite(pType, SpartanLaserLineS, false, false, false);
    part_type_life(pType, 5, 6);
    part_type_scale(pType, 0.4, 0.2);
    part_type_alpha1(pType, 1);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 0, 0, 0, true);
    part_type_speed(pType, 3, 5, 0, 0);
    part_type_direction(pType, 0, 360, 0, 0);
    
    // Spartan Laser blast pixels
    pType = part_type_create();
    global.spartanLaserBlastPixelPT = pType;
    part_type_shape(pType, pt_shape_pixel);
    part_type_life(pType, 8, 9);
    part_type_scale(pType, 1, 1);
    part_type_size(pType, 1, 1, -0.02, 0);
    part_type_blend(pType, true);
    part_type_alpha3(pType, 1, 1, 0.5);
    part_type_color2(pType, make_color_rgb(255, 149, 149), make_color_rgb(255, 0, 0));
    part_type_direction(pType, 0, 360, 0, 0);
    part_type_speed(pType, 4, 6, 0, 0);
    
    // Rocket Launcher smoke trail
    pType = part_type_create();
    global.rocketSmokeTrailPT = pType;
    part_type_sprite(pType, SmokeBallS, true, false, true);
    part_type_life(pType, 25, 35);
    part_type_scale(pType, 0.6, 0.6);
    part_type_alpha3(pType, 0.7, 0.5, 0);
    part_type_color3(pType, make_color_rgb(63, 63, 63), make_color_rgb(75, 75, 75), make_color_rgb(98, 98, 98));
    part_type_orientation(pType, 0, 360, 0, 0, 0);
    
    // Single Needle pop
    pType = part_type_create();
    global.needlePopPT = pType;
    part_type_sprite(pType, NeedlePopS, false, false, false);
    part_type_life(pType, 3, 3);
    part_type_scale(pType, 1, 1);
    part_type_alpha1(pType, 1);
    part_type_orientation(pType, 0, 360, 0, 0, 0);
    part_type_size(pType, 1, 1, 0.25, 0);
    
    // Needle Burst line
    pType = part_type_create();
    global.needleBurstLinePT = pType;
    part_type_sprite(pType, NeedleBurstLineS, false, false, false);
    part_type_life(pType, 4, 4);
    part_type_scale(pType, 1, 0.8);
    part_type_alpha1(pType, 1);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 0, false);
    part_type_size(pType, 1, 1, -0.2, 0);
    
    // Needle Burst initial flash
    pType = part_type_create();
    global.needleBurstFlashPT = pType;
    part_type_sprite(pType, SmokeBlobS, true, false, true);
    part_type_life(pType, 4, 5);
    part_type_scale(pType, 0.8, 0.8);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_blend(pType, true);
    part_type_color1(pType, make_color_rgb($C9, $8B, $DC));
    part_type_orientation(pType, 0, 360, 0, 0, false);
    part_type_size(pType, 1, 1, 0.2, false);
    
    // Needle Burst smoke
    pType = part_type_create();
    global.needleBurstSmokePT = pType;
    part_type_sprite(pType, SmokeBurstS, true, true, false);
    part_type_life(pType, 13, 16);
    part_type_scale(pType, 0.8, 0.8);
    part_type_alpha3(pType, 0.6, 1, 0.5);
    part_type_blend(pType, true);
    part_type_color2(pType, make_color_rgb($D6, $94, $E2), make_color_rgb(58, 36, 255));
    part_type_orientation(pType, 0, 360, 0, 0, false);
    
    // Brute Shot smoke trail
    pType = part_type_create();
    global.bruteSmokeTrailPT = pType;
    part_type_sprite(pType, SmokeBallS, true, false, true);
    part_type_life(pType, 8, 12);
    part_type_scale(pType, 0.4, 0.4);
    part_type_alpha2(pType, 0.5, 0);
    part_type_color1(pType, make_color_rgb(255, 241, 160));
    part_type_orientation(pType, 0, 360, 0, 0, 0);
    
    // Brute Shot flare
    pType = part_type_create();
    global.bruteBlastFlarePT = pType;
    part_type_sprite(pType, BruteBlastFlareS, false, false, false);
    part_type_life(pType, 3, 3);
    part_type_scale(pType, 2, 2);
    part_type_size(pType, 1.1, 0.8, -0.2, 0);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 0, false);
    
    // Brute Shot line
    pType = part_type_create();
    global.bruteBlastLinePT = pType;
    part_type_sprite(pType, BruteBlastLineS, false, false, false);
    part_type_life(pType, 3, 4);
    part_type_scale(pType, 0.4, 0.2);
    part_type_alpha1(pType, 1);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 0, 0, 0, true);
    part_type_speed(pType, 3, 5, 0, 0);
    part_type_direction(pType, 0, 360, 0, 0);
    
    // Brute Shot pixels
    pType = part_type_create();
    global.bruteBlastPixelPT = pType;
    part_type_shape(pType, pt_shape_pixel);
    part_type_life(pType, 7, 8);
    part_type_scale(pType, 1, 1);
    part_type_size(pType, 1, 1, -0.02, 0);
    part_type_blend(pType, true);
    part_type_alpha3(pType, 1, 1, 0.5);
    part_type_color2(pType, make_color_rgb(255, 241, 160), make_color_rgb(200, 200, 0));
    part_type_direction(pType, 0, 360, 0, 0);
    part_type_speed(pType, 3.5, 5.2, 0, 0);
    
    // Brute Shot blast smoke
    pType = part_type_create();
    global.bruteBlastSmokePT = pType;
    part_type_sprite(pType, BruteBlastSmokeS, true, false, true);
    part_type_life(pType, 19, 26);
    part_type_scale(pType, 1, 1);
    part_type_alpha3(pType, 1, 0.7, 0.2);
    part_type_color1(pType, make_color_rgb(64, 64, 64));
    part_type_orientation(pType, 0, 360, 0, 0, false);
    part_type_direction(pType, 0, 360, 0, 4);
    part_type_speed(pType, 0.5, 1.5, 0, 0);
    
    // Brute Shot fireball
    pType = part_type_create();
    global.bruteBlastFirePT = pType;
    part_type_sprite(pType, FlamePartS, true, false, true);
    part_type_life(pType, 7, 9);
    part_type_scale(pType, 0.65, 0.65);
    part_type_size(pType, 1, 1, -0.02, 0.5);
    part_type_alpha3(pType, 1, 0.7, 0);
    part_type_blend(pType, true);
    part_type_direction(pType, 0, 360, 0, 4);
    part_type_speed(pType, 1.2, 1.8, 0, 0);
    
    // Brute Shot sparks
    pType = part_type_create();
    global.bruteBlastSparksPT = pType;
    part_type_sprite(pType, BruteBlastSparksS, true, true, false);
    part_type_life(pType, 7, 9);
    part_type_scale(pType, 1.8, 1.8);
    part_type_size(pType, 0.7, 1, 0.1, 0);
    part_type_alpha3(pType, 1, 0.8, 0);
    part_type_blend(pType, true);
    part_type_orientation(pType, 0, 360, 0, 4, false);
    
    // Spike Grenade puff trail
    pType = part_type_create();
    global.spikeGPuffTrailPT = pType;
    part_type_sprite(pType, SmokeBallS, true, false, true);
    part_type_life(pType, 6, 10);
    part_type_scale(pType, 0.4, 0.4);
    part_type_alpha3(pType, 0.7, 0.5, 0);
    part_type_color1(pType, make_color_rgb(107, 106, 89));
    part_type_orientation(pType, 0, 360, 0, 0, 0);
    
    // Beam Rifle smoke
    pType = part_type_create();
    global.beamRifleSmokePT = pType;
    part_type_sprite(pType, BeamRifleSmokeS, true, false, true);
    part_type_life(pType, 2, 3);
    part_type_scale(pType, 0.5, 0.5);
    part_type_size(pType, 1, 1, -0.07, 0.7);
    part_type_alpha3(pType, 1, 1, 0);
    part_type_blend(pType, true);
    part_type_direction(pType, 90, 90, 0, 0);
    part_type_speed(pType, 2, 4, 0, 0);
}
