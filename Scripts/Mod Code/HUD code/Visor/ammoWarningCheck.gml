/* Checks to see if the ammo warning flash should be begun/extended
**
** argument0 = Instance ID of the weapon to perform the warning check on
** argument1 = Whether to show the warning on the left (true) or the default right (false)
** argument2 = Whether to reset the flash, rather than extend it (i.e. on weapon switch)
** argument3 = How long to flash for in frames (optional, less than 1 will use the default)
** argument4 = Whether or not to force the flash
*/

{
    // if the current ammo is <= 35%, enable the flash
    // (even if we have 0 ammo, this would trigger the flash, so no need to check for that)
    if (((argument0.ammoCount / argument0.maxAmmo) <= 0.35) || argument4) {
        // argument3 default case
        if (argument3 <= 0) argument3 = VisorHud.hudFlashSpeed * 2;
        if (argument1) {
            // left side
            // enable the flash and set the alarm for 2 flashes
            VisorHud.ammoFlashLeft = true;
            VisorHud.alarm[0] = argument3;
            // reset the flash frame if we've been asked to
            if (argument2) VisorHud.ammoFlashLeftFrame = 0;
        } else {
            // right side
            // enable the flash and set the alarm for 2 flashes
            VisorHud.ammoFlashRight = true;
            VisorHud.alarm[1] = argument3;
            // reset the flash frame if we've been asked to
            if (argument2) VisorHud.ammoFlashRightFrame = 0;
        }
    } else {
        if (argument1) {
            // left side
            // disable the flash and alarm, as the check was negative
            VisorHud.ammoFlashLeft = false;
            VisorHud.alarm[0] = -1;
            VisorHud.ammoFlashLeftFrame = 0;
        } else {
            // right side
            // disable the flash and alarm, as the check was negative
            VisorHud.ammoFlashRight = false;
            VisorHud.alarm[1] = -1;
            VisorHud.ammoFlashRightFrame = 0;
        }
    }
}
