{
    var xmid;
    xmid = view_xview[0] + view_wview[0] / 2;
    
    // if a character player exists, use his position rather than the view's
    if (myCharExists()) {
        xmid = global.myself.object.x;
    }
    
    if((argument0-xmid)<-400) {
        return -1;
    } else if((argument0-xmid)>400) {
        return 1;
    } else {
        return ((argument0-xmid)/400);
    }
}
