/* Common script to be called when the cursor zoom is undone
**
** Moves the cursor to be in the same direction the character was facing when zoomed
*/
{
    var curDir, winWidth, winHeight, winScale, curX, curY;
    
    // calculate the direction the cursor was facing
    curDist = point_distance(0, 0, global.myself.object.scopeRelX, global.myself.object.scopeRelY);
    curDir = point_direction(0, 0, global.myself.object.scopeRelX, global.myself.object.scopeRelY);
    
    // get the window size
    winWidth = window_get_width();
    winHeight = window_get_height();
    
    // get the current window scale
    winScale = windowScale();
    
    // calculate the new position of the cursor
    curX = lengthdir_x(min(curDist, 275) * winScale, curDir) + winWidth / 2;
    curY = lengthdir_y(min(curDist, 275) * winScale, curDir) + winHeight / 2;
    
    // set the new position
    window_mouse_set(curX, curY);
}
