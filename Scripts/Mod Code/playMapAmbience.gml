// Plays the approrpiate ambience for the current map
{
    var amb;
    
    switch (global.currentMap) {
        case "ctf_truefort":
        case "ctf_2dfort":
        case "ctf_2dfort2":
        case "ctf_2dfortremix":
            amb = global.TruefortAmb;
            break;
        case "ctf_conflict":
        case "koth_valley":
            amb = global.ConflictAmb;
            break;
        case "ctf_classicwell":
            amb = global.ClassicwellAmb;
            break;
        case "ctf_waterway":
            amb = global.WaterwayAmb;
            break;
        case "ctf_orange":
            amb = global.OrangeAmb;
            break;
        case "cp_dirtbowl":
        case "gen_destroy":
            amb = global.DirtbowlAmb;
            break;
        case "cp_egypt":
            amb = global.EgyptAmb;
            break;
        case "arena_montane":
            amb = global.MontaneAmb;
            break;
        case "arena_lumberyard":
        case "koth_harvest":
            amb = global.LumberyardAmb;
            break;
        case "koth_corinth":
            amb = global.CorinthAmb;
            break;
        case "dkoth_atalia":
            amb = global.AtaliaAmb;
            break;
        case "dkoth_sixties":
        case "dkoth_60s":
            amb = global.SixtiesAmb;
            break;
        default:
            global.ambienceID = 0;
            exit;
    }
    
    global.ambienceID = FMODSoundLoop(amb);
}
