/**
 * Perform the "player death" event, i.e. change the appropriate scores,
 * destroy the character object to much splattering and so on.
 *
 * argument0: The player whose character died
 * argument1: The player who inflicted the fatal damage (or -1 for unknown)
 * argument2: The player who assisted the kill (or -1 for no assist)
 * argument3: The source of the fatal damage
 */
var victim, killer, assistant, damageSource;
victim = argument0;
killer = argument1;
assistant = argument2;
damageSource = argument3;

if(!(killer and instance_exists(killer))) {
    killer = noone;
}

if(!(assistant and instance_exists(assistant))) {
    assistant = noone;
}

//*************************************
//*      Scoring and Kill log
//*************************************
 

recordKillInLog(victim, killer, assistant, damageSource);

victim.stats[DEATHS] += 1;

if(killer)
{
    /*
    if(damageSource == WEAPON_KNIFE || damageSource == WEAPON_BACKSTAB)
    {
        killer.stats[STABS] += 1;
        killer.roundStats[STABS] += 1;
        killer.stats[POINTS] += 1;
        killer.roundStats[POINTS] +=1;
    }
    */
            
    if (killer != victim)
    {
        killer.stats[KILLS] += 1;
        killer.roundStats[KILLS] += 1;
        killer.stats[POINTS] += 1;
        killer.roundStats[POINTS] += 1;
        if(victim.object.intel)
        {
            killer.stats[DEFENSES] += 1;
            killer.roundStats[DEFENSES] += 1;
            killer.stats[POINTS] += 1;
            killer.roundStats[POINTS] += 1;
            recordEventInLog(4, killer.team, killer.name, global.myself == killer);
        }
    }
}

if (assistant)
{
    assistant.stats[ASSISTS] += 1;
    assistant.roundStats[ASSISTS] += 1;
    assistant.stats[POINTS] += .5;
    assistant.roundStats[POINTS] += .5;
}

//SPEC
if (victim == global.myself)
    instance_create(victim.object.x, victim.object.y, Spectator);

//*************************************
//*         Gibbing
//*************************************
// There are no gib chunks in Halo Mod, just LOTS AND LOTS OF BLOOD
// (Replaced every gib launching with more blood)
var xoffset, yoffset, xsize, ysize;

xoffset = view_xview[0];
yoffset = view_yview[0];
xsize = view_wview[0];
ysize = view_hview[0];

randomize();
with(victim.object) {
    if((damageSource == WEAPON_ROCKETLAUNCHER 
    or damageSource == FRAG_BOX 
    or damageSource == FINISHED_OFF_GIB or damageSource == GENERATOR_EXPLOSION) 
    and (global.gibLevel>1) 
    and distance_to_point(xoffset+xsize/2,yoffset+ysize/2) < 900) {
        repeat(global.gibLevel * 14) {
            var blood;
            blood = instance_create(x+random(23)-11,y+random(23)-11,BloodDrop);
            blood.hspeed=(random(21)-10);
            blood.vspeed=(random(21)-13);
        }

    }  // WAS an else, but even if you gib we'll leave behind a body
    
    // play the appropriate death sound based on how the victim died
    switch (damageSource) {
        case MELEE_STRIKE:
        case MELEE_BACKSTAB:
            // play the melee death sound
            playsound(x, y, choose(global.MeleeDeathSnd1, global.MeleeDeathSnd2, global.MeleeDeathSnd3, global.MeleeDeathSnd4));
            break;
        default:
            // play the standard death sound
            playsound(x, y, choose(global.DeathSnd1, global.DeathSnd2, global.DeathSnd3, global.DeathSnd4, global.DeathSnd5));
            break;
    }
    
    var deadbody;
    deadbody = instance_create(x, y - 15, DeadGuy);
    
    // set the armor colors and indexes for the corpse
    deadbody.bodyColor = bodyColor;
    deadbody.helmetColor = helmetColor;
    deadbody.bodyType = bodyType;
    deadbody.helmetType = helmetType;
    deadbody.shoulderType = shoulderType;

    deadbody.hspeed = hspeed;
    deadbody.vspeed = vspeed;
    if (hspeed > 0) {
        deadbody.image_xscale = -1;
    }
}

//*************************************
//*    Weapon Drops
//*************************************
// Since this event is synced for server and client, we don't need to send/receive a spawn event for this
// Just go ahead and spawn the two dropped weapons

// TODO: Make it so weapons aren't dropped when killed by things that shouldn't produce drops (i.e. pitfalls)

var w1, w2, face;

// get the weapon objects
w1 = victim.object.weapons[0];
w2 = victim.object.weapons[1];
if (victim.object.currentWeapon == 0) {
    face = victim.object.image_xscale;
} else {
    face = -victim.object.image_xscale;
}

//*************************************
//*    Medal and Cheevo Controllers
//*************************************
if (global.myself != -1) {
    // if the player was killed, reset the spree counter
    if (victim == global.myself) {
        with (MedalController) {
            spreeCounter = 0;
        }
    }
    
    // if the player is the killer (and also not the victim)
    if ((killer == global.myself) && (victim != global.myself)) {
        // score the kill for the medal controller
        medalScoreKill(victim);
        
        // if the victim had a killstreak of 5 or more, earn the KILLJOY medal
        if (victim.killStreak >= 5) {
            recordMedal(KilljoyM, "Killjoy!");
            announcerQueue(VOX_MEDAL_KJOY);
        }
        
        /*
        // if the victim was killed while the player is respawning, earn POST MORTEM
        // also earn Death From the Grave
        if (global.myself.alarm[5] > -1) {
            recordMedal(DeathGraveM, "Death From the Grave!");
            achieveIncrement(ACH_POSTMORTEM);
        }
                
        // if the victim was at least 100 pixels above any obstacles (or the killer), earn TOO CLOSE TO THE SUN
        if (damageSource == WEAPON_ROCKETLAUNCHER) {
            //if (!collision_line(victim.object.x, victim.object.y, victim.object.x, victim.object.y + 100, Obstacle, false, true)) achieveIncrement(ACH_ICARUS);
            if (killer.object.y - victim.object.y >= 100) achieveIncrement(ACH_ICARUS);
        }

        // if the victim was killed by an explosive or a SWORD, increment the multikill counters for those wepaons
        // and check if they're at 3 yet (no need to poll the medalcontroller, because it will reset them for us)
        /*
        if (damageSource == WEAPON_ROCKETLAUNCHER) {
            AchievementController.multikillExplosives += 1;
            if (AchievementController.multikillExplosives = 3) achieveIncrement(ACH_RAININGMEN);
        }
        if ((damageSource == WEAPON_KNIFE) || (damageSource == WEAPON_BACKSTAB)) {
            AchievementController.multikillSword += 1;
            if (AchievementController.multikillSword = 3) achieveIncrement(ACH_STEPPINRAZOR);
            recordMedal(BeatdownM, "Beatdown!");
        }
        */
        if (damageSource == MELEE_BACKSTAB) {
            // earn the ASSASSIN medal
            recordMedal(AssassinM, "Assassin!");
        }
        
        // if the victim was killed by the needler, increment the counter
        /*
        if (damageSource == WEAPON_NEEDLEGUN) {
            AchievementController.needlerKills += 1;
            // if we've done this 5 times, earn FEAR THE PINK MIST
            if (AchievementController.needlerKills = 5) achieveIncrement(ACH_PINKMIST);
        }
        
        // if the victim was killed by a sentry while newly-spawned, earn HAVE FUN RESPAWNING
        if (damageSource == WEAPON_SENTRYTURRET) && (victim.object.freshRespawn > 0) achieveIncrement(ACH_FUNRESPAWN);
        */
    }
    
    /*
    // if the player is the victim
    if (victim == global.myself) {
        // reset eligibility for Stop Drop Go
        AchievementController.stopDropGoOkay = false;
    }
    */
}

// Killjoy medal killstreak counter stuff, must be done AFTER we check the victim's kill count for Killjoy
// increment the killer's streak
if (killer > 0) killer.killStreak += 1;
// and reset the victim's
victim.killStreak = 0;

/*** END MOD CODE ***/

with(victim.object) {       
    instance_destroy();
}

//*************************************
//*         Deathcam
//*************************************
/* There is no Deathcam in Halo Mod!
if( global.killCam and victim == global.myself and killer and killer != victim and !(damageSource == KILL_BOX || damageSource == FRAG_BOX || damageSource == FINISHED_OFF || damageSource == FINISHED_OFF_GIB || damageSource == GENERATOR_EXPLOSION)) {
    instance_create(0,0,DeathCam);
    DeathCam.killedby=killer;
    DeathCam.name=killer.name;
    DeathCam.oldxview=view_xview[0];
    DeathCam.oldyview=view_yview[0];
    DeathCam.lastDamageSource=damageSource;
    DeathCam.team = global.myself.team;
}
*/
