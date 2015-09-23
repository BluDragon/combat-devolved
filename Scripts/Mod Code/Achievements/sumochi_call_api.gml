endpoint = argument0;
method = argument1;
parameters = argument2;

tempfile = 'temp.txt';

// prep URL

url = endpoint;

url += '?';

url += 'p=' + method;

for (key = ds_map_find_first(parameters); is_string(key); key = ds_map_find_next(parameters, key)) {
    val = ds_map_find_value(parameters, key);

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

    url += '&' + key + '=' + val;
}

handle = DM_CreateDownload(url, tempfile);

DM_StartDownload(handle);

// 0: invalid handle, 1: ready, 2: downloading, 3: downloaded
while (DM_DownloadStatus(handle) != 3) {
}

DM_StopDownload(handle);
DM_CloseDownload(handle);

if(file_exists(tempfile)) {
    handle = file_text_open_read(tempfile);
    text = '';
    while (!file_text_eof(handle)) {
        text += file_text_read_string(handle);
        file_text_readln(handle);
    }
    file_text_close(handle);
    file_delete(tempfile);

    return text;
}

return '';
