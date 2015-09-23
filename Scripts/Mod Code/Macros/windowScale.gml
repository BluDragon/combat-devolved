/* Calculates and returns the scale of the window based on its current dimensions.
*/
{
    var winWidth, winHeight;
    
    // get the window size
    winWidth = window_get_width();
    winHeight = window_get_height();
    
    // the window's scale is of importance here, so calculate that
    // also, account for an aspect ratio that is not 4:3
    if (winHeight / winWidth > 0.75) {
        // window's taller than it is wide, so get the scale from the width
        return (winWidth / view_wview[0]);
    } else if (winHeight / winWidth < 0.75) {
        // window's wider than it is tall, so get the scale from the height
        return (winHeight / view_hview[0]);
    }
    
    // by some miracle, the aspect ratio is dead-on (or the window hasn't been rescaled)
    // we can calculate the scale from either
    return (winHeight / view_hview[0]);
}
