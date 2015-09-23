{
    var i, fName;
    
    i = 0;
    
    // load all .MP3 files in the Music folder
    fName = file_find_first("./Music/*.mp3", fa_archive);
    while (fName != "") {
        // filter out the title and plasma grenade
        switch (fName) {
            case "Halo Menu Music.mp3":
            case "plasma grenade.mp3":
                break;
            default:
                // changed for FMOD support
                //global.IngameMusic[i] = sound_add("Music/" + fName, 1, true);
                global.IngameMusic[i] = FMODSoundAdd("Music\" + fName, false, true);
                FMODSoundSetGroup(global.IngameMusic[i], 3);
                FMODSoundSetMaxVolume(global.IngameMusic[i], 1);
                i += 1;
                break;
        }
        
        fName = file_find_next();
    }
    file_find_close();
    
    global.numIngameMusic = i;
    
    // crude fix for if people have no custom MP3s
    if (i == 0) {
        global.IngameMusic[0] = 0;
        global.numIngameMusic = 1;
    }
}
