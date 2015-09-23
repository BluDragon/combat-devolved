// Initializes all the variables used by chatting
{
    // control disabling for the name chat window
    global.chatControl = false;
    
    // these three lists store the last X lines of text and their PLAYER ID
    // (which you plug into ds_list_find_value(global.players, playerID) to get the
    // player instance, which I can use to color-code the text
    //
    // If a player leaves the server, it will set the player ID to -1, so it can be shown in white
    
    global.chatLog = ds_list_create();      // the actual text of the line
    global.chatPlayers = ds_list_create();  // the player who said it
    global.chatScope = ds_list_create();    // the scope of the message (global/team, for marking it as such)
    global.chatNames = ds_list_create();    // the name of player at the time the message was sent (if a player leaves while a message is still in the list)
}
