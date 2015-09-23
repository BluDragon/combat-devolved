/* Returns if the user has an existing character.
*/
{
    if (global.myself == -1) return false;
    if (global.myself.object == -1) return false;
    return true;
}
