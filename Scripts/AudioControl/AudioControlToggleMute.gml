// toggles the global mute on or off

if(AudioControl.allAudioMuted) {
    AudioControl.allAudioMuted = false;
    FMODMasterSetVolume(1);
} else {
    AudioControl.allAudioMuted = true;
    FMODMasterSetVolume(0);
}
