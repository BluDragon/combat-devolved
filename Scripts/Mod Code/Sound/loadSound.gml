/* Adds a sound effect to the library.
** Note that all sounds are initially set at max volume.
** 
** argument0 = The sound effect's internal name and how it will be referenced
**              (i.e. "AlertSnd" would be stored in 'global.AlertSnd')
** argument1 = File name, including the extension (required now)
** argument2 = Whether to load the file as streamed (used for ambient loops)
** argument3 = The group to use for the sound
**
** Returns if the load was successful
*/

{
    var filename, snd, err;
    
    filename = "Sounds\" + argument1;
    
    // check if the file exists
    if (!file_exists(filename)) {
        // we didn't find the file
        show_message("File not found: " + filename + "#In directory: " + working_directory + "\");
        variable_global_set(argument0, 0);
        return false;
    }
    
    // load the sound
    snd = FMODSoundAdd(filename, false, argument2);
    // check to make sure we were successful
    if (snd == 0) {
        // nope, display an error
        show_message("Error loading sound " + argument1 + "#" + FMODErrorStr(FMODGetLastError()));
        variable_global_set(argument0, 0);
        return false;
    }
    
    FMODSoundSetGroup(snd, argument3);
    FMODSoundSetMaxVolume(snd, 1);
    
    variable_global_set(argument0, snd);
    
    return true;
}
