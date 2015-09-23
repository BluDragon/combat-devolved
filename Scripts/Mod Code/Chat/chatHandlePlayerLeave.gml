/* Handles the leaving of a player by checking if the player ID exists
** in any of the messages, and setting it to -1 if it does.
** also decrements the playerID if the leaving ID is less than the one in the list
**
** argument0 = player ID
*/

{
    var i;
       
    for (i = 0; i < ds_list_size(global.chatPlayers); i += 1) {
        // if the ID matches the leaving player's ID, set it to -1
        if (ds_list_find_value(global.chatPlayers, i) == argument0) {
            ds_list_replace(global.chatPlayers, i, -1);
        }
        // decrement the ID if necessary
        if (argument0 < ds_list_find_value(global.chatPlayers, i)) {
            ds_list_replace(global.chatPlayers, i, ds_list_find_value(global.chatPlayers, i) - 1);
        }
    }
}
