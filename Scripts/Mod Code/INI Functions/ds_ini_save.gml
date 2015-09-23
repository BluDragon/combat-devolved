/* Saves the INI to a file.
**
** Returns false if there was an error (i.e. no sections)
**
** argument0 = INI map handle
** argument1 = filename/path
*/
{
    var hFile, section, secName, keyName;
    
    // only create a file if there are sections to be written
    if (ds_map_size(argument0) == 0) return false;
    
    // open the file for writing
    hFile = file_text_open_write(argument1);
    
    // iterate through each section, writing it to the file
    secName = ds_map_find_first(argument0);
    repeat (ds_map_size(argument0)) {
        // write the section name
        file_text_write_string(hFile, "[" + secName + "]");
        file_text_writeln(hFile);
        
        section = ds_map_find_value(argument0, secName);
        // write all the key-value pairs in the section
        if (ds_map_size(section) > 0) {
            keyName = ds_map_find_first(section);
            repeat (ds_map_size(section)) {
                file_text_write_string(hFile, keyName + "=" + string(ds_map_find_value(section, keyName)));
                file_text_writeln(hFile);
                
                keyName = ds_map_find_next(section, keyName);
            }
        }
                
        // get the section name for the next one
        secName = ds_map_find_next(argument0, secName);
        // add a newline to seperate sections
        file_text_writeln(hFile);
    }
        
    file_text_close(hFile);
    
    return true;
}
