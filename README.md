<div align="center">

# Quickmark.nvim
###### Quickly navigate your project 

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

```lua
    require('quickmark').setup({
        messages = false, -- if quickmark should print what has been done such as save or add
        autosave = true, -- if quickmarks should be autosaved to `.quickmarks` if they are changed
        key_mappings = {
            list = '<leader>qq', -- open window with quickmarks
            add = '<leader>qa', -- add current open file to quickmarks
            remove = '<leader>qr', -- remove current open file from quickmarks
            remove_all = '<leader>qR', -- empty quickmarks
            save = '<leader>qs', -- save quickmarks
            shortcut = '<leader>qn', -- add a new shortcut
            open_shortcut = '<leader>qo', -- open shortcut
        },
    })
```

You can call the `setup` function without parameters if you want the default 
keybindings. The `setup` function must be called to initialize quickmark if you
are not calling it in for example the `config` option of lazy.nvim the plugin 
will not initalize and it will be unusable. :(


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


