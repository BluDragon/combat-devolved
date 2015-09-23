// argument0 = which sound to play
//   0 for pickup
//   1 for drop

{
    sound_stop(IntelDropSnd);   // simple fix for intel sounds
    sound_stop(IntelGetSnd);
    
    // if an instance of the WinBanner exists, then exit without playing
    if (instance_exists(WinBanner)) exit;

    // play the proper one
    switch (argument0) {
        case 0:
            sound_play(IntelGetSnd);
            break;
        
        case 1:
            sound_play(IntelDropSnd);
            break;
    }
}
