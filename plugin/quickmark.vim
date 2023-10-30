if exists('g:quickmark_init') | finish | endif " so we don't init more than once 
" coz that be happening

let s:save_cpo = &cpo " save the users options
set cpo&vim " use the default vim options

" Highlighting
hi def link QuickmarkInfo Comment
hi def link QuickmarkTitle Identifier

" Quickmark command
command! -nargs=+ -complete=customlist,QuickmarkComplete Quickmark :call QuickmarkCmd(<f-args>)

function! QuickmarkComplete(ArgLead, CmdLine, CursorPos)
    " this ain't stuff from me
    " but from the butiful internet
    " ArgLead: command name (string)
    " CmdLine: string to be completed (string)
    " CursorPos: position of cursor (number)

    let candidates = ['list', 'add', 'shortcut', 'save', 'remove', 'removeAll']

    " filter the candidates based on the input
    let filtered_candidates = filter(candidates, 'v:val =~# "^" . escape(a:ArgLead, "\\")')

    " return the filtered candidates
    return filtered_candidates
endfunction

function! QuickmarkSetKeymaps()
    let i = 0
    let [shortcuts, quickmarks] = luaeval("require'quickmark'.quickmark_getShortcuts()")
    for shortcut in shortcuts
        execute 'nnoremap <silent> <leader>qo' . shortcut . ' :e ' . quickmarks[i] . '<CR>'
        let i = i + 1
    endfor
endfunction

function! QuickmarkCreateShortcut()
    let shortcut = nr2char(getchar())
    if shortcut == ''
        return
    endif

    execute 'Quickmark shortcut ' . "'" . shortcut . "'"
    call QuickmarkSetKeymaps()
    echo "Quickmark: Added shortcut: " . shortcut 
endfunction

function! QuickmarkCmd(...)
    if a:1 == "list" 
        execute "lua require'quickmark'.quickmarks_list()" 
        call QuickmarkSetKeymaps()
    elseif a:1 == "add"
        execute "lua require'quickmark'.quickmark_add()" 
        call QuickmarkSetKeymaps()
    elseif a:1 == "shortcut"
        if a:0 < 2
            echohl ErrorMsg
            echo 'Quickmark: Provide a shortcut key for the shortcut'
            echohl None
            return
        endif
        execute "lua require'quickmark'.quickmark_shortcut(" . a:2 . ")"
    elseif a:1 == "remove"
        execute "lua require'quickmark'.quickmark_remove()"
        call QuickmarkSetKeymaps()
    elseif a:1 == "removeAll"
        execute "lua require'quickmark'.quickmarks_removeall()"
        call QuickmarkSetKeymaps()
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

nnoremap <silent> <Leader>qq :Quickmark list<CR>
nnoremap <silent> <Leader>qa :Quickmark add<CR>
nnoremap <silent> <Leader>qd :Quickmark remove<CR>
nnoremap <silent> <Leader>qr :Quickmark removeAll<CR>
nnoremap <silent> <Leader>qs :Quickmark save<CR>
nnoremap <silent> <Leader>qn :call QuickmarkCreateShortcut()<CR>

call QuickmarkSetKeymaps()

let &cpo = s:save_cpo " restore the options
unlet s:save_cpo

let g:quickmark_init = 1

