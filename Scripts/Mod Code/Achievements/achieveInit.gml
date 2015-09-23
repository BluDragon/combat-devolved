// Initialize all the data used by the Achievements functionality

// achieveID = internal name of the achievement (for use in the record file and on the Sumochi server)
// achieveName = display name of the achievement
// achieveDesc = achievement description / how to earn it
// achieveSprite = sprite used for the achievement
// achieveIcon = filename of achievement icon on Sumochi server
// achieveEarnSteps = Long-term progression required until achievement is earned (kills, wins, etc)
// achieveStep = Current progression, inits to 0, actual status is loaded later
// achieveProgTerm = The string to use when displaying achievement progress on the menu (i.e. "games won")

{
    var i, cr;
    
    cr = chr(13);
    
    /******** ACHIEVEMENT DATA ********/
    
    // Sumochi server account name and password
    global.achieveAccountName = "";
    global.achieveAccountPass = "";
    global.achieveOfflineMode = true;  // offline mode; whether or not to actually use Sumochi, basically
    
    // login token gotten from sumochi
    global.sumochiLoginToken = "";
    
    // whether or not we were successful in logging into sumochi at any point
    // (usually initially on load, or after setting up the user account)
    global.sumochiSynced = false;
    
    // the queue where we record (by index) what achievements we need to write to Sumochi
    // at the end of the game
    global.achieveSaveQueue = ds_queue_create();
    
    // These next two variables are kind of a crude way to pass arguments to the Sumochi Sync
    // room controller, and I don't like it very much, but we'll work with it
    // the functionality that should be invoked at the next creation of the Sumochi Sync controller
    global.sumochiSyncFunc = SUMOSYNC_LOAD;
    // the room to return to when the sync function is completed, or -1 to invoke game_end
    global.sumochiSyncReturn = Menu;

    // running tally of total available achievements
    global.achieveCount = 0;
    
    i = ACH_MVP;
    global.achieveID[i] = "kzn_halo_mvp";
    global.achieveName[i] = "MVP";
    global.achieveDesc[i] = "Earn the flaming helmet by being the first to earn 20 points.";
    global.achieveSprite[i] = MVPA;
    global.achieveIcon[i] = "kzn_halo_mvp.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_NEXTTIME;
    global.achieveID[i] = "kzn_halo_nexttime";
    global.achieveName[i] = "Maybe Next Time, Buddy";
    global.achieveDesc[i] = "Kill a cloaked enemy preparing to strike.";
    global.achieveSprite[i] = NextTimeBuddyA;
    global.achieveIcon[i] = "kzn_halo_nexttime.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_DOUBLEKILL;
    global.achieveID[i] = "kzn_halo_doublekill";
    global.achieveName[i] = "Double Kill";
    global.achieveDesc[i] = "Kill 2 enemies within 4 seconds of each other.";
    global.achieveSprite[i] = DoubleKillA;
    global.achieveIcon[i] = "kzn_halo_doublekill.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_TRIPLEKILL;
    global.achieveID[i] = "kzn_halo_triplekill";
    global.achieveName[i] = "Triple Kill";
    global.achieveDesc[i] = "Kill 3 enemies within 4 seconds of each other.";
    global.achieveSprite[i] = TripleKillA;
    global.achieveIcon[i] = "kzn_halo_triplekill.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_OVERKILL;
    global.achieveID[i] = "kzn_halo_overkill";
    global.achieveName[i] = "Overkill";
    global.achieveDesc[i] = "Kill 4 enemies within 4 seconds of each other.";
    global.achieveSprite[i] = OverkillA;
    global.achieveIcon[i] = "kzn_halo_overkill.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_KILLFRENZY;
    global.achieveID[i] = "kzn_halo_killfrenzy";
    global.achieveName[i] = "Killing Frenzy";
    global.achieveDesc[i] = "Kill 10 enemies in one life.";
    global.achieveSprite[i] = KillFrenzyA;
    global.achieveIcon[i] = "kzn_halo_killfrenzy.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_GRADUATE;
    global.achieveID[i] = "kzn_halo_graduate";
    global.achieveName[i] = "Graduate";
    global.achieveDesc[i] = "Win 10 games.";
    global.achieveSprite[i] = GraduateA;
    global.achieveIcon[i] = "kzn_halo_gradute.png";
    global.achieveEarnSteps[i] = 10;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "games won";
    global.achieveCount += 1;
    
    i = ACH_UNSCSPARTAN;
    global.achieveID[i] = "kzn_halo_unscspartan";
    global.achieveName[i] = "UNSC Spartan";
    global.achieveDesc[i] = "Win 20 games.";
    global.achieveSprite[i] = UNSCSpartanA;
    global.achieveIcon[i] = "kzn_halo_unscspartan.png";
    global.achieveEarnSteps[i] = 20;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "games won";
    global.achieveCount += 1;
    
    i = ACH_SPARTANOFFICER;
    global.achieveID[i] = "kzn_halo_spartanofficer";
    global.achieveName[i] = "Spartan Officer";
    global.achieveDesc[i] = "Win 50 games.";
    global.achieveSprite[i] = SpartanOfficerA;
    global.achieveIcon[i] = "kzn_halo_spartanofficer.png";
    global.achieveEarnSteps[i] = 50;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "games won";
    global.achieveCount += 1;
    
    i = ACH_POSTMORTEM;
    global.achieveID[i] = "kzn_halo_postmortem";
    global.achieveName[i] = "Post-Mortem";
    global.achieveDesc[i] = "Kill an opponent during respawn time.";
    global.achieveSprite[i] = PostMortemA;
    global.achieveIcon[i] = "kzn_halo_postmortem.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_MEATSHIELD;
    global.achieveID[i] = "kzn_halo_meatshield";
    global.achieveName[i] = "Meat Shield";
    global.achieveDesc[i] = "Kill an opponent using a Flood swarm.";
    global.achieveSprite[i] = MeatShieldA;
    global.achieveIcon[i] = "kzn_halo_meatshield.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_CATCHALL;
    global.achieveID[i] = "kzn_halo_ashketchum";
    global.achieveName[i] = "Gotta Catch 'em All";
    global.achieveDesc[i] = "Capture either 2 flags or 2 territories within 10 seconds of" + cr + "each other.";
    global.achieveSprite[i] = CatchAllA;
    global.achieveIcon[i] = "kzn_halo_ashketchum.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_RETURNSENDER;
    global.achieveID[i] = "kzn_halo_returntosender";
    global.achieveName[i] = "Return to Sender";
    global.achieveDesc[i] = "Kill an opponent using a reflected projectile.";
    global.achieveSprite[i] = ReturnSenderA;
    global.achieveIcon[i] = "kzn_halo_returntosender.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_ICARUS;
    global.achieveID[i] = "kzn_halo_icarus";
    global.achieveName[i] = "Too Close to the Sun";
    global.achieveDesc[i] = "Kill an opponent who is at least 25 feet in the air with an" + cr + "explosive.";
    global.achieveSprite[i] = IcarusA;
    global.achieveIcon[i] = "kzn_halo_icarus.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_STOPDROPGO;
    global.achieveID[i] = "kzn_halo_stopdropgo";
    global.achieveName[i] = "Stop, Drop and Go";
    global.achieveDesc[i] = "Restore your own shields to full after they drop below 25%.";
    global.achieveSprite[i] = StopDropGoA;
    global.achieveIcon[i] = "kzn_halo_stopdropgo.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_RAININGMEN;
    global.achieveID[i] = "kzn_halo_rainingmen";
    global.achieveName[i] = "It's Raining Spartans";
    global.achieveDesc[i] = "Score a Triple Kill with an explosive.";
    global.achieveSprite[i] = RainingMenA;
    global.achieveIcon[i] = "kzn_halo_rainingmen.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_PINKMIST;
    global.achieveID[i] = "kzn_halo_blueoystercult";
    global.achieveName[i] = "Fear the Pink Mist";
    global.achieveDesc[i] = "Kill 5 enemies in a single match with a needler.";
    global.achieveSprite[i] = PinkMistA;
    global.achieveIcon[i] = "kzn_halo_blueoystercult.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_FUNRESPAWN;
    global.achieveID[i] = "kzn_halo_havefunrespawning";
    global.achieveName[i] = "Have Fun Respawning";
    global.achieveDesc[i] = "Kill a newly-spawned opponent with an autoturret.";
    global.achieveSprite[i] = RespawnFunA;
    global.achieveIcon[i] = "kzn_halo_havefunrespawning.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_STEPPINRAZOR;
    global.achieveID[i] = "kzn_halo_steppinrazor";
    global.achieveName[i] = "Steppin' Razor";
    global.achieveDesc[i] = "Score a Triple Kill using an energy sword or gravity hammer.";
    global.achieveSprite[i] = SteppinRazorA;
    global.achieveIcon[i] = "kzn_halo_steppinrazor.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
    
    i = ACH_HEADHONCHO;
    global.achieveID[i] = "kzn_halo_headshothoncho";
    global.achieveName[i] = "Headshot Honcho";
    global.achieveDesc[i] = "Kill 10 enemies in one life with a sniper rifle.";
    global.achieveSprite[i] = HeadHonchoA;
    global.achieveIcon[i] = "kzn_halo_headshothoncho.png";
    global.achieveEarnSteps[i] = 1;
    global.achieveStep[i] = 0;
    global.achieveProgTerm[i] = "";
    global.achieveCount += 1;
}
