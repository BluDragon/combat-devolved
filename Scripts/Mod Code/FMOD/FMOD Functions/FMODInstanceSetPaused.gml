/* Pauses/unpauses an instance.
**
** argument0 = instance ID
** argument1 = pause, true or false
*/

return external_call(global.dll_FMODInstanceSetPaused, argument0, argument1);
