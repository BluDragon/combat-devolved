/* Relocates the position of the cursor to within a melee weapon's range
**
** argument0 = The maximum range of the cursor
*/
{
    var winWidth, winHeight, winScale;
    var curX, curY, curDeg, curDist;
    
    // abort if the cursor is the default mouse cursor, as that would indicate we're in a menu
    if (Cursor.sprite_index == CrosshairS) exit;
    
    // check to see if the game's window has focus or not --
    // if it doesn't we abort the limit!
    if (window_handle() != getForegroundWindow()) exit;
    
    // get the window size
    winWidth = window_get_width();
    winHeight = window_get_height();
    
    // calculate the window's scale
    winScale = windowScale();
    
    // get the cursor's position
    curX = window_mouse_get_x();
    curY = window_mouse_get_y();
    
    curDeg = point_direction(winWidth / 2, winHeight / 2, curX, curY);
    curDist = point_distance(winWidth / 2, winHeight / 2, curX, curY) / winScale;
    
    // if the cursor is outside of the defined range, rein it in
    if (curDist > argument0) {
        curX = lengthdir_x(argument0 * winScale, curDeg) + winWidth / 2;
        curY = lengthdir_y(argument0 * winScale, curDeg) + winHeight / 2;
        
        window_mouse_set(curX, curY);
    }
}
