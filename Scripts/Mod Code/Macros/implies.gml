/* Material Conditional function, also known as the IMPLIES operator
**
** argument0 = condition 'p'
** argument1 = condition 'q'
**
** Returns true or fales based on this table:
**  p | q | p -> q
**  F   F   T
**  F   T   T
**  T   F   F
**  T   T   T
*/

// always return true if P is false
if (!argument0) return (true);
// otherwise, return Q
return (argument1);
