// Modified for FMOD

// Now returns the instance ID of the playing sound,
// in case it needs to have its volume changed later, etc

{
    var vol, sid;
    
    vol = calculateVolume(argument0, argument1);
    if (vol == 0) return 0;
    
    // play the sound, but pause first so we can set the pan/volume
    sid = FMODSoundPlay(argument2, true);
    FMODInstanceSetVolume(sid, vol);
    FMODInstanceSetPan(sid, calculatePan(argument0));
    // unpause the sound
    FMODInstanceSetPaused(sid, false);
    
    return sid;
}
