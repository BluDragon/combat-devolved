// VisorHud - End Step event
{
    // increment the ammo warning flash index if the flash is on
    if (ammoFlashLeft) {
        ammoFlashLeftFrame = (ammoFlashLeftFrame + 1) mod hudFlashSpeed;
    }
    
    if (ammoFlashRight) {
        ammoFlashRightFrame = (ammoFlashRightFrame + 1) mod hudFlashSpeed;
    }
    
    // ammo pickup number timers
    ammoPickupLeftTimer = max(-1, ammoPickupLeftTimer - 1);
    ammoPickupRightTimer = max(-1, ammoPickupRightTimer - 1);
    
    if (myCharExists()) {
        // character exists
        
        // shield warning and recharge sounds
        // start looping the shields low sound if it's not playing yet
        if ((global.myself.object.shieldHp > 0) && (global.myself.object.shieldHp < 16) && (global.myself.object.timeUnscathed < 127) && (sndShieldsLow == -1)) {
            sndShieldsLow = FMODSoundLoop(global.ShieldsLowSnd);
        } else if ((global.myself.object.shieldHp == 0) && (global.myself.object.timeUnscathed < 127) && (sndShieldsOff == -1)) {
            // disable the low sound if playing
            if (sndShieldsLow != -1) {
                FMODInstanceStop(sndShieldsLow);
                sndShieldsLow = -1;
            }
            sndShieldsOff = FMODSoundLoop(global.ShieldsOffSnd);
        } else if ((global.myself.object.timeUnscathed == 127) && (global.myself.object.shieldHp < global.myself.object.maxShieldHp)) {
            // shields are now recharging, sor turn off warnings and play the sound
            FMODInstanceStop(sndShieldsLow);
            sndShieldsLow = -1;
            FMODInstanceStop(sndShieldsOff);
            sndShieldsOff = -1;
            sndShieldsRecharge = FMODSoundPlay(global.ShieldsRechargeSnd);
        }
        
        // bugfix for lagging players -- if shields are full, make sure the warning sounds are dead
        if (global.myself.object.shieldHp >= global.myself.object.maxShieldHp) {
            if (sndShieldsLow != -1) {
                FMODInstanceStop(sndShieldsLow);
                sndShieldsLow = -1;
            }
            if (sndShieldsOff != -1) {
                FMODInstanceStop(sndShieldsOff);
                sndShieldsOff = -1;
            }
        }
    } else {
        // the character does not exist
        
        // kill any playing shield sounds
        if (sndShieldsLow != -1) {
            FMODInstanceStop(sndShieldsLow);
            sndShieldsLow = -1;
        }
        if (sndShieldsOff != -1) {
            FMODInstanceStop(sndShieldsOff);
            sndShieldsOff = -1;
        }
        if (sndShieldsRecharge != -1) {
            FMODInstanceStop(sndShieldsRecharge);
            sndShieldsRecharge = -1;
        }
    }
}
