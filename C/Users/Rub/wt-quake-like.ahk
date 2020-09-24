;; Taken from https://github.com/ehpc/quake-windows-bash
;; but replaced bash.exe with WindowsTerminal.exe 
;; improved to launch terminal if not opened, and also to make active if the window is simply out of focus
;; relies on a shortcut that makes the terminal launch with a few options
;; but if you don't want the shortcut option you can replace Shortcut with BashHandle

;; Quake-style bash toggler for AutoHotkey.
;; Uses standard minimization/restoring animations.
;; ehpc@ehpc.io

#SingleInstance force

;handles
BashHandle = ahk_exe WindowsTerminal.exe
Shortcut = "C:\Users\Rub\wt.exe.lnk"


; On CTRL+` press
^`::
    WinGet, wList, List, %BashHandle%
    if !wList{ ; if no windows exist
        ; just use BashHandle if you don't want to go the route of using a shortcut (for the extra options)
       Run, %Shortcut%
       return
    }


    WinGet, mx, MinMax, %BashHandle%

    ; If window is minimized, restore it
    if (mx = -1)
    {
        WinRestore, %BashHandle%

        ; Uncomment these lines to overcome tmux/vim rendering bug
        ; ControlSend, , ^{VK42}, %BashHandle%
        ; ControlSend, , {VK52}, %BashHandle%
    }

    ; if window is active, minimize it
    else if WinActive(BashHandle)
    {
       WinMinimize, %BashHandle%
    }

    ; Otherwise focus it
    else
    {
        WinActivate, %BashHandle%
    }
Return
