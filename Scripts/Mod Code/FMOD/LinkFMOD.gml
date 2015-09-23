// Link to the FMOD DLL, must be called before ANY FMOD functions are called!
{
    // check to make sure the DLLs exist first
    if !file_exists("GMFMOD.dll") {
        show_message("File not found: GMFMOD.dll#In directory: " + working_directory);
        game_end();
    }
    // check to make sure the DLLs exist first
    if !file_exists("fmodex.dll") {
        show_message("File not found: fmodex.dll#In directory: " + working_directory);
        game_end();
    }
    
    // Link the relevant functions
    global.dll_FMODfree = external_define("GMFMOD.dll", "FMODfree", dll_stdcall, ty_real, 0);
    global.dll_FMODinit = external_define("GMFMOD.dll", "FMODinit", dll_stdcall, ty_real, 2, ty_real, ty_real);
    global.dll_FMODSoundSetGroup = external_define("GMFMOD.dll", "FMODSoundSetGroup", dll_stdcall, ty_real, 2, ty_real, ty_real);
    global.dll_FMODSoundPlay = external_define("GMFMOD.dll", "FMODSoundPlay", dll_stdcall, ty_real, 2, ty_real, ty_real);
    global.dll_FMODSoundLoop = external_define("GMFMOD.dll", "FMODSoundLoop", dll_stdcall, ty_real, 2, ty_real, ty_real);
    global.dll_FMODSoundSetMaxVolume = external_define("GMFMOD.dll", "FMODSoundSetMaxVolume", dll_stdcall, ty_real, 2, ty_real, ty_real);
    global.dll_FMODInstanceSetPaused = external_define("GMFMOD.dll", "FMODInstanceSetPaused", dll_stdcall, ty_real, 2, ty_real, ty_real);
    
    global.dll_FMODSoundAdd = external_define("GMFMOD.dll", "FMODSoundAdd", dll_stdcall, ty_real, 3, ty_string, ty_real, ty_real);

    global.dll_FMODMasterSetVolume = external_define("GMFMOD.dll", "FMODMasterSetVolume", dll_stdcall, ty_real, 1, ty_real);
    global.dll_FMODUpdate = external_define("GMFMOD.dll", "FMODUpdate", dll_stdcall, ty_real, 0);
    global.dll_FMODSoundFree = external_define("GMFMOD.dll", "FMODSoundFree", dll_stdcall, ty_real, 1, ty_real);
    global.dll_FMODAllStop = external_define("GMFMOD.dll", "FMODAllStop", dll_stdcall, ty_real, 0);
    global.dll_FMODInstanceStop = external_define("GMFMOD.dll", "FMODInstanceStop", dll_stdcall, ty_real, 1, ty_real);
    global.dll_FMODInstanceIsPlaying = external_define("GMFMOD.dll", "FMODInstanceIsPlaying", dll_stdcall, ty_real, 1, ty_real);
    global.dll_FMODInstanceSetVolume=external_define("GMFMOD.dll", "FMODInstanceSetVolume", dll_stdcall, ty_real, 2, ty_real, ty_real);
    global.dll_FMODGetLastError = external_define("GMFMOD.dll", "FMODGetLastError", dll_stdcall, ty_real, 0);
    global.dll_FMODInstanceSetPan = external_define("GMFMOD.dll", "FMODInstanceSetPan", dll_stdcall, ty_real, 2, ty_real, ty_real);
    global.dll_FMODInstanceSetLoopCount = external_define("GMFMOD.dll", "FMODInstanceSetLoopCount", dll_stdcall, ty_real, 2, ty_real, ty_real);
    global.dll_FMODInstanceGetSound = external_define("GMFMOD.dll", "FMODInstanceGetSound", dll_stdcall, ty_real, 1, ty_real);
    
    //global.dll_FMODSetPassword = external_define("GMFMOD.dll", "FMODSetPassword", dll_stdcall, ty_real, 1, ty_string);
}
