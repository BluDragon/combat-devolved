/* Adds a new chat message to the list.
**
** argument0 = Player ID of the sender
** argument1 = Scope of the message
** argument2 = The message string
*/
{
    // TODO: Depending upon game mode and message scope, add it to the log
    // For example, if the scope is TEAM, only add it if we're on the same team as the sender
    
    // For now, though, add all messages regardless
    ds_list_insert(global.chatLog, 0, argument2);
    ds_list_insert(global.chatPlayers, 0, argument0);
    ds_list_insert(global.chatScope, 0, argument1);
    ds_list_insert(global.chatNames, 0, ds_list_find_value(global.players, argument0).name);
    
    // if logging to file is enabled, add the message to the log
    if (global.logChatToFile) {
        file_text_write_string(ChatBox.hLogFile, "[" + date_time_string(date_current_time()) + "] ");
        file_text_write_string(ChatBox.hLogFile, ds_list_find_value(global.players, argument0).name + ": ");
        file_text_write_string(ChatBox.hLogFile, argument2);
        file_text_writeln(ChatBox.hLogFile);
    }
    
    // if the list is longer than the max, remove the trailing entry
    if (ds_list_size(global.chatLog) > CHAT_LOG_SIZE) ds_list_delete(global.chatLog, CHAT_LOG_SIZE);
    if (ds_list_size(global.chatPlayers) > CHAT_LOG_SIZE) ds_list_delete(global.chatPlayers, CHAT_LOG_SIZE);
    if (ds_list_size(global.chatScope) > CHAT_LOG_SIZE) ds_list_delete(global.chatScope, CHAT_LOG_SIZE);
    if (ds_list_size(global.chatNames) > CHAT_LOG_SIZE) ds_list_delete(global.chatNames, CHAT_LOG_SIZE);
}
