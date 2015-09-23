// Saves to the local copy of the achievement data
// Also saves to Sumochi, only if we were successful in reading from it on init

{
    var ini, i;
    
    // save the local copy first
    ini = ds_ini_create();
    
    ds_ini_key_set(ini, "Account", "Name", global.achieveAccountName);
    ds_ini_key_set(ini, "Account", "Pass", global.achieveAccountPass);
    //ds_ini_key_set(ini, "Account", "Prompt", global.achieveAccountDeclined);
    ds_ini_key_set(ini, "Account", "Offline", global.achieveOfflineMode);
    
    for (i = 0; i < global.achieveCount; i += 1) {
        ds_ini_key_set(ini, "Achievements", global.achieveID[i], global.achieveStep[i]);
    }
    
    ds_ini_save(ini, temp_directory + "\poppy.bros");
    
    // encrypt the file
    var hSrc, hDest;
    var r, key, byte, sSize;
    
    for (i = 0; i < 4; i += 1) {
        r[i] = irandom(255);
    }
    
    hSrc = file_bin_open(temp_directory + "\poppy.bros", 0);
    hDest = file_bin_open("cheevo.gg2", 1);
    file_bin_rewrite(hDest);
    
    key = 142;
    for (i = 0; i < 4; i += 1) {
        byte = key ^ r[i];
        file_bin_write_byte(hDest, byte);
        key = byte;
    }
    
    sSize = irandom(254) + 1;
    byte = key ^ sSize;
    file_bin_write_byte(hDest, byte);
    key = byte;
    for (i = 0; i < sSize; i += 1) {
        byte = key ^ irandom(255);
        file_bin_write_byte(hDest, byte);
        key = byte;
    }
    
    sSize = file_bin_size(hSrc);
    for (i = 0; i < sSize; i += 1) {
        byte = key ^ file_bin_read_byte(hSrc);
        file_bin_write_byte(hDest, byte);
        key = byte;
    }
    
    file_bin_close(hSrc);
    file_bin_close(hDest);
    
    // delete the INI
    file_delete(temp_directory + "\poppy.bros");
    
    // TODO: Save to Sumochi
}
