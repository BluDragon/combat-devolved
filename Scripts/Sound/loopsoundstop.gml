/*
{
    sound_stop(argument0);
}
*/
// Modified for FMOD
// argument0 is now the INSTANCE ID instead of the SOUND ID

{
    if (argument0 == 0) exit;
    FMODInstanceStop(argument0);
}
