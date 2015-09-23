/* Registers a playing sound instance to have its volume and pan automatically updated
** each step based on the camera's position.
**
** Calling the function on a sound that's already been registered will update the position.
** 
** argument0 = sound's instance ID
** argument1 = x position of the sound's source
** argument2 = y position of the sound's source
*/

{
    // add the relevant items to the DLL controller object
    with (DLLController) {
        // check if that sound instance ID exists already
        var pos;
        pos = ds_list_find_index(autopanSoundsID, argument0);
        
        if (pos == -1) {
            // the sound doesn't already exist, add it
            ds_list_add(autopanSoundsID, argument0);
            ds_list_add(autopanSoundsX, argument1);
            ds_list_add(autopanSoundsY, argument2);
        } else {
            // the sound exists, update the position
            ds_list_replace(autopanSoundsX, pos, argument1);
            ds_list_replace(autopanSoundsY, pos, argument2);
        }
    }
}
