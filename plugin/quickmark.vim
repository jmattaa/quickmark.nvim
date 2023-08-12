if exists('g:quickmark_init') | finish | endif " so we don't init more than once 
" coz that be happening

let s:save_cpo = &cpo " save the users options
set cpo&vim " use the default vim options

" Quickmark command
command! -nargs=+ -complete=customlist,QuickmarkComplete Quickmark :call QuickmarkCmd(<f-args>)

function! QuickmarkComplete(ArgLead, CmdLine, CursorPos)
    " this ain't stuff from me
    " but from the butiful internet
    " ArgLead: command name (string)
    " CmdLine: string to be completed (string)
    " CursorPos: position of cursor (number)

    let candidates = ['list', 'add']

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
