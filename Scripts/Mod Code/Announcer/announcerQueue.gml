/* Adds a new sound to the Announcer's queue
**
** argument0 = the constant of the sound to add
*/

{
    with (AnnouncerController) {
        // if the queue is already too full, exit
        // (we're gonna have a hard limit in case lots and lots of junk happens at once)
        if (ds_queue_size(voiceQueue) == 5) exit;
        
        // queue it up
        ds_queue_enqueue(voiceQueue, argument0);
        // and let the controller know something was added to the queue
        event_user(0);
    }
}
