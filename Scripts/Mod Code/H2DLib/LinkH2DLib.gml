// Link to the H2DLib DLL, must be called before ANY H2DLib functions are called!
{
    // check to make sure the DLLs exist first
    if !file_exists("H2DLib.dll") {
        show_message("File not found: H2DLib.dll#In directory: " + working_directory);
        game_end();
    }
    
    // Link the functions
    global.dll_H2DGetForegroundWindow = external_define("H2DLib.dll", "GetForegroundWindowHandle", dll_cdecl, ty_real, 0);
    global.dll_H2DFindLineIntersection = external_define("H2DLib.dll", "FindLineIntersection", dll_cdecl, ty_real, 6, ty_real, ty_real, ty_real, ty_real, ty_real, ty_real);
    global.dll_H2DGetLineIntersectResultX = external_define("H2DLib.dll", "GetLineIntersectResultX", dll_cdecl, ty_real, 0);
    global.dll_H2DGetLineIntersectResultY = external_define("H2DLib.dll", "GetLineIntersectResultY", dll_cdecl, ty_real, 0);
}
