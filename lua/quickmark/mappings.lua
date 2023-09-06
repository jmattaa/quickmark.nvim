
local mappings = {
    ['<Esc>'] = "close_window()",
    ['q'] = "close_window()",
    ['<cr>'] = "open_file()",
    ['j'] = "move_cursor(1)",
    ['k'] = "move_cursor(-1)",
    ['J'] = "move_file(1)",
    ["K"] = "move_file(-1)"
}

return {
    mappings = mappings
}
