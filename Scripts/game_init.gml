// Returns true if the game is successfully initialized, false if there was an error and we should quit.
{
    instance_create(0,0,RoomChangeObserver);
    set_little_endian_global(true);
    if file_exists("game_errors.log") file_delete("game_errors.log");
    
    var customMapRotationFile, restart;
    restart = false;
    
    // create the persistent combined DLL controller (for FMOD and H2DLib)
    // NOTE: initializing of DLL-related things has been moved to that object
    instance_create(0, 0, DLLController);
    
    // create the debug controller object
    global.myself = -1;         // set it now, as it can be used in debug display
    instance_create(0, 0, DebugController);
    
    // load all the default sounds and music, and return false if there's an error
    if (!loadAllSounds()) return false;
    
    global.sendBuffer = buffer_create();
    global.tempBuffer = buffer_create();
    global.HudCheck = false;
    global.map_rotation = ds_list_create();
    
    global.CustomMapCollisionSprite = -1;
    
    window_set_region_scale(-1, false);
    
    ini_open("h2d.ini");
    global.playerName = ini_read_string("Settings", "PlayerName", "Player");
    if string_count("#",global.playerName) > 0 global.playerName = "Player";
    global.playerName = string_copy(global.playerName, 0, min(string_length(global.playerName), MAX_PLAYERNAME_LENGTH));
    global.fullscreen = ini_read_real("Settings", "Fullscreen", 0);
    global.useLobbyServer = ini_read_real("Settings", "UseLobby", 1);
    global.hostingPort = ini_read_real("Settings", "HostingPort", 8190);
    global.ingameMusic = ini_read_real("Settings", "IngameMusic", 1);
    global.playerLimit = ini_read_real("Settings", "PlayerLimit", 10);
    global.particles =  ini_read_real("Settings", "Particles", PARTICLES_NORMAL);
    global.gibLevel = ini_read_real("Settings", "Gib Level", 3);
    global.monitorSync = ini_read_real("Settings", "Monitor Sync", 0);
    global.logChatToFile = ini_read_real("Settings", "logChat", 1);
    if global.monitorSync == 1 set_synchronization(true);
    //user HUD settings
    global.clientPassword = "";
    // for admin menu
    customMapRotationFile = ini_read_string("Server", "MapRotation", "");
    global.timeLimitMins = max(1, min(255, ini_read_real("Server", "Time Limit", 15)));
    global.serverPassword = ini_read_string("Server", "Password", "");
    global.mapRotationFile = customMapRotationFile;
    global.dedicatedMode = ini_read_real("Server", "Dedicated", 0);
    global.serverName = ini_read_string("Server", "ServerName", "My Server");
    global.welcomeMessage = ini_read_string("Server", "WelcomeMessage", "");
    global.caplimit = max(1, min(255, ini_read_real("Server", "CapLimit", 5)));
    global.caplimitBkup = global.caplimit;
    global.autobalance = ini_read_real("Server", "AutoBalance",1);
    global.Server_RespawntimeSec = ini_read_real("Server", "Respawn Time", 5);
    global.mapdownloadLimitBps = ini_read_real("Server", "Total bandwidth limit for map downloads in bytes per second", 50000);
    global.updaterBetaChannel = ini_read_real("General", "UpdaterBetaChannel", isBetaVersion());
    global.attemptPortForward = ini_read_real("Server", "Attempt UPnP Forwarding", 0); 
    
    global.currentMapArea=1;
    global.totalMapAreas=1;
    global.setupTimer=1800;
    global.joinedServerName="";
        
    ini_write_string("Settings", "PlayerName", global.playerName);
    ini_write_real("Settings", "Fullscreen", global.fullscreen);
    ini_write_real("Settings", "UseLobby", global.useLobbyServer);
    ini_write_real("Settings", "HostingPort", global.hostingPort);
    ini_write_real("Settings", "IngameMusic", global.ingameMusic);
    ini_write_real("Settings", "PlayerLimit", global.playerLimit);
    ini_write_real("Settings", "Particles", global.particles);
    ini_write_real("Settings", "Gib Level", global.gibLevel);
    ini_write_real("Settings", "Monitor Sync", global.monitorSync);
    ini_write_real("Settings", "logChat", global.logChatToFile);
    ini_write_string("Server", "MapRotation", customMapRotationFile);
    ini_write_real("Server", "Dedicated", global.dedicatedMode);
    ini_write_string("Server", "ServerName", global.serverName);
    ini_write_string("Server", "WelcomeMessage", global.welcomeMessage);
    ini_write_real("Server", "CapLimit", global.caplimit);
    ini_write_real("Server", "AutoBalance", global.autobalance);
    ini_write_real("Server", "Respawn Time", global.Server_RespawntimeSec);
    ini_write_real("Server", "Total bandwidth limit for map downloads in bytes per second", global.mapdownloadLimitBps);
    ini_write_real("Server", "Time Limit", global.timeLimitMins);
    ini_write_string("Server", "Password", global.serverPassword);
    ini_write_real("General", "UpdaterBetaChannel", global.updaterBetaChannel);
    ini_write_real("Server", "Attempt UPnP Forwarding", global.attemptPortForward); 
    ini_close();
    
    //Server respawn time calculator. Converts each second to a frame. (read: multiply by 30 :hehe:)
    if (global.Server_RespawntimeSec == 0)
    {
        global.Server_Respawntime = 1;
    }    
    else
    {
        global.Server_Respawntime = global.Server_RespawntimeSec * 30;    
    }    
    
    // I have to include this, or the client'll complain about an unknown variable.
    global.mapchanging = false;
    
    // parse the protocol version UUID for later use
    global.protocolUuid = buffer_create();
    parseUuid(PROTOCOL_UUID, global.protocolUuid);
    
    global.gg2lobbyId = buffer_create();
    parseUuid(GG2_LOBBY_UUID, global.gg2lobbyId);
    
var a, IPRaw, portRaw;
doubleCheck=0;
global.launchMap = "";

    // TODO: See if we still need any of these command line options in the future
    for(a = 1; a <= parameter_count(); a += 1) 
    {
        if (parameter_string(a) == "-dedicated")
        {
            global.dedicatedMode = 1;
        }
        else if (parameter_string(a) == "-restart")
        {
            restart = true;
        }
        else if (parameter_string(a) == "-server")
        {
            IPRaw = parameter_string(a+1);
            if (doubleCheck == 1)
            {
                doubleCheck = 2;
            }
            else
            {
                doubleCheck = 1;
            }
        }
        else if (parameter_string(a) == "-port")
        {
            portRaw = parameter_string(a+1);
            if (doubleCheck == 1)
            {
                doubleCheck = 2;
            }
            else
            {
                doubleCheck = 1;
            }
        }
        /*
        else if (parameter_string(a) == "-map")
        {
            global.launchMap = parameter_string(a+1);
            global.dedicatedMode = 1;
        }
        */
    }
    
    if (doubleCheck == 2)
    {
        global.serverPort = real(portRaw);
        global.serverIP = IPRaw;
        global.isHost = false;
        instance_create(0,0,Client);
    }   
    
    global.customMapdesginated = 0;    
    
    // if the user defined a valid map rotation file, then load from there

    if (customMapRotationFile != "" && file_exists(customMapRotationFile) && global.launchMap == "") {
        global.customMapdesginated = 1;
        var fileHandle, i, mapname;
        fileHandle = file_text_open_read(customMapRotationFile);
        for(i = 1; !file_text_eof(fileHandle); i += 1) {
            mapname = file_text_read_string(fileHandle);
            // remove leading whitespace from the string
            while(string_char_at(mapname, 0) == " " || string_char_at(mapname, 0) == chr(9)) { // while it starts with a space or tab
              mapname = string_delete(mapname, 0, 1); // delete that space or tab
            }
            if(mapname != "" && string_char_at(mapname, 0) != "#") { // if it's not blank and it's not a comment (starting with #)
                // add it only if it's one of the supported map names
                switch (mapname) {
                    case "ctf_truefort":
                    case "ctf_2dfort":
                    case "ctf_conflict":
                    case "ctf_classicwell":
                    case "ctf_waterway":
                    case "ctf_orange":
                    case "cp_dirtbowl":
                    case "cp_egypt":
                    case "arena_montane":
                    case "arena_lumberyard":
                    case "gen_destroy":
                    case "koth_valley":
                    case "koth_harvest":
                    case "dkoth_atalia":
                    case "dkoth_sixties":
                        ds_list_add(global.map_rotation, mapname);
                        break;
                }
            }
            file_text_readln(fileHandle);
        }
        file_text_close(fileHandle);
        
        // if the list ended up being empty, use the internally predefined rotation
        if (ds_list_size(global.map_rotation) == 0) {
            initMapRotation();
        }
    /*
    } else if (global.launchMap != "") && (global.dedicatedMode == 1) {  
        ds_list_add(global.map_rotation, global.launchMap);
    */
    } else {
        // else use an internally predefined rotation
        initMapRotation();
    }
    
    window_set_fullscreen(global.fullscreen);
    
    //global.gg2Font = font_add_sprite(gg2FontS,ord("!"),false,0);
    //draw_set_font(global.gg2Font);
    draw_set_font(fnt_gg2);
    // create the cursor object
    instance_create(0, 0, Cursor);
    Cursor.sprite_index = CrosshairS;
    
    if(!directory_exists(working_directory + "\Maps")) directory_create(working_directory + "\Maps");
    
    instance_create(0, 0, AudioControl);
    instance_create(0, 0, SSControl);
    
    // custom dialog box graphics
    message_background(popupBackgroundB);
    message_button(popupButtonS);
    message_text_font("Century",9,c_white,1);
    message_button_font("Century",9,c_white,1);
    message_input_font("Century",9,c_white,0);
    
    // Key Mapping
    ini_open("controls.h2d");
    global.keyJump = ini_read_real("Controls", "jump", ord(" "));
    global.keyUp = ini_read_real("Controls", "up", ord("W"));
    global.keyDown = ini_read_real("Controls", "down", ord("S"));
    global.keyLeft = ini_read_real("Controls", "left", ord("A"));
    global.keyRight = ini_read_real("Controls", "right", ord("D"));
    global.keyAttack = ini_read_real("Controls", "attack", MOUSE_LEFT);
    global.keyGrenade = ini_read_real("Controls", "grenade", MOUSE_RIGHT);
    global.keyPickup = ini_read_real("Controls", "pickup", ord("F"));
    global.keyReload = ini_read_real("Controls", "reload", ord("R"));
    global.keySwapGun = ini_read_real("Controls", "swapGun", ord("Q"));
    global.keySwapGrenade = ini_read_real("Controls", "swapGrenade", ord("E"));
    global.keyMelee = ini_read_real("Controls", "melee", ord("C"));
    global.keyChat1 = ini_read_real("Controls", "chat1", ord("Z"));
    global.keyChat2 = ini_read_real("Controls", "chat2", ord("X"));
    global.keyChangeTeam = ini_read_real("Controls", "changeTeam", ord("N"));
    global.keyShowScores = ini_read_real("Controls", "showScores", vk_lshift);
    global.keyScope = ini_read_real("Controls", "scope", MOUSE_MIDDLE);
    ini_close();
    
    // init custom colors before loading the profile
    initCustomArmor();
    
    // Profile
    ini_open("profile.ini");
    global.customArmorColor = ini_read_real("Profile", "armorColor", 0);
    global.customHelmetColor = ini_read_real("Profile", "helmetColor", 0);
    global.customArmorType = ini_read_real("Profile", "armorType", 0);
    global.customHelmetType = ini_read_real("Profile", "helmetType", 0);
    global.customShoulderType = ini_read_real("Profile", "shoulderType", 0);
    global.customAccessoryType = ini_read_real("Profile", "accessoryType", 0);
    
    ini_write_real("Profile", "armorColor", global.customArmorColor);
    ini_write_real("Profile", "helmetColor", global.customHelmetColor);
    ini_write_real("Profile", "armorType", global.customArmorType);
    ini_write_real("Profile", "helmetType", global.customHelmetType);
    ini_write_real("Profile", "shoulderType", global.customShoulderType);
    ini_write_real("Profile", "accessoryType", global.customAccessoryType);
    ini_close();
    
    calculateMonthAndDay();
    
    if(global.dedicatedMode == 1) {
        AudioControlToggleMute();
        room_goto_fix(Menu);
    } else if(restart) {
        room_goto_fix(Menu);
    }
    
    // initialize the Heads functionality data
    initHeads();
    // initialize the particle system controller and data
    instance_create(0, 0, ParticleController);
    // init the weapon global data
    initWeapons();

    // initialize the Achievment data
    achieveInit();
    // set the current ambient sound ID
    global.ambienceID = 0;
    // initialize the chat data
    initChat();
    
    return true;
}
