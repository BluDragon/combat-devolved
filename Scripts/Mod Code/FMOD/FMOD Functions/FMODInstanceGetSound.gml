/* Gets the sound ID of the playing instance ID
**
** argument0 == instance ID
**
** Returns the sound ID, or 0 if the instance is not valid
*/

return external_call(global.dll_FMODInstanceGetSound, argument0);
