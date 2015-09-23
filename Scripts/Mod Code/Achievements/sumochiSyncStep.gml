// Step event for Sumochi Sync Controller
{
    var text, result;
    
    // increment the animation step
    animStep = (animStep + 1) mod 30;
    
    // if we're done, move to the proper room or quit
    if (done) {
        if (global.sumochiSyncReturn == -1) {
            game_end();
        } else {
            room_goto_fix(global.sumochiSyncReturn);
            exit;
        }
    }
    
    // only proceed if a step has run, a download is not in progress, and we're not done!
    if (stepHasRun && DM_DownloadStatus(handle) != 1 && DM_DownloadStatus(handle) != 2) {
        
        // handle the current function
        if (global.sumochiSyncFunc == SUMOSYNC_LOAD) {
            // load the local copy if it's not been done already
            if (!localComplete) {
                loadAchievements();
                localComplete = true;
                
                // if we're in offline mode, we're done
                if (global.achieveOfflineMode) {
                    done = true;
                    exit;
                }
            }
            
            // login
            if (!loggedIn) {
                if (DM_DownloadStatus(handle) == 0) {
                    // build the URL
                    url = SUMOCHI_ENDPOINT + "?p=api_login&user=" + sumochiSanitize(global.achieveAccountName) + "&password=" + sumochiSanitize(global.achieveAccountPass);
                    handle = DM_CreateDownload(url, tempFile);
                    DM_StartDownload(handle);
                    
                } else if (DM_DownloadStatus(handle) == 3) {
                    // done with the login
                    DM_StopDownload(handle);
                    DM_CloseDownload(handle);
                    
                    // load the file
                    if(file_exists(tempFile)) {
                        handle = file_text_open_read(tempFile);
                        text = '';
                        while (!file_text_eof(handle)) {
                            text += file_text_read_string(handle);
                            file_text_readln(handle);
                        }
                        file_text_close(handle);
                        file_delete(tempFile);
                    } else {
                        // no file?  we're in trouble!
                        show_message("Critical Error loading achievements!");
                        game_end();
                    }
                    
                    // clear the handle
                    handle = -1;
                    
                    // parse the results
                    result = string_copy(text, string_pos(" ", text) + 1, string_length(text) - string_pos(" ", text));
                    text = string_upper(string_copy(text, 0, string_pos(" ", text) - 1));
                    
                    if (text == "SUCCESS") {
                        // got the login token
                        loggedIn = true;
                        global.sumochiLoginToken = result;
                    } else {
                        // error, handle the reason
                        if (result == "gg2_login_failed") {
                            show_message("Login to Sumochi failed.  Your username/password may be incorrect, or Sumochi or the GG2F are having issues.");
                        } else if (result == "no_sumochi_user") {
                            show_message("Sumochi user does not exist.  You will need to log into Sumochi to create your user account.  Check the Achievement settings for details.");
                        } else {
                            show_message("Unknown error logging into Sumochi: " + result);
                        }
                        
                        global.sumochiSynced = false;
                        done = true;
                        exit;
                    }
                }   // END DOWNLOAD DONE
                
            } else {  // ELSE LOGGED IN
                var i, cheevoList, dList;
                
                // logged in successfully, load the cheevos
                if (DM_DownloadStatus(handle) == 0) {
                    // build the list of cheevos to inquire about
                    dList = ds_list_create();
                    for (i = 0; i < global.achieveCount; i += 1) {
                        ds_list_add(dList, global.achieveID[i]);
                    }
                    cheevoList = sumochi_make_csv(dList);
                    ds_list_destroy(dList);
                    
                    // build the URL
                    url = SUMOCHI_ENDPOINT + "?p=api_has_achievements&user=" + sumochiSanitize(global.achieveAccountName) + "&token=" + sumochiSanitize(global.sumochiLoginToken) +
                        "&key=" + SUMOCHI_KEY + "&a_ids=" + cheevoList;
                    handle = DM_CreateDownload(url, tempFile);
                    DM_StartDownload(handle);

                } else if (DM_DownloadStatus(handle) == 3) {
                    // done with the inquiry
                    DM_StopDownload(handle);
                    DM_CloseDownload(handle);
                    
                    // load the file
                    if(file_exists(tempFile)) {
                        handle = file_text_open_read(tempFile);
                        text = '';
                        while (!file_text_eof(handle)) {
                            text += file_text_read_string(handle);
                            file_text_readln(handle);
                        }
                        file_text_close(handle);
                        file_delete(tempFile);
                    } else {
                        // no file?  we're in trouble!
                        show_message("Critical Error loading achievements!");
                        game_end();
                    }
                    
                    // clear the handle
                    handle = -1;
                    
                    // clear the achievement save queue
                    ds_queue_clear(global.achieveSaveQueue);
                    
                    // parse the results
                    result = string_copy(text, string_pos(" ", text) + 1, string_length(text) - string_pos(" ", text));
                    text = string_upper(string_copy(text, 0, string_pos(" ", text) - 1));
                    
                    if (text == "SUCCESS") {
                        var sumochiValue;
                        
                        // parse the results and merge the local and Sumochi copies
                        dList = sumochi_parse_csv(result);
                        
                        for (i = 0; i < global.achieveCount; i += 1) {
                            // figure out the value
                            sumochiValue = 0;
                            if (ds_list_find_value(dList, i) == "TRUE") {
                                sumochiValue = global.achieveEarnSteps[i];
                            } else if (global.achieveStep[i] >= global.achieveEarnSteps[i]) {
                                // Sumochi says we don't have it
                                // and the local says we DO, add it to the save queue
                                ds_queue_enqueue(global.achieveSaveQueue, i);
                            }
                            
                            // merge them
                            global.achieveStep[i] = max(global.achieveStep[i], sumochiValue);
                        }
                        
                        // finished loading cheevos, we successfully synced with Sumochi
                        global.sumochiSynced = true
                        done = true;
                        exit;
                    } else {
                        // error, handle the reason
                        if (result == "gg2_login_failed") {
                            show_message("Login to Sumochi failed.  Your username/password may be incorrect, or Sumochi or the GG2F are having issues.");
                        } else if (result == "no_sumochi_user") {
                            show_message("Sumochi user does not exist.  You will need to log into Sumochi to create your user account.  Check the Achievement settings for details.");
                        } else {
                            show_message("Unknown error getting Achievement list from Sumochi: " + result);
                        }
                        
                        global.sumochiSynced = false;
                        done = true;
                        exit;
                    }
                }
            }
            
        } else if (global.sumochiSyncFunc == SUMOSYNC_SAVE) {
            // save the local copy if it's not been done already
            if (!localComplete) {
                saveAchievements();
                localComplete = true;
            }
            
            if (!global.sumochiSynced) || (global.achieveOfflineMode) {
                // we had not successfully synced, so just end here after saving the local
                // or we're just in offline mode, so end here anyways
                done = true;
                exit;
            }
            
            // iterate through the cheevo save queue and save them to Sumochi
            if (DM_DownloadStatus(handle) == 0) {
                var i;
                
                // if there's nothing left in the queue, we're done
                if (ds_queue_size(global.achieveSaveQueue) == 0) {
                    done = true;
                    exit;
                }
                
                // build the URL
                i = ds_queue_dequeue(global.achieveSaveQueue);
                url = SUMOCHI_ENDPOINT + "?p=api_give_achievement&user=" + sumochiSanitize(global.achieveAccountName) +
                    "&token=" + sumochiSanitize(global.sumochiLoginToken) +
                    "&key=" + SUMOCHI_KEY +
                    "&a_id=" + sumochiSanitize(global.achieveID[i]) +
                    "&a_name=" + sumochiSanitize(SUMOCHI_PREFIX + global.achieveName[i]) +
                    "&a_icon=" + sumochiSanitize(global.achieveIcon[i]);
                
                // start the download
                handle = DM_CreateDownload(url, tempFile);
                DM_StartDownload(handle);
                
            } else if (DM_DownloadStatus(handle) == 3) {
                // done with the save
                DM_StopDownload(handle);
                DM_CloseDownload(handle);
                
                // load the file
                if(file_exists(tempFile)) {
                    handle = file_text_open_read(tempFile);
                    text = '';
                    while (!file_text_eof(handle)) {
                        text += file_text_read_string(handle);
                        file_text_readln(handle);
                    }
                    file_text_close(handle);
                    file_delete(tempFile);
                } else {
                    // no file?  we're in trouble!
                    show_message("Critical Error loading achievements!");
                    game_end();
                }
                
                // clear the handle
                handle = -1;
                
                // parse the results
                result = string_copy(text, string_pos(" ", text) + 1, string_length(text) - string_pos(" ", text));
                text = string_upper(string_copy(text, 0, string_pos(" ", text) - 1));
                
                // only need to handle errors
                if (text == "ERROR") {
                    // handle the reasons
                    if (result == "already_has_achievement") {
                        // the cheevo was already earned, so that's fine
                    } else if (result == "unknown_key") {
                        show_message("Unknown server key.");
                        done = true;
                        exit;
                    } else if (result == "invalid_token") {
                        show_message("Invalid login token.");
                        done = true;
                        exit;
                    } else {
                        show_message("Unknown server error: " + result);
                        done = true;
                        exit;
                    }
                }
            }

        } else {
            // unknown function
            show_message("Unknown Sync Function call!");
            game_end();
        }
    }
    
    // check for done-ness on the next step
}
