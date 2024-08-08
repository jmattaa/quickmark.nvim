
local mappings = {
    ['<Esc>'] = "close_window()",
    ['q'] = "close_window()",
    ['<cr>'] = "open_file()",
    ['j'] = "move_cursor(1)",
    ['k'] = "move_cursor(-1)",
    ['r'] = "remove_quickmark_win_i()"
}

return {
    mappings = mappings
}
