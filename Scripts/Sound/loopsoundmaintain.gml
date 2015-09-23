// argument0 = new x position of sound
// argument1 = new y position of sound
// argument2 = the INSTANCE ID of the sound
// argument3 = pixel range in which the sound will play full volume (optional, default 300)
// argument4 = pixel range beyond which the sound will not be heard (optional, default 1500)
{
    if (argument2 == 0) exit;
    FMODInstanceSetVolume(argument2, calculateVolume(argument0, argument1, argument3, argument4));
    FMODInstanceSetPan(argument2, calculatePan(argument0));
}
