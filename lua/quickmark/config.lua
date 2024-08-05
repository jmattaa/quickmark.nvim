local M = {}

-- if you using anything but this config the default one idk what imma do
-- but i created this so now i have monopoly
M.options = {
    messages = false,
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
    if user_config then
        for k, v in pairs(user_config) do M.options[k] = v end
    end
end

return M
