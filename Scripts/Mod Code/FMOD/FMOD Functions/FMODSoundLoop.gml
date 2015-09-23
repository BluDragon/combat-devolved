/* Plays a sound with looping.
**
** argument0 = ID of the sound resource
** argument1 = Whether to start the sound paused, which should be done if
**              instance settings are going to be configured for the sound, and then
**              it should be unpaused when ready to play (i.e. sounds played with GG2's
**              'playsound' script)
**
** Returns the instance ID on success, or 0 on error.
*/

return external_call(global.dll_FMODSoundLoop, argument0, argument1);
