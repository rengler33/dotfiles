" Turn on visualbell to override bell sound (WSL/Windows annoying ding)
set visualbell
" Set length to 0 to avoid the visual flashing that comes with visualbell
set t_vb=

" WSL yank support to enable copying to Windows clipboard from Vim using "*y command
let s:clip = '/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
