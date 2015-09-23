/* Common weapon function/macro for handling weapon refire time, with support for fractional
** times -- offloaded to this function due to bugs with GM's frac(x) function
*/

{
    var rt;
    
    rt = floor(refireTime + refireTimeOverflow);
    refireTimeOverflow = frac(refireTime + refireTimeOverflow);
    // frac(x) bugfix
    if (refireTimeOverflow >= 1) {
        rt += 1;
        refireTimeOverflow -= 1;
    }
    // set the alarm
    alarm[0] = rt;
    // remember what refire time we used
    currentRefireTime = rt;
}
