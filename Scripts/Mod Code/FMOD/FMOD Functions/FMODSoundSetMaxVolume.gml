/* Sets the maximum volume for a sound resource.
** Should be called before playing the sound.
**
** argument0 = ID of the sound resource
** argument1 = volume, 0 to 1
*/

return external_call(global.dll_FMODSoundSetMaxVolume, argument0, argument1);
