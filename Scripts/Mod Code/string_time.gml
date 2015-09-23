/* converts a time (in ticks) into a string
**
** argument0 = the time
*/
{
    var minutes, secondcounter, seconds, timeString;
    
    minutes = floor(argument0 / 1800);
    secondcounter = argument0 - minutes * 1800;
    seconds = floor(secondcounter / 30);
    timeString = string(minutes) + ":";
    if (seconds >= 10) timeString = timeString + string(seconds);
    else timeString = timeString + "0" + string(seconds);
    
    return (timeString);
}
