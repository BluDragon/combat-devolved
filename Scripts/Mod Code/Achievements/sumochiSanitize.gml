var val;

val = argument0;

    // lazily sanitize by replacing all "reserved" characters
    // and space
    // this will probably break for control characters
    // or non-sestets (>127, Latin-1)
    val = string_replace_all(val, ' ', '%20');
    val = string_replace_all(val, '!', '%21');
    val = string_replace_all(val, '#', '%23');
    val = string_replace_all(val, '$', '%24');
    val = string_replace_all(val, '&', '%26');
    val = string_replace_all(val, "'", '%27');
    val = string_replace_all(val, '(', '%28');
    val = string_replace_all(val, ')', '%29');
    val = string_replace_all(val, '*', '%2A');
    val = string_replace_all(val, '+', '%2B');
    val = string_replace_all(val, ',', '%2C');
    val = string_replace_all(val, '/', '%2F');
    val = string_replace_all(val, ':', '%3A');
    val = string_replace_all(val, ';', '%3B');
    val = string_replace_all(val, '=', '%3D');
    val = string_replace_all(val, '?', '%3F');
    val = string_replace_all(val, '@', '%40');
    val = string_replace_all(val, '[', '%5B');
    val = string_replace_all(val, ']', '%5D');
    
return val;
