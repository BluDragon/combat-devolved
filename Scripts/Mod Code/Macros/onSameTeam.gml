/* Returns whether or not the two PLAYER instance IDs are members of the same team,
** based on the current game mode and the team codes it acquires from them.
** This is used primarily in collision detection for projectiles, hitscan, and solid characters
**
** argument0 = First PLAYER instance ID
** argument1 = Second PLAYER instance ID
**
** Returns true if the two instances are allies.
*/

{
    // TODO: Check the team codes of the two instances
    // NOTE: Also check if either instance no longer exists, in which case we should probably determine
    // what to return based on the current game mode
    
    // for testing purposes, though, everyone is hostile, except to yourself!
    return (argument0 == argument1);
}
