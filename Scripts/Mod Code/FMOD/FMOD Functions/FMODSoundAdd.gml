/* Adds a sound resource to the system.
**
** argument0 = filename/path of the sound resource (i.e. "sounds\beep.wav")
** argument1 = whether to load the file as 3D enabled
** argument2 = whether to stream the file (try using this for BGM)
**
** Returns the ID of the added sound resource.
*/

return external_call(global.dll_FMODSoundAdd, argument0, argument1, argument2);
