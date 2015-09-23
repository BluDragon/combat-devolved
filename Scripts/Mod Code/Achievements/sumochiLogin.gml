// Logs into Sumochi
{
    var args, result;
    
    args = ds_map_create();
    
    show_message("Attempting login.");
    result = sumochi_call_api("http://sumochi.ajf.me/", "api_login", args);
    show_message(result);
}
