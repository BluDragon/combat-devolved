/* Sets the volume of a sound instance.
**
** argument0 = instance ID
** argument1 = volume, 0 to 1
*/

return external_call(global.dll_FMODInstanceSetVolume, argument0, argument1);
