<div align="center">

# Quickmark.nvim
###### Quickly navigate your project 

<a href="https://dotfyle.com/plugins/{owner}/{name}">
  <img src="https://dotfyle.com/plugins/{owner}/{name}/shield" />
</a>

![demo](./assets/demo.gif)

</div>

# Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use('jmattaa/quickmark.nvim')

```

Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'jmattaa/quickmark.nvim'
```

Using [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
--- in init.lua:
    {
        'jmattaa/quickmark.nvim'
    }

--- in plugins/quickmark.lua:
return {
    'jmattaa/quickmark.nvim'
}
```

# Usage

Use quickmark by typing `:Quickmark list<cr>` or by using the default keybinding `<leader>qq`
this will create a floating window and show all your quickmarks.

The quickmarks are not saved by default, you can save your quickmars for the project 
by using the default keybinding `<leader>qs` or
by typing the command `:Quickmarks save<cr>`.
This creates a file called *`.quickmarks`* in the directory you ran 
the `nvim` command in.

## To configure 

This is the default configuration. If you dont want to change it there is no need
to write the configuration

Using VimL:

```vim
    " Using the Quickmark commands
    nnoremap <leader>qq :Quickmark list<CR>
    nnoremap <leader>qa :Quickmark add<CR>
    nnoremap <leader>qr :Quickmark remove<CR>
    nnoremap <leader>qR :Quickmark removeAll<CR>
    nnoremap <leader>qs :Quickmark save<CR>
    
    " Using Lua functions
    nnoremap <leader>qq :lua require'quickmark'.quickmarks_list()<CR>
    nnoremap <leader>qa :lua require'quickmark'.quickmark_add()<CR>
    nnoremap <leader>qr :lua require'quickmark'.quickmark_remove()<CR>
    nnoremap <leader>qR :lua require'quickmark'.quickmarks_removeall()<CR>
    nnoremap <leader>qs :lua require'quickmark'.quickmarks_save()<CR>
```

Using Lua:

```lua
    local quickmark = require('quickmark')
    vim.keymap.set('n', '<leader>qq', quickmark.quickmarks_list, {})
    vim.keymap.set('n', '<leader>qa', quickmark.quickmark_add, {}) 
    vim.keymap.set('n', '<leader>qr', quickmark.quickmark_remove, {}) 
    vim.keymap.set('n', '<leader>qR', quickmark.quickmark_removeAll, {})
    vim.keymap.set('n', '<leader>qs', quickmark.quickmarks_save, {})
```


For more run the `:help quickmark.usage` command

# Default Mappings

### Keystrokes in quickmarks window

The default keys you can use to navigate and handle the quickmaps window 

| Key              | Action                                               |
|------------------|------------------------------------------------------|
| q or Escape      | Close the quickmark window                           |
| j                | Move the cursor one line down                        |
| k                | Move the cursor one line up                          |
| Enter            | Open the selected file                               |

### Normal mode mappings

The default mappings that are available when you are in the vim normal mode
<br />
These mappings can be customized se ***[Usage](#usage)***

| Mappings         | Action                                               |
|:----------------:|------------------------------------------------------|
| \<leader\>qq     | List the quickmarks that you've added                |
| \<leader\>qa     | Add the current open file to your quickmarks list    |
| \<leader\>qr     | Remove the current open file from your quickmarks    |
| \<leader\>qR     | Empty the quickmarks list                            |
| \<leader\>qs     | Save the quickmars list in a `.quickmarks` file      |

# Shortcuts

A shortcut in `Quickmark` is a quick way to give the quickmarks a binding to 
quickly access it. To give a file a shortcut you can run 
`:Quickmark shortcut '<shortcut>'` where `<shortcut>` is the key you want to 
accociate the file with. The default binding for creating a shortcut is 
`<leader>qn<shortcut>`. Where `<shortcut>` is the key for the file.

To quickly move to the created shortcut use `<leader>qo<shortcut>`.

# Help
For more help you can find the full documentation in the `quickmark` docs by running `:help quickmark`

# Authors

- [@jmattaa](https://github.com/jmattaa)


