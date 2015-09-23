/* Sets the priority group of a sound resource.
** Should be called before playing the sound, preferably right after loading it.
**
** argument0 = ID of the sound resource
** argument1 = Priority group
**      1 = Top priority; will always be played
**      2 = 'Effects' priority
**      3 = 'Ambient Music' priority
**      4 = 'Ambient Effects' priority
*/

return external_call(global.dll_FMODSoundSetGroup, argument0, argument1);
