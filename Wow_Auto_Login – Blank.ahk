#SingleInstance Force
SetTitleMatchMode 2  ; Allow partial match for window title

; Define hotkeys
Hotkey, F1, Login1
Hotkey, F2, Login2
Hotkey, F3, Login3
Hotkey, F4, Login4

Hotkey, F10, ToggleSpam

return  ; Prevents script from exiting immediately

Login1:
    Login("", "")
return

Login2:
    Login("", "")
return

Login3:
    Login("", "")
return

Login4:
    Login("", "")
return

; Function to log in ONLY on the character select screen
Login(user, pass) {
    ; Refresh the WoW window list
    WinGet, wowid, List, World of Warcraft
    
    ; Define the pixel color and location (replace with your own values)
    targetX := 1029   ; X coordinate (update with your F12 test result)
    targetY := 750    ; Y coordinate (update with your F12 test result)
    targetColor := 0x5B0302  ; Replace with actual color from PixelGetColor test
    
    ; Search for the color
    PixelSearch, foundX, foundY, targetX, targetY, targetX, targetY, targetColor, 5, RGB
    if ErrorLevel {
        MsgBox, You're in-game! Logins only work on the character select screen.
        return
    }

    ; Loop through WoW instances and check active window
    Loop, %wowid%
    {
        this_id := wowid%A_Index%
        
        if WinActive("ahk_id " this_id)
        {
            Send, %user%
            Sleep, 200
            Send, {Tab}
            Sleep, 200
            Send, %pass%
            Sleep, 200
            Send, {Enter}
            return  
        }
    }

    MsgBox, You're in-game! Logins only work on the character select screen. Make sure the login button is not highlighted, as we're using pixel capture function!
}

; Function to toggle spamming 'End' key every 200ms
KeepSpamming := false
ToggleSpam:
    KeepSpamming := !KeepSpamming  ; Toggle state
    if KeepSpamming {
        SetTimer, SpamEndKey, 200
    } else {
        SetTimer, SpamEndKey, Off
    }
return

SpamEndKey:
    WinGet, wowid, List, World of Warcraft
    ControlSend,, {End}, ahk_id %wowid1%
return
