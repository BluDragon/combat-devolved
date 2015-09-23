    // Record kill in killlog
    // argument0: The killed player
    // argument1: The killer, or a false value for suicides
    // argument2: The assistant, or a false value for no assist
    // argument3: The source of the damage (e.g. WEAPON_SCATTERGUN)
    
    // modified to remove all kill sprites and replace with "Player A killed Player B"
    // modified to treat player self-kills (i.e. demoman and rocket) as suicides
      
        with (KillLog) {
            map = ds_map_create();

            if (!argument1 || argument1==argument0) {
                ds_map_add(map, "name1", "");
                ds_map_add(map, "team1", 0);
                // if the player killed himself, then switch damage source to BID_FAREWELL
                if (argument1 == argument0) argument3 = BID_FAREWELL;
            } else {
                var killer;
                killer = string_copy(argument1.name, 1, 20);
                if (argument2)
                    killer += " + " + string_copy(argument2.name, 1, 20);
                ds_map_add(map, "name1", killer);
                ds_map_add(map, "team1", argument1.team);
            }            
            ds_map_add(map, "name2", string_copy(argument0.name, 1, 20));
            ds_map_add(map, "team2", argument0.team);
            
            if (argument0 == global.myself || argument1 == global.myself || argument2 == global.myself) 
                ds_map_add(map, "inthis", true);
            else ds_map_add(map, "inthis", false);
            ds_map_add(map, "weapon", -1);  // no icons EVER in Halo Mod
            ds_map_add(map, "string", "");  // default to no comment
            
            switch(argument3) {
                case WEAPON_BATTLERIFLE:
                case WEAPON_CARBINE:
                case WEAPON_MAGNUM:
                case WEAPON_SNIPERRIFLE:
                case WEAPON_BEAMRIFLE:
                case WEAPON_MAULER:
                case WEAPON_SPARTANLASER:
                case WEAPON_MGTURRET:
                case WEAPON_SMG:
                case WEAPON_ASSAULTRIFLE:
                case WEAPON_SHOTGUN:
                case WEAPON_ROCKETLAUNCHER:
                case WEAPON_NEEDLER:
                case WEAPON_BRUTESHOT:
                case WEAPON_SPIKER:
                case WEAPON_FUELRODCANNON:
                case WEAPON_PLASMACANNON:
                case WEAPON_PLASMARIFLE:
                case WEAPON_GRAVITYHAMMER:
                case WEAPON_ENERGYSWORD:
                case WEAPON_PLASMAGRENADE:
                case WEAPON_FRAGGRENADE:
                case WEAPON_SPIKEGRENADE:
                case WEAPON_FIREBOMB:
                case MELEE_STRIKE:
                case MELEE_BACKSTAB:
                    ds_map_replace(map, "string", " killed ");
                    break;
                case KILL_BOX:
                case FRAG_BOX:
                    if (!argument1 || argument1==argument0) {
                        ds_map_replace(map, "string", string_copy(argument0.name, 1, 20) + " was killed by the Guardians.");
                        ds_map_replace(map, "name2", "");
                        ds_map_replace(map, "team2", 0);
                        break;
                    }
                case PITFALL:
                    ds_map_replace(map, "string", string_copy(argument0.name, 1, 20) + " was killed by the Guardians.");
                    ds_map_replace(map, "name2", "");
                    ds_map_replace(map, "team2", 0);
                    break;          
                case FINISHED_OFF:
                case FINISHED_OFF_GIB:
                    ds_map_replace(map, "string", " finished off ");
                    break;
                case BID_FAREWELL:
                    ds_map_replace(map, "string", string_copy(argument0.name, 1, 20) + " committed suicide.");
                    ds_map_replace(map, "name2", "");
                    ds_map_replace(map, "team2", 0);
                    break;
                case GENERATOR_EXPLOSION:
                    // Generator deaths aren't mentioned in Halo Mod
                    //ds_map_replace(map, "string", " GEN EXPLODE ");
                    // destroy the map we were making, it's not going to be used
                    ds_map_destroy(map);
                    // and forget this ever happened >.>
                    exit;
                    break;
                default:
                    ds_map_replace(map, "string", " - UNKNOWN DEATH - ");
                    break;            
            }
            
            ds_list_add(kills, map);
            
            if (ds_list_size(kills) > 5) {
                ds_map_destroy(ds_list_find_value(kills, 0));
                ds_list_delete(kills, 0);
            }
            
            alarm[0] = 30*5;
        }
