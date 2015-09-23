/* Initializes all the GLOBAL/static weapon data (mostly stuff needed for weapon drops)
**
** weaponObject = the object index of the weapon
** weaponMaxReserve = how much ammo you can have in reserve
** weaponMaxAmmo = how much ammo you can have loaded in
** weaponDropSprite = sprite index of a weapon drop
** weaponHudIcon = sprite index of weapon's HUD icon
** weaponDualWield = whether the weapon can be dual-wielded
** weaponHeavyWield = whether the weapon is treated as heavy or not
*/
{
    var i;
    
    global.dualWieldReloadFactor = 1.85;    // reload penalty factor for dual-wielded weapons
    global.dualWieldDamageFactor = 0.75;    // damage penalty factor for dual-wielded weapons
    global.dualWieldSpreadFactor = 1.2;     // spread penalty factor for dual-wielded weapons
    
    /********* RIFLES *********/
    
    i = WEAPON_ASSAULTRIFLE;
    global.weaponObject[i] = AssaultRifle;
    global.weaponMaxReserve[i] = 320;
    global.weaponMaxAmmo[i] = 32;
    global.weaponDropSprite[i] = AssaultRifleDropS;
    global.weaponHudIcon[i] = AssaultRifleIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_BATTLERIFLE;
    global.weaponObject[i] = BattleRifle;
    global.weaponMaxReserve[i] = 108;
    global.weaponMaxAmmo[i] = 36;
    global.weaponDropSprite[i] = BattleRifleDropS;
    global.weaponHudIcon[i] = BattleRifleIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_BEAMRIFLE;
    global.weaponObject[i] = BeamRifle;
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 1000;
    global.weaponDropSprite[i] = BeamRifleDropS;
    global.weaponHudIcon[i] = BeamRifleIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_CARBINE;
    global.weaponObject[i] = Carbine;
    global.weaponMaxReserve[i] = 72;
    global.weaponMaxAmmo[i] = 18;
    global.weaponDropSprite[i] = CarbineDropS;
    global.weaponHudIcon[i] = CarbineIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_SHOTGUN;
    global.weaponObject[i] = Shotgun;
    global.weaponMaxReserve[i] = 30;
    global.weaponMaxAmmo[i] = 6;
    global.weaponDropSprite[i] = ShotgunDropS;
    global.weaponHudIcon[i] = ShotgunIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_SNIPERRIFLE;
    global.weaponObject[i] = SniperRifle;
    global.weaponMaxReserve[i] = 16;
    global.weaponMaxAmmo[i] = 4;
    global.weaponDropSprite[i] = SniperRifleDropS;
    global.weaponHudIcon[i] = SniperRifleIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    /********* HANDGUNS *********/
    
    i = WEAPON_MAGNUM;
    global.weaponObject[i] = Magnum;
    global.weaponMaxReserve[i] = 40;
    global.weaponMaxAmmo[i] = 8;
    global.weaponDropSprite[i] = MagnumDropS;
    global.weaponHudIcon[i] = MagnumIconS;
    global.weaponDualWield[i] = true;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_MAULER;
    global.weaponObject[i] = Mauler;
    global.weaponMaxReserve[i] = 15;
    global.weaponMaxAmmo[i] = 5;
    global.weaponDropSprite[i] = MaulerDropS;
    global.weaponHudIcon[i] = MaulerIconS;
    global.weaponDualWield[i] = true;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_PLASMAPISTOL;
    global.weaponObject[i] = PlasmaPistol;
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 1000;
    global.weaponDropSprite[i] = PlasmaPistolDropS;
    global.weaponHudIcon[i] = PlasmaPistolIconS;
    global.weaponDualWield[i] = true;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_SPIKER;
    global.weaponObject[i] = Spiker;
    global.weaponMaxReserve[i] = 120;
    global.weaponMaxAmmo[i] = 40;
    global.weaponDropSprite[i] = SpikerDropS;
    global.weaponHudIcon[i] = SpikerIconS;
    global.weaponDualWield[i] = true;
    global.weaponHeavyWield[i] = false;
    
    /********* SUB-MACHINE GUNS *********/
    
    i = WEAPON_NEEDLER;
    global.weaponObject[i] = Needler;
    global.weaponMaxReserve[i] = 76;
    global.weaponMaxAmmo[i] = 19;
    global.weaponDropSprite[i] = NeedlerDropS;
    global.weaponHudIcon[i] = NeedlerIconS;
    global.weaponDualWield[i] = true;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_PLASMARIFLE;
    global.weaponObject[i] = PlasmaRifle;
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 200;
    global.weaponDropSprite[i] = PlasmaRifleDropS;
    global.weaponHudIcon[i] = PlasmaRifleIconS;
    global.weaponDualWield[i] = true;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_SMG;
    global.weaponObject[i] = SMG;
    global.weaponMaxReserve[i] = 180;
    global.weaponMaxAmmo[i] = 60;
    global.weaponDropSprite[i] = SMGDropS;
    global.weaponHudIcon[i] = SMGIconS;
    global.weaponDualWield[i] = true;
    global.weaponHeavyWield[i] = false;
    
    /********* SHOULDER-MOUNTED *********/
    
    i = WEAPON_FUELRODCANNON;
    global.weaponObject[i] = FuelRodCannon;
    global.weaponMaxReserve[i] = 25;
    global.weaponMaxAmmo[i] = 5;
    global.weaponDropSprite[i] = FuelRodCannonDropS;
    global.weaponHudIcon[i] = FuelRodCannonIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_ROCKETLAUNCHER;
    global.weaponObject[i] = RocketLauncher;
    global.weaponMaxReserve[i] = 6;
    global.weaponMaxAmmo[i] = 2;
    global.weaponDropSprite[i] = RocketLauncherDropS;
    global.weaponHudIcon[i] = RocketLauncherIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_SPARTANLASER;
    global.weaponObject[i] = SpartanLaser;
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 100;
    global.weaponDropSprite[i] = SpartanLaserDropS;
    global.weaponHudIcon[i] = SpartanLaserIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    /********* HEAVY WEAPONS *********/
    i = WEAPON_BRUTESHOT;
    global.weaponObject[i] = BruteShot;
    global.weaponMaxReserve[i] = 12;
    global.weaponMaxAmmo[i] = 6;
    global.weaponDropSprite[i] = BruteShotDropS;
    global.weaponHudIcon[i] = BruteShotIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_FLAMETHROWER;
    global.weaponObject[i] = Flamethrower;
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 100;
    global.weaponDropSprite[i] = FlamethrowerDropS;
    global.weaponHudIcon[i] = FlamethrowerIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = true;
    
    /********* MELEE *********/
    
    i = WEAPON_ENERGYSWORD;
    global.weaponObject[i] = EnergySword;
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 100;
    global.weaponDropSprite[i] = EnergySwordDropS;
    global.weaponHudIcon[i] = EnergySwordIconS;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    /********* GRENADES *********/
    // This is here for special-case use with weapon drops
    
    i = WEAPON_PLASMAGRENADE;
    global.weaponObject[i] = -1;
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 2;
    global.weaponDropSprite[i] = PlasmaGrenadeDropS;
    global.weaponHudIcon[i] = -1;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_FRAGGRENADE;
    global.weaponObject[i] = -1
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 2;
    global.weaponDropSprite[i] = FragGrenadeDropS;
    global.weaponHudIcon[i] = -1;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_FIREBOMB;
    global.weaponObject[i] = -1
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 2;
    global.weaponDropSprite[i] = FirebombDropS;
    global.weaponHudIcon[i] = -1;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
    
    i = WEAPON_SPIKEGRENADE;
    global.weaponObject[i] = -1
    global.weaponMaxReserve[i] = 0;
    global.weaponMaxAmmo[i] = 2;
    global.weaponDropSprite[i] = SpikeGrenadeDropS;
    global.weaponHudIcon[i] = -1;
    global.weaponDualWield[i] = false;
    global.weaponHeavyWield[i] = false;
}
