{
    var str;
    
    // start with nothing
    str = "";
    
    // pick the message
    switch (notice) {
        case 0:
            str = "Teams will be auto balanced in 10 seconds!";
            break;
        case 1:
            str = name + " has been team switched for balance!";
            break;
    }
    
    // add to the kill log
    with (KillLog) {
        map = ds_map_create();
        ds_map_add(map, "name1", "");
        ds_map_add(map, "team1", 0);
        ds_map_add(map, "weapon", -1);
        ds_map_add(map, "string", str);
        ds_map_add(map, "name2", "");
        ds_map_add(map, "team2", 0);
        ds_map_add(map, "inthis", true);
        
        ds_list_add(kills, map);
            
        if (ds_list_size(kills) > 5) {
            ds_map_destroy(ds_list_find_value(kills, 0));
            ds_list_delete(kills, 0);
        }
        
        alarm[0] = 30*5;
    }
    
    // now that the message is passed along, destroy the balancer
    instance_destroy();
}
