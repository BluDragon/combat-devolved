    // Record destruction in killlog
    // argument0: The owner of the destroyed building
    // argument1: The killer
    // argument2: The healer, or -1 for no assist
    // argument3: The source of the damage (e.g. WEAPON_SCATTERGUN)
    
    // modified to remove all sprites
        with (KillLog) {
            map = ds_map_create();
            var killer;
            killer = string_copy(argument1.name, 1, 20);
            if (argument2 != -1)
                killer += " + " + string_copy(argument2.name, 1, 20);
            ds_map_add(map, "name1", killer);
            ds_map_add(map, "team1", argument1.team);           
            ds_map_add(map, "name2", "Autogun (" + string_copy(argument0.name, 1, 20) + ")");
            ds_map_add(map, "team2", argument0.team);
            
            if (argument0 == global.myself || argument1 == global.myself || argument2 == global.myself) 
                ds_map_add(map, "inthis", true);
            else ds_map_add(map, "inthis", false);
            ds_map_add(map, "weapon", -1);  // no icons EVER in Halo Mod
            ds_map_add(map, "string", "");
            
            switch(argument3) {
                case WEAPON_NEEDLEGUN:
                case WEAPON_RIFLE:
                case WEAPON_RIFLE_CHARGED:
                case WEAPON_MINEGUN:
                case WEAPON_MINIGUN:
                case WEAPON_FLAMETHROWER:
                case WEAPON_SCATTERGUN:
                case WEAPON_SHOTGUN:
                case WEAPON_QROCKETLAUNCHER:
                case WEAPON_ROCKETLAUNCHER:
                case WEAPON_REVOLVER:
                case WEAPON_SENTRYTURRET:
                case WEAPON_BLADE:
                case WEAPON_BUBBLE:
                case WEAPON_REFLECTED_ROCKET:
                case WEAPON_REFLECTED_STICKY:
                case WEAPON_BACKSTAB:                   
                case WEAPON_KNIFE:
                case WEAPON_FLARE:
                case WEAPON_REFLECTED_FLARE:
                    ds_map_replace(map, "string", " killed ");
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
