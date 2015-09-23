// Loads all the sounds into the FMOD system (not including the BGM music loaded in the 'loadMusic' script)

// Returns TRUE if there were no problems, FALSE if there were
{
    var ok;
    ok = true;  // whether the previous load operation was ok, to prevent the cascade of error messages if there's an error while loading

    // first, load all the standard BGM, set their volume to full and their groups to 3 (BGM)
    global.MenuMusic = FMODSoundAdd("Music\Halo Menu Music.mp3", false, true);
    FMODSoundSetGroup(global.MenuMusic, 3);
    FMODSoundSetMaxVolume(global.MenuMusic, 1);
    
    global.FaucetMusic = FMODSoundAdd("Music\plasma grenade.mp3", false, true);
    FMODSoundSetGroup(global.FaucetMusic, 3);
    FMODSoundSetMaxVolume(global.FaucetMusic, 1);
    
    // load any MP3 files in the music directory
    loadMusic();
    
    // Load all the standard sound effects and voice clips
    
    /***** root directory *****/
    if (ok) ok = loadSound("AchievementSnd", "AchievementSnd.ogg", false, 2);
    if (ok) ok = loadSound("BlueChaingunSnd", "BlueChaingunSnd.ogg", false, 2);
    if (ok) ok = loadSound("CbntHealSnd", "CbntHealSnd.ogg", false, 2);
    if (ok) ok = loadSound("ChaingunSnd", "ChaingunSnd.ogg", false, 2);
    if (ok) ok = loadSound("CountDown1Snd", "CountDown1Snd.ogg", false, 2);
    if (ok) ok = loadSound("CountDown2Snd", "CountDown2Snd.ogg", false, 2);
    if (ok) ok = loadSound("CPBeginCapSnd", "CPBeginCapSnd.ogg", false, 2);
    if (ok) ok = loadSound("CPCapturedSnd", "CPCapturedSnd.ogg", false, 2);
    if (ok) ok = loadSound("CPDefendedSnd", "CPDefendedSnd.ogg", false, 2);
    if (ok) ok = loadSound("CPLostSnd", "CPLostSnd.ogg", false, 2);
    if (ok) ok = loadSound("ExplosionSnd", "ExplosionSnd.ogg", false, 2);
    if (ok) ok = loadSound("FailureSnd", "FailureSnd.ogg", false, 2);
    if (ok) ok = loadSound("FlamethrowerSnd", "FlamethrowerSnd.ogg", false, 2);
    if (ok) ok = loadSound("FusionCoilSnd", "FusionCoilExplode.ogg", false, 2);
    if (ok) ok = loadSound("HammerSwingSnd", "HammerSwingSnd.ogg", false, 2);
    if (ok) ok = loadSound("IntelDropSnd", "IntelDropSnd.ogg", false, 2);
    if (ok) ok = loadSound("IntelGetSnd", "IntelGetSnd.ogg", false, 2);
    if (ok) ok = loadSound("IntelPutSnd", "IntelPutSnd.ogg", false, 2);
    if (ok) ok = loadSound("IntelResetSnd", "IntelResetSnd.ogg", false, 2);
    if (ok) ok = loadSound("MedigunSnd", "MedigunSnd.ogg", false, 2);
    if (ok) ok = loadSound("OneMinLeftSnd", "OneMinLeftSnd.ogg", false, 2);
    if (ok) ok = loadSound("PickupSnd", "PickupSnd.ogg", false, 2);
    if (ok) ok = loadSound("RespawnSnd", "RespawnSnd.ogg", false, 2);
    if (ok) ok = loadSound("SentryBuildSnd", "SentryBuildSnd.ogg", false, 2);
    if (ok) ok = loadSound("SentryFloorSnd", "SentryFloorSnd.ogg", false, 2);
    if (ok) ok = loadSound("SentryIdleSnd", "SentryIdle.ogg", false, 2);
    if (ok) ok = loadSound("SirenSnd", "SirenSnd.ogg", false, 2);
    if (ok) ok = loadSound("TenSecondsLeftSnd", "TenSecondsLeftSnd.ogg", false, 2);
    if (ok) ok = loadSound("ThirtySecondsLeftSnd", "ThirtySecondsLeftSnd.ogg", false, 2);
    if (ok) ok = loadSound("VictorySnd", "VictorySnd.ogg", false, 2);
    
    /***** Characters\Deaths\ *****/
    if (ok) ok = loadSound("DeathSnd1", "Characters\Deaths\Death1.ogg", false, 2);
    if (ok) ok = loadSound("DeathSnd2", "Characters\Deaths\Death2.ogg", false, 2);
    if (ok) ok = loadSound("DeathSnd3", "Characters\Deaths\Death3.ogg", false, 2);
    if (ok) ok = loadSound("DeathSnd4", "Characters\Deaths\Death4.ogg", false, 2);
    if (ok) ok = loadSound("DeathSnd5", "Characters\Deaths\Death5.ogg", false, 2);
    if (ok) ok = loadSound("MeleeDeathSnd1", "Characters\Deaths\MeleeDeath1.ogg", false, 2);
    if (ok) ok = loadSound("MeleeDeathSnd2", "Characters\Deaths\MeleeDeath2.ogg", false, 2);
    if (ok) ok = loadSound("MeleeDeathSnd3", "Characters\Deaths\MeleeDeath3.ogg", false, 2);
    if (ok) ok = loadSound("MeleeDeathSnd4", "Characters\Deaths\MeleeDeath4.ogg", false, 2);
    
    /***** Characters\Movement\ *****/
    // NOTE: Footfalls have minimum group priority
    if (ok) ok = loadSound("FootstepSnd1", "Characters\Movement\Footstep1.ogg", false, 4);
    if (ok) ok = loadSound("FootstepSnd2", "Characters\Movement\Footstep2.ogg", false, 4);
    if (ok) ok = loadSound("FootstepSnd3", "Characters\Movement\Footstep3.ogg", false, 4);
    if (ok) ok = loadSound("FootstepSnd4", "Characters\Movement\Footstep4.ogg", false, 4);
    if (ok) ok = loadSound("FootstepSnd5", "Characters\Movement\Footstep5.ogg", false, 4);
    if (ok) ok = loadSound("Landing1Snd", "Characters\Movement\Landing1.ogg", false, 2);
    if (ok) ok = loadSound("Landing2Snd", "Characters\Movement\Landing2.ogg", false, 2);
    if (ok) ok = loadSound("Landing3Snd", "Characters\Movement\Landing3.ogg", false, 2);
    if (ok) ok = loadSound("StopAndTurnSnd", "Characters\Movement\StopAndTurn.ogg", false, 4);
    
    /***** Shields\ *****/
    if (ok) ok = loadSound("ShieldsLowSnd", "Shields\ShieldsLow.ogg", false, 2);
    if (ok) ok = loadSound("ShieldsOffSnd", "Shields\ShieldsOff.ogg", false, 2);
    if (ok) ok = loadSound("ShieldsRechargeSnd", "Shields\ShieldsRecharge.ogg", false, 2);
    
    /***** Weapons\Equip\ *****/
    if (ok) ok = loadSound("AssaultRifleEquipSnd", "Weapons\Equip\AssaultRifleEquip.ogg", false, 2);
    if (ok) ok = loadSound("BattleRifleEquipSnd", "Weapons\Equip\BattleRifleEquip.ogg", false, 2);
    if (ok) ok = loadSound("BeamRifleEquipSnd", "Weapons\Equip\BeamRifleEquip.ogg", false, 2);
    if (ok) ok = loadSound("BruteShotEquipSnd", "Weapons\Equip\BruteShotEquip.ogg", false, 2);
    if (ok) ok = loadSound("CarbineEquipSnd", "Weapons\Equip\CarbineEquip.ogg", false, 2);
    if (ok) ok = loadSound("EnergySwordEquipSnd", "Weapons\Equip\EnergySwordEquip.ogg", false, 2);
    if (ok) ok = loadSound("FlamethrowerEquipSnd", "Weapons\Equip\FlamethrowerEquip.ogg", false, 2);
    if (ok) ok = loadSound("FuelRodCannonEquipSnd", "Weapons\Equip\FuelRodCannonEquip.ogg", false, 2);
    if (ok) ok = loadSound("MagnumEquipSnd", "Weapons\Equip\MagnumEquip.ogg", false, 2);
    if (ok) ok = loadSound("MaulerEquipSnd", "Weapons\Equip\MaulerEquip.ogg", false, 2);
    if (ok) ok = loadSound("NeedlerEquipSnd", "Weapons\Equip\NeedlerEquip.ogg", false, 2);
    if (ok) ok = loadSound("RocketLauncherEquipSnd", "Weapons\Equip\RocketLauncherEquip.ogg", false, 2);
    if (ok) ok = loadSound("ShotgunEquipSnd", "Weapons\Equip\ShotgunEquip.ogg", false, 2);
    if (ok) ok = loadSound("SMGEquipSnd", "Weapons\Equip\SMGEquip.ogg", false, 2);
    if (ok) ok = loadSound("SpartanLaserEquipSnd", "Weapons\Equip\SpartanLaserEquip.ogg", false, 2);
    if (ok) ok = loadSound("SpikerEquipSnd", "Weapons\Equip\SpikerEquip.ogg", false, 2);
    
    /***** Weapons\Fire\ *****/
    if (ok) ok = loadSound("AssaultRifleSnd", "Weapons\Fire\AssaultRifleFire.ogg", false, 2);
    if (ok) ok = loadSound("BattleRifleSnd", "Weapons\Fire\BattleRifleFire.ogg", false, 2);
    if (ok) ok = loadSound("BeamRifleCooldownSnd", "Weapons\Fire\BeamRifleCooldown.ogg", false, 2);
    if (ok) ok = loadSound("BeamRifleSnd", "Weapons\Fire\BeamRifleFire.ogg", false, 2);
    if (ok) ok = loadSound("BruteShotSnd", "Weapons\Fire\BruteShotFire.ogg", false, 2);
    if (ok) ok = loadSound("CarbineSnd", "Weapons\Fire\CarbineFire.ogg", false, 2);
    if (ok) ok = loadSound("EnergySwordSnd", "Weapons\Fire\EnergySwordFire.ogg", false, 2);
    if (ok) ok = loadSound("FuelRodCannonSnd", "Weapons\Fire\FuelRodCannonFire.ogg", false, 2);
    if (ok) ok = loadSound("MagnumSnd", "Weapons\Fire\MagnumFire.ogg", false, 2);
    if (ok) ok = loadSound("MaulerSnd", "Weapons\Fire\MaulerFire.ogg", false, 2);
    if (ok) ok = loadSound("NeedlerSnd", "Weapons\Fire\NeedlerFire.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaPistolChargedSnd", "Weapons\Fire\PlasmaPistolCharged.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaPistolChargedShotSnd", "Weapons\Fire\PlasmaPistolChargedShot.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaPistolChargingSnd", "Weapons\Fire\PlasmaPistolCharging.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaPistolNormalCooldownSnd", "Weapons\Fire\PlasmaPistolNormalCooldown.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaPistolNormalShotSnd", "Weapons\Fire\PlasmaPistolNormalShot.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaRifleCooldownSnd", "Weapons\Fire\PlasmaRifleCooldown.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaRifleSnd", "Weapons\Fire\PlasmaRifleFire.ogg", false, 2);
    if (ok) ok = loadSound("RocketLauncherSnd", "Weapons\Fire\RocketLauncherFire.ogg", false, 2);
    if (ok) ok = loadSound("ShotgunSnd", "Weapons\Fire\ShotgunFire.ogg", false, 2);
    if (ok) ok = loadSound("SMGSnd", "Weapons\Fire\SMGFire.ogg", false, 2);
    if (ok) ok = loadSound("SniperRifleSnd", "Weapons\Fire\SniperRifleFire.ogg", false, 2);
    if (ok) ok = loadSound("SpartanLaserChargingSnd", "Weapons\Fire\SpartanLaserCharging.ogg", false, 2);
    if (ok) ok = loadSound("SpartanLaserSnd", "Weapons\Fire\SpartanLaserFire.ogg", false, 2);
    if (ok) ok = loadSound("SpikerSnd", "Weapons\Fire\SpikerFire.ogg", false, 2);
    
    /***** Weapons\Grenades\ *****/
    if (ok) ok = loadSound("FirebombExplosionSnd", "Weapons\Grenades\FirebombExplosion.ogg", false, 2);
    if (ok) ok = loadSound("FirebombThrowSnd", "Weapons\Grenades\FirebombThrow.ogg", false, 2);
    if (ok) ok = loadSound("FragGrenadeBlastSnd", "Weapons\Grenades\FragGrenadeBlast.ogg", false, 2);
    if (ok) ok = loadSound("FragGrenadeBounceSnd", "Weapons\Grenades\FragGrenadeBounce.ogg", false, 2);
    if (ok) ok = loadSound("FragGrenadeThrowSnd", "Weapons\Grenades\FragGrenadeThrow.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaGrenadeArmedSnd", "Weapons\Grenades\PlasmaGrenadeArmed.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaGrenadeSizzleSnd", "Weapons\Grenades\PlasmaGrenadeSizzle.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaGrenadeThrowSnd", "Weapons\Grenades\PlasmaGrenadeThrow.ogg", false, 2);
    if (ok) ok = loadSound("SpikeGrenadeArmedSnd", "Weapons\Grenades\SpikeGrenadeArmed.ogg", false, 2);
    if (ok) ok = loadSound("SpikeGrenadeSizzleSnd", "Weapons\Grenades\SpikeGrenadeSizzle.ogg", false, 2);
    if (ok) ok = loadSound("SpikeGrenadeThrowSnd", "Weapons\Grenades\SpikeGrenadeThrow.ogg", false, 2);
    
    /***** Weapons\Misc\ *****/
    if (ok) ok = loadSound("BladedSwingSnd", "Weapons\Misc\BladedSwing.ogg", false, 2);
    if (ok) ok = loadSound("CarbineZoomInSnd", "Weapons\Misc\CarbineZoomIn.ogg", false, 2);
    if (ok) ok = loadSound("CarbineZoomOutSnd", "Weapons\Misc\CarbineZoomOut.ogg", false, 2);
    if (ok) ok = loadSound("EnergySwordHitSnd", "Weapons\Misc\EnergySwordHit.ogg", false, 2);
    if (ok) ok = loadSound("EnergySwordMeleeSnd", "Weapons\Misc\EnergySwordMelee.ogg", false, 2);
    if (ok) ok = loadSound("MeleeBody1Snd", "Weapons\Misc\MeleeBody1.ogg", false, 2);
    if (ok) ok = loadSound("MeleeBody2Snd", "Weapons\Misc\MeleeBody2.ogg", false, 2);
    if (ok) ok = loadSound("MeleeSwingSnd", "Weapons\Misc\MeleeSwing.ogg", false, 2);
    if (ok) ok = loadSound("NoAmmoClickSnd", "Weapons\Misc\NoAmmoClick.ogg", false, 2);
    if (ok) ok = loadSound("SniperZoomInSnd", "Weapons\Misc\SniperZoomIn.ogg", false, 2);
    if (ok) ok = loadSound("SniperZoomOutSnd", "Weapons\Misc\SniperZoomOut.ogg", false, 2);
    
    /***** Weapons\Pickups\ *****/
    if (ok) ok = loadSound("BattleRifleAmmoSnd", "Weapons\Pickups\BattleRifleAmmo.ogg", false, 2);
    if (ok) ok = loadSound("BruteShotAmmoSnd", "Weapons\Pickups\BruteShotAmmo.ogg", false, 2);
    if (ok) ok = loadSound("CarbineAmmoSnd", "Weapons\Pickups\CarbineAmmo.ogg", false, 2);
    if (ok) ok = loadSound("FragGrenadeAmmoSnd", "Weapons\Pickups\FragGrenadeAmmo.ogg", false, 2);
    if (ok) ok = loadSound("MagnumAmmoSnd", "Weapons\Pickups\MagnumAmmo.ogg", false, 2);
    if (ok) ok = loadSound("MaulerAmmoSnd", "Weapons\Pickups\MaulerAmmo.ogg", false, 2);
    if (ok) ok = loadSound("NeedlerAmmoSnd", "Weapons\Pickups\NeedlerAmmo.ogg", false, 2);
    if (ok) ok = loadSound("PlasmaGrenadeAmmoSnd", "Weapons\Pickups\PlasmaGrenadeAmmo.ogg", false, 2);
    if (ok) ok = loadSound("RocketLauncherAmmoSnd", "Weapons\Pickups\RocketLauncherAmmo.ogg", false, 2);
    if (ok) ok = loadSound("ShotgunAmmoSnd", "Weapons\Pickups\ShotgunAmmo.ogg", false, 2);
    if (ok) ok = loadSound("SMGAmmoSnd", "Weapons\Pickups\SMGAmmo.ogg", false, 2);
    if (ok) ok = loadSound("SniperRifleAmmoSnd", "Weapons\Pickups\SniperRifleAmmo.ogg", false, 2);
    if (ok) ok = loadSound("SpikerAmmoSnd", "Weapons\Pickups\SpikerAmmo.ogg", false, 2);
    
    /***** Weapons\Projectiles\ *****/
    if (ok) ok = loadSound("BruteShotExplodeSnd", "Weapons\Projectiles\BruteShotExplode.ogg", false, 2);
    if (ok) ok = loadSound("FuelRodCannonExplodeSnd", "Weapons\Projectiles\FuelRodCannonExplode.ogg", false, 2);
    if (ok) ok = loadSound("NeedlePopSnd", "Weapons\Projectiles\NeedlePop.ogg", false, 2);
    if (ok) ok = loadSound("NeedlerExplodeSnd", "Weapons\Projectiles\NeedlerExplode.ogg", false, 2);
    if (ok) ok = loadSound("NeedleRicochetSnd", "Weapons\Projectiles\NeedleRicochet.ogg", false, 4);    // low priority
    if (ok) ok = loadSound("NeedleStickSnd", "Weapons\Projectiles\NeedleStick.ogg", false, 4);          // low priority
    if (ok) ok = loadSound("RocketFlybySnd", "Weapons\Projectiles\RocketFlyby.ogg", false, 2);
    if (ok) ok = loadSound("RocketLauncherExplodeSnd", "Weapons\Projectiles\RocketLauncherExplode.ogg", false, 2);
    
    /***** Weapons\Reload\ *****/
    if (ok) ok = loadSound("AssaultRifleReloadSnd", "Weapons\Reload\AssaultRifleReload.ogg", false, 2);
    if (ok) ok = loadSound("BattleRifleReloadSnd", "Weapons\Reload\BattleRifleReload.ogg", false, 2);
    if (ok) ok = loadSound("BruteShotReloadSnd", "Weapons\Reload\BruteShotReload.ogg", false, 2);
    if (ok) ok = loadSound("CarbineReloadSnd", "Weapons\Reload\CarbineReload.ogg", false, 2);
    if (ok) ok = loadSound("FuelRodCannonReloadSnd", "Weapons\Reload\FuelRodCannonReload.ogg", false, 2);
    if (ok) ok = loadSound("MagnumReloadSnd", "Weapons\Reload\MagnumReload.ogg", false, 2);
    if (ok) ok = loadSound("MaulerReloadSnd", "Weapons\Reload\MaulerReload.ogg", false, 2);
    if (ok) ok = loadSound("NeedlerReloadSnd", "Weapons\Reload\NeedlerReload.ogg", false, 2);
    if (ok) ok = loadSound("RocketLauncherReloadSnd", "Weapons\Reload\RocketLauncherReload.ogg", false, 2);
    if (ok) ok = loadSound("ShotgunReloadSnd", "Weapons\Reload\ShotgunReload.ogg", false, 2);
    if (ok) ok = loadSound("SMGReloadSnd", "Weapons\Reload\SMGReload.ogg", false, 2);
    if (ok) ok = loadSound("SniperRifleReloadSnd", "Weapons\Reload\SniperRifleReload.ogg", false, 2);
    if (ok) ok = loadSound("SpikerReloadSnd", "Weapons\Reload\SpikerReload.ogg", false, 2);
    
    /***** Announcer\Medals *****/
    if (ok) ok = loadSound("DoubleKillSnd", "Announcer\Medals\DoubleKillSnd.ogg", false, 2);
    if (ok) ok = loadSound("ExterminationSnd", "Announcer\Medals\ExterminationSnd.ogg", false, 2);
    if (ok) ok = loadSound("InvincibleSnd", "Announcer\Medals\InvincibleSnd.ogg", false, 2);
    if (ok) ok = loadSound("KillingFrenzySnd", "Announcer\Medals\KillingFrenzySnd.ogg", false, 2);
    if (ok) ok = loadSound("KillingSpreeSnd", "Announcer\Medals\KillingSpreeSnd.ogg", false, 2);
    if (ok) ok = loadSound("KilljoySnd", "Announcer\Medals\KilljoySnd.ogg", false, 2);
    if (ok) ok = loadSound("KilltacularSnd", "Announcer\Medals\KilltacularSnd.ogg", false, 2);
    if (ok) ok = loadSound("KilltrocitySnd", "Announcer\Medals\KilltrocitySnd.ogg", false, 2);
    if (ok) ok = loadSound("OverkillSnd", "Announcer\Medals\OverkillSnd.ogg", false, 2);
    if (ok) ok = loadSound("RampageSnd", "Announcer\Medals\RampageSnd.ogg", false, 2);
    if (ok) ok = loadSound("RunningRiotSnd", "Announcer\Medals\RunningRiotSnd.ogg", false, 2);
    if (ok) ok = loadSound("TripleKillSnd", "Announcer\Medals\TripleKillSnd.ogg", false, 2);
    if (ok) ok = loadSound("UntouchableSnd", "Announcer\Medals\UntouchableSnd.ogg", false, 2);
    
    /***** Announcer\ *****/
    if (ok) ok = loadSound("GainedLeadSnd", "Announcer\GainedLeadSnd.ogg", false, 2);
    if (ok) ok = loadSound("HillFightSnd", "Announcer\HillFightSnd.ogg", false, 2);
    if (ok) ok = loadSound("HillGetSnd", "Announcer\HillGetSnd.ogg", false, 2);
    if (ok) ok = loadSound("HillMoveSnd", "Announcer\HillMoveSnd.ogg", false, 2);
    if (ok) ok = loadSound("LostLeadSnd", "Announcer\LostLeadSnd.ogg", false, 2);
    if (ok) ok = loadSound("MatchGenSnd", "Announcer\MatchGen.ogg", false, 2);
    if (ok) ok = loadSound("MatchCTFSnd", "Announcer\MatchCTF.ogg", false, 2);
    if (ok) ok = loadSound("MatchKOTHSnd", "Announcer\MatchKOTH.ogg", false, 2);
    if (ok) ok = loadSound("MatchArenaSnd", "Announcer\MatchArena.ogg", false, 2);
    if (ok) ok = loadSound("MatchCPSnd", "Announcer\MatchCP.ogg", false, 2);
    if (ok) ok = loadSound("RoundOverSnd", "Announcer\RoundOverSnd.ogg", false, 2);

    /***** Ambience\ *****/
    // These sounds are played in the creation event of the corresponding
    // Collision map object for the preloaded maps
    if (ok) ok = loadSound("AtaliaAmb", "Ambience\Atalia.ogg", true, 4);
    if (ok) ok = loadSound("ClassicwellAmb", "Ambience\Classicwell.ogg", true, 4);
    if (ok) ok = loadSound("ConflictAmb", "Ambience\Conflict and Valley.ogg", true, 4);
    if (ok) ok = loadSound("CorinthAmb", "Ambience\Corinth.ogg", true, 4);
    if (ok) ok = loadSound("DirtbowlAmb", "Ambience\Dirtbowl and Destroy.ogg", true, 4);
    if (ok) ok = loadSound("EgyptAmb", "Ambience\Egypt.ogg", true, 4);
    if (ok) ok = loadSound("LumberyardAmb", "Ambience\Lumberyard and Harvest.ogg", true, 4);
    if (ok) ok = loadSound("MontaneAmb", "Ambience\Montane.ogg", true, 4);
    if (ok) ok = loadSound("OrangeAmb", "Ambience\Orange.ogg", true, 4);
    if (ok) ok = loadSound("SixtiesAmb", "Ambience\Sixties.ogg", true, 4);
    if (ok) ok = loadSound("TruefortAmb", "Ambience\TrueFort and 2DFort.ogg", true, 4);
    if (ok) ok = loadSound("WaterwayAmb", "Ambience\Waterway.ogg", true, 4);
    
    // return whether everything turned out OK or not
    return (ok);
}
