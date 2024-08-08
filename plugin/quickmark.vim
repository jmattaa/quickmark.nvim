if exists('g:quickmark_init') | finish | endif " so we don't init more than once 
" coz that be happening

let s:save_cpo = &cpo " save the users options
set cpo&vim " use the default vim options

" Highlighting
hi def link QuickmarkTitle Identifier
highlight QuickmarkInfo guifg=Yellow 

" Quickmark command
command! -nargs=+ -complete=customlist,QuickmarkComplete Quickmark :call QuickmarkCmd(<f-args>)

function! QuickmarkComplete(ArgLead, CmdLine, CursorPos)
    " this ain't stuff from me
    " but from the butiful internet
    " ArgLead: command name (string)
    " CmdLine: string to be completed (string)
    " CursorPos: position of cursor (number)

    let candidates = ['list', 'add', 'shortcut', 'save', 'remove', 'remove_all']

    " filter the candidates based on the input
    let filtered_candidates = filter(candidates, 'v:val =~# "^" . escape(a:ArgLead, "\\")')

    " return the filtered candidates
    return filtered_candidates
endfunction

function! QuickmarkCmd(...)
    if a:1 == "list" 
        execute "lua require'quickmark'.quickmarks_list()" 
    elseif a:1 == "add"
        execute "lua require'quickmark'.quickmark_add()" 
    elseif a:1 == "shortcut"
        if a:0 < 2
            echohl ErrorMsg
            echo 'Quickmark: Provide a shortcut key for the shortcut'
            echohl None
            return
        endif
        execute "lua require'quickmark'.quickmark_shortcut(" . a:2 . ")"
    elseif a:1 == "remove"
        execute "lua require'quickmark'.quickmark_remove_f()"
    elseif a:1 == "remove_all"
        execute "lua require'quickmark'.quickmarks_removeall()"
    elseif a:1 == "save"
        execute "lua require'quickmark'.quickmarks_save()"
    else 
        " i give you completion and you manage to get here
        " wow
        echohl ErrorMsg
        echo 'Quickmark: Unkown command'
        echohl None
    endif
endfunction

let &cpo = s:save_cpo " restore the options
unlet s:save_cpo

let g:quickmark_init = 1

