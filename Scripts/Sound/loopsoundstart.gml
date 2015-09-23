/* Starts playing a sound, looping it
**
** argument0 = x position of the sound source
** argument1 = y position of the sound source
** argument2 = sound ID to play
** argument3 = pixel range in which the sound will play full volume (optional, default 300)
** argument4 = pixel range beyond which the sound will not be heard (optional, default 1500)
*/
{
    var sid, vol;
    
    sid = FMODSoundLoop(argument2, true);
    FMODInstanceSetVolume(sid, calculateVolume(argument0, argument1, argument3, argument4));
    FMODInstanceSetPan(sid, calculatePan(argument0));
    FMODInstanceSetPaused(sid, false);
    
    return sid;
}
