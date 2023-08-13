<div align="center">

# Quickmark.nvim
###### Quickly navigate your project 

</div>

![demo](./assets/demo.gif)



## Installation

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


    
## Usage

Use quickmark by typing `:Quickmark list<cr>` 
this will create a floating window and show all your quickmarks

Using VimL:

```vim
" Using the Quickmark commands
nnoremap <leader>qq :Quickmark list<CR>
nnoremap <leader>qa :Quickmark add<CR>
nnoremap <leader>qd :Quickmark remove<CR>
nnoremap <leader>qr :Quickmark removeAll<CR>

" Using Lua functions
nnoremap <leader>qq :lua require'quickmark'.quickmarks_list()<CR>
nnoremap <leader>qa :lua require'quickmark'.quickmark_add()<CR>
nnoremap <leader>qd :lua require'quickmark'.quickmark_remove()<CR>
nnoremap <leader>qr :lua require'quickmark'.quickmarks_removeall()<CR>
```

Using Lua:

```lua
local quickmark = require('quickmark')
vim.keymap.set('n', '<leader>qq', quickmark.quickmarks_list, {})
vim.keymap.set('n', '<leader>qa', quickmark.quickmark_add, {}) 
vim.keymap.set('n', '<leader>qd', quickmark.quickmark_remove, {}) 
vim.keymap.set('n', '<leader>qr', quickmark.quickmark_removeAll, {})
```



## Default Mappings

<style>
  .styled-table {
    border-collapse: separate;
    border-spacing: 0;
    width: 100%;
    margin: 20px 0;
  }

  .styled-table th, .styled-table td {
    padding: 10px 15px;
  }

  .styled-table tr:nth-child(odd) {
    background-color: #f2f2f2;
  }

  .styled-table tr:nth-child(even) {
    background-color: #e0e0e0;
  }

</style>


### Keystrokes in quickmarks window

The default keys you can use to navigate and handle the quickmaps window 

<div class="styled-table">

| Key              | Action                                               |
|:----------------:|------------------------------------------------------|
| q or Escape      | Close the quickmark window                           |
| j                | Move the cursor one line down                        |
| k                | Move the cursor one line up                          |
| Enter            | Open the selected file                               |

</div>

### Normal mode mappings

The default mappings that are available when you are in the vim normal mode
<br />
These mappings can be customized se [Usage](#usage)

<div class="styled-table">

| Mappings         | Action                                               |
|:----------------:|------------------------------------------------------|
| \<leader\>qq     | List the quickmarks that you've added                |
| \<leader\>qa     | Add the current open file to your quickmarks list    |
| \<leader\>qd     | Remove the current open file from your quickmarks    |
| \<leader\>qr     | Empty the quickmarks list                            |

</div>

## Authors

- [@jmattaa](https://github.com/jmattaa)


