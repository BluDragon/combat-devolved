{
    with (argument0) {
        instance_destroy();
    }
    
    // handle the player leaving in the chat
    chatHandlePlayerLeave(ds_list_find_index(global.players, argument0));
    
    ds_list_delete(global.players, ds_list_find_index(global.players, argument0));
}
