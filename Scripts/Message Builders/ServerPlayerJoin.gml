// argument0 = player
// argument1 = buffer

write_ubyte(argument1, PLAYER_JOIN);
// write the length of the all the data that follows
write_ubyte(argument1, string_length(argument0.name) + 7);
// write the length of the player name
write_ubyte(argument1, string_length(argument0.name));
write_string(argument1, argument0.name);
// Write player's custom colors and armor types
write_ubyte(argument1, argument0.bodyColor);
write_ubyte(argument1, argument0.helmetColor);
write_ubyte(argument1, argument0.bodyType);
write_ubyte(argument1, argument0.helmetType);
write_ubyte(argument1, argument0.shoulderType);
write_ubyte(argument1, argument0.accessoryType);
