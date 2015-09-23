/* Frees a sound resource from memory
**
** argument0 = the ID of the sound resource to free from memory
** 
** Returns 0 on failure, 1 on success
*/

return external_call(global.dll_FMODSoundFree, argument0);
