if(instance_exists(argument0)) {
    if(argument0.object != -1) {
        argument0.object.bubble.image_index = argument1;
        argument0.object.bubble.alarm[0] = 60;
        argument0.object.bubble.visible = true;
        argument0.object.bubble.bubbleAlpha = 1;
        argument0.object.bubble.fadeout = false;
        switch(argument1) {
            case 59:
                playsound(argument0.object.x, argument0.object.y, global.muchtolearnSnd);
                break;
        }
        
        // GAME GRUMPS
        if (global.gameGrumps) {
            if (argument0.team == TEAM_RED) {
                argument0.object.bubble.sprite_index = BubbleGrumpsS;
                argument0.object.bubble.image_index = 0;
            } else {
                argument0.object.bubble.sprite_index = BubbleGrumpsS;
                argument0.object.bubble.image_index = 1;
            }
        }
    }
}
