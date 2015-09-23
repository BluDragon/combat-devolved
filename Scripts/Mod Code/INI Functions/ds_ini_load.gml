/* Loads an INI from a file.
**
** Returns false if there was an error
**
** argument0 = INI map handle
** argument1 = filename/path
*/
{
    var hFile, secName, keyName, keyValue, line;
    
    // check to see if the file exists first
    if (file_exists(argument1) == false) return false;
    
    // open the file for reading
    hFile = file_text_open_read(argument1);
    
    // default section is "<root>" in case keys are placed outside of a section
    secName = "<root>";
    
    // read and parse the file line-by-line
    while (file_text_eof(hFile) == false) {
        // remove preceeding whitespace
        line = string_trim(file_text_read_string(hFile));
        
        // check if it's a section
        if (string_char_at(line, 1) == "[") {
            // new section, read its name, which is until the first "]"
            secName = string_copy(line, 2, string_pos("]", line) - 2);
            // add the section
            ds_ini_section_create(argument0, secName);
        } else if (string_pos("=", line) > 1) {
            // it's a key-value pair
            keyName = string_copy(line, 1, string_pos("=", line) - 1);
            keyValue = string_delete(line, 1, string_pos("=", line));
            // add the key-value pair
            ds_ini_key_set(argument0, secName, keyName, keyValue);
        } else {
            // it's formatted incorrectly, so ignore it
        }
        // finish the line
        file_text_readln(hFile);
    }
    
    file_text_close(hFile);
    
    return true;
}
