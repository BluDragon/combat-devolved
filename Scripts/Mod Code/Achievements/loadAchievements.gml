// Loads the local copy of the achievement data

// TODO: Compare the local copy to the Sumochi server's copy.
// If there are any discrepancies, assume the Sumochi server's as the correct ones.

// ...In other words load the local copy and then attempt to load the Sumochi server's copy.
// If the attempted load failed, we will NOT update Sumochi when the program ends.

/*********** TODO: **********

If the player has not yet declined, they will be prompted when GG2 opens to enter their
account info for use with the achievement server.

Whenever the Account name is changed (from empty, or from one ID to the next) the local
copy of the achievements will be purged.  Any achivements on Sumochi associated with that
ID will still be there.  It will also attempt to reload the achivements from Sumochi when
the user accepts this arrangement.

******************************/

{
    var ini, i;
    
    // first attempt to load the local copy
    ini = ds_ini_create();
    
    // detect if the achievements file exists
    // if not, don't try to open the INI, just use the default settings
    if (file_exists("cheevo.gg2")) {
        // decrypt to the temporary directory
        var hSrc, hDest;
        var i, key, byte, sSize;
        
        hSrc = file_bin_open("cheevo.gg2", 0);
        hDest = file_bin_open(temp_directory + "\poppy.bros", 1);
        file_bin_rewrite(hDest);
        
        key = 142;
        for (i = 0; i < 4; i += 1) {
            byte = file_bin_read_byte(hSrc) ^ key;
            key = byte ^ key;
        }
        
        sSize = file_bin_read_byte(hSrc) ^ key;
        key = sSize ^ key;
        for (i = 0; i < sSize; i += 1) {
            byte = file_bin_read_byte(hSrc) ^ key;
            key = byte ^ key;
        }
        
        sSize = file_bin_size(hSrc) - 5 - sSize;
        for (i = 0; i < sSize; i+= 1) {
            byte = key ^ file_bin_read_byte(hSrc);
            file_bin_write_byte(hDest, byte);
            key = byte ^ key;
        }
        
        file_bin_close(hSrc);
        file_bin_close(hDest);
        
        // load the INI
        ds_ini_load(ini, temp_directory + "\poppy.bros");
        // delete the decrypted file
        file_delete(temp_directory + "\poppy.bros");
    }
    
    // load the account information
    global.achieveAccountName = ds_ini_key_get(ini, "Account", "Name", "");
    global.achieveAccountPass = ds_ini_key_get(ini, "Account", "Pass", "");
    //global.achieveAccountDeclined = ds_ini_key_get(ini, "Account", "Prompt", false);
    global.achieveOfflineMode = real(ds_ini_key_get(ini, "Account", "Offline", true));
    
    // load the achievement progression
    for (i = 0; i < global.achieveCount; i += 1) {
        global.achieveStep[i] = real(ds_ini_key_get(ini, "Achievements", global.achieveID[i], 0));
    }

    // free the INI object
    ds_ini_destroy(ini);
}
