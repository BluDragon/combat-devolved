// Tell the server the client's pertinent info

var playername, temp;
write_ubyte(argument0, PLAYER_JOIN);
playername = string_copy(global.playerName, 0, min(string_length(global.playerName), MAX_PLAYERNAME_LENGTH));
// write the size of all the data that follows
write_ubyte(argument0, string_length(playername) + 7);
// write the size of the name string
write_ubyte(argument0, string_length(playername));
write_string(argument0, playername);
// write the custom color and armor types
write_ubyte(argument0, global.customArmorColor);
write_ubyte(argument0, global.customHelmetColor);
write_ubyte(argument0, global.customArmorType);
write_ubyte(argument0, global.customHelmetType);
write_ubyte(argument0, global.customShoulderType);
write_ubyte(argument0, global.customAccessoryType);
