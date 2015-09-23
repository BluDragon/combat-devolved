/* Returns the name of a key in the form of a string
**
** argument0 = The keycode of the key in question
**
*/
{
    var val;
    
    switch (argument0) {
        case vk_add:
            val = "Numpad +";
            break;
        case vk_alt:
            val = "Alt";
            break;
        case vk_backspace:
            val = "Backspace";
            break;
        case vk_control:
            val = "Control";
            break;
        case vk_decimal:
            val = "Numpad .";
            break;
        case vk_delete:
            val = "Delete";
            break;
        case vk_divide:
            val = "Numpad /";
            break;
        case vk_down:
            val = "Down";
            break;
        case vk_end:
            val = "End";
            break;
        case vk_enter:
            val = "Enter";
            break;
        case vk_escape:
            val = "Escape";
            break;
        case vk_f1:
            val = "F1";
            break;
        case vk_f2:
            val = "F2";
            break;
        case vk_f3:
            val = "F3";
            break;
        case vk_f4:
            val = "F4";
            break;
        case vk_f5:
            val = "F5";
            break;
        case vk_f6:
            val = "F6";
            break;
        case vk_f7:
            val = "F7";
            break;
        case vk_f8:
            val = "F8";
            break;
        case vk_f9:
            val = "F9";
            break;
        case vk_f10:
            val = "F10";
            break;
        case vk_f11:
            val = "F11";
            break;
        case vk_f12:
            val = "F12";
            break;
        case vk_home:
            val = "Home";
            break;
        case vk_insert:
            val = "Insert";
            break;
        case vk_lalt:
            val = "Left Alt";
            break;
        case vk_lcontrol:
            val = "Left Control";
            break;
        case vk_left:
            val = "Left";
            break;
        case vk_lshift:
            val = "Left Shift";
            break;
        case vk_multiply:
            val = "Numpad *";
            break;
        case vk_numpad0:
            val = "Numpad 0";
            break;
        case vk_numpad1:
            val = "Numpad 1";
            break;
        case vk_numpad2:
            val = "Numpad 2";
            break;
        case vk_numpad3:
            val = "Numpad 3";
            break;
        case vk_numpad4:
            val = "Numpad 4";
            break;
        case vk_numpad5:
            val = "Numpad 5";
            break;
        case vk_numpad6:
            val = "Numpad 6";
            break;
        case vk_numpad7:
            val = "Numpad 7";
            break;
        case vk_numpad8:
            val = "Numpad 8";
            break;
        case vk_numpad9:
            val = "Numpad 9";
            break;
        case vk_pagedown:
            val = "Page Down";
            break;
        case vk_pageup:
            val = "Page Up";
            break;
        case vk_pause:
            val = "Pause";
            break;
        case vk_printscreen:
            val = "Print Screen";
            break;
        case vk_ralt:
            val = "Right Alt";
            break;
        case vk_rcontrol:
            val = "Right Control";
            break;
        case vk_return:
            val = "Return";
            break;
        case vk_right:
            val = "Right";
            break;
        case vk_rshift:
            val = "Right Shift";
            break;
        case vk_shift:
            val = "Shift";
            break;
        case vk_space:
            val = "Space";
            break;
        case vk_subtract:
            val = "Numpad -";
            break;
        case vk_tab:
            val = "Tab";
            break;
        case vk_up:
            val = "Up";
            break;
        case MOUSE_LEFT:
            val = "Left Mouse Button";
            break;
        case MOUSE_RIGHT:
            val = "Right Mouse Button";
            break;
        case MOUSE_MIDDLE:
            val = "Middle Mouse Button";
            break;
        default:
            val = chr(argument0);
            break;
    }
    
    return val;
}
