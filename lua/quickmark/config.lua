local M = {}

-- if you using anything but this config the default one idk what imma do
-- but i created this so now i have monopoly
M.options = {
    autosave = true,
    key_mappings = {
        list = '<leader>qq',
        add = '<leader>qa',
        remove = '<leader>qr',
        remove_all = '<leader>qR',
        save = '<leader>qs',
        shortcut = '<leader>qn',
        open_shortcut = '<leader>qo',
    },
}

function M.setup(user_config)
    M.options = vim.tbl_deep_extend("force", M.options, user_config or {})
end

return M
