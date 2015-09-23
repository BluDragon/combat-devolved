/* 'Rotate' the cursor upwards by an amount to simulate muzzle jump
**
** argument0 = The number of degrees to rotate the cursor by towards 90
*/
{
    var winWidth, winHeight;
    var curX, curY, curDeg, curDist;
    
    // behave slightly differently if the user is zoomed-in
    if (global.myself.object.zoomed) {
        // rotate the relative scope values of the owner character
        with (owner) {
            var scopeDist, scopeDir;
            
            // get the distance and direction of the current position of the scope relative to the char
            scopeDist = point_distance(0, 0, scopeRelX, scopeRelY);
            scopeDir = point_direction(0, 0, scopeRelX, scopeRelY);
            
            // 0 - 90, 270 - 360 = increase
            if (scopeDir < 90) {
                scopeDir = min(90, scopeDir + argument0);
            } else if (scopeDir > 270) {
                scopeDir += argument0;
            } else if ((scopeDir > 90) && (scopeDir < 270)) {
                scopeDir = max(90, scopeDir - argument0);
            }
            
            // convert it back to relative scope values
            scopeRelX = lengthdir_x(scopeDist, scopeDir);
            scopeRelY = lengthdir_y(scopeDist, scopeDir);
            
            // trim the scope so it stays within the map area
            if (x + scopeRelX < 0) {
                scopeRelX = 0 - x;
            } else if (x + scopeRelX > background_width[0] * background_xscale[0]) {
                scopeRelX = background_width[0] * background_xscale[0] - x;
            }
            if (y + scopeRelY < 0) {
                scopeRelY = 0 - y;
            } else if (y + scopeRelY > background_height[0] * background_yscale[0]) {
                scopeRelY = background_height[0] * background_yscale[0] - y;
            }
            
            // DO NOT MOVE THE VIEW TO MATCH YET, as this interferes with the regular
            // zoom view control code, and will cause there to be NO MUZZLE JUMP WHATSOEVER
        }
        
    } else {
        // unzoomed behavior
        // get the window's size
        winWidth = window_get_width();
        winHeight = window_get_height();
        
        // window scale isn't an issue, since we're only dealing with degrees and distances
        curX = window_mouse_get_x();
        curY = window_mouse_get_y();
    
        // rotate it about the window's center towards straight up
        curDeg = point_direction(winWidth / 2, winHeight / 2, curX, curY);
        curDist = point_distance(winWidth / 2, winHeight / 2, curX, curY);
        
        // 0 - 90, 270 - 360 = increase
        if (curDeg < 90) {
            curDeg = min(90, curDeg + argument0);
        } else if (curDeg > 270) {
            curDeg += argument0;
        } else if ((curDeg > 90) && (curDeg < 270)) {
            curDeg = max(90, curDeg - argument0);
        }
        
        curX = lengthdir_x(curDist, curDeg) + winWidth / 2;
        curY = lengthdir_y(curDist, curDeg) + winHeight / 2;
        window_mouse_set(curX, curY);
    }
}
