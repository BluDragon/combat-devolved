/* Trims leading whitespace from a string
**
** argument0 = string
*/
{
    var i;
    for (i = 0; i < string_length(argument0); i += 1) {
        if (string_char_at(argument0, i) != " ") break;
    }
    return (string_delete(argument0, 1, i - 1));
}
