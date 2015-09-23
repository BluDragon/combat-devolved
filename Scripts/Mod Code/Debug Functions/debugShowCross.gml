/* Creates a cross or vector to be drawn on the room to aid in debug
**
** argument0 = x origin
** argument1 = y origin
** argument2 = cross lifetime
** argument3 = cross radius in pixels
** argument4 = cross color (optional)
** argument5 = draw a vector
** argument6 = x endpoint
** argument7 = y endpoint
** argument8 = vector color (optional)
*/

{
    var dc;
    
    // create the cross
    dc = instance_create(argument0, argument1, DebugCross);
    
    // set the properties
    if (argument2 >= 0) dc.alarm[0] = argument2;
    dc.crossSize = argument3;
    if (argument4 != 0) dc.crossColor = argument4;
    dc.vector = argument5;
    dc.vectorX = argument6;
    dc.vectorY = argument7;
    if (argument8 != 0) dc.vectorColor = argument8;
}
