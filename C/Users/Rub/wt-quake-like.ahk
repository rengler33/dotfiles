;; Taken from https://github.com/ehpc/quake-windows-bash
;; but replaced bash.exe with WindowsTerminal.exe 

;; Quake-style bash toggler for AutoHotkey.
;; Uses standard minimization/restoring animations.
;; ehpc@ehpc.io

#SingleInstance force

; Bash process handle
BashHandle = ahk_exe WindowsTerminal.exe

; On CTRL+` press
^`::
    WinGet, mx, MinMax, %BashHandle%
    ; If window is minimized, restore it
    if (mx = -1)
    {
        WinRestore, %BashHandle%

        ; Uncomment these lines to overcome tmux/vim rendering bug
        ; ControlSend, , ^{VK42}, %BashHandle%
        ; ControlSend, , {VK52}, %BashHandle%
    }
    ; Otherwise minimize it
    else
    {
        WinMinimize, %BashHandle%
    }
Return
