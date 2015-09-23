{
    // spawn a weapon at the host's feet, if the host has an existing player character
    if (global.isHost && myCharExists()) {
        var wt;
        wt = WEAPON_FLAMETHROWER;
        sendEventWeaponSpawn(wt, global.weaponMaxAmmo[wt] + global.weaponMaxReserve[wt], 900, global.myself.object.x, global.myself.object.y, 0, 0);
        doEventWeaponSpawn(wt, global.weaponMaxAmmo[wt] + global.weaponMaxReserve[wt], 900, global.myself.object.x, global.myself.object.y, 0, 0);
    }
}
