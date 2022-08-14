# Introduction

`fontsize` is a simple lua plugin for neovim that adds Commands to change the GUI font size on-the-fly.

# Installation

With `packer`:

```shell
use 'Sup3Legacy/fontsize.nvim'
```

With `Plug`:

```shell
Plug 'Sup3Legacy/fontsize.nvim'
```

# Using `fontsize`

## Setup

```lua
require('fontsize').init(
    {
        -- Required argument
        font = "Fira Code, Nerd Font",

        -- Optional arguments
        min = 6,
        default = 10,
        max = 24,
        step = 1,
    }
)
```

The defaults are the following:

```lua
local defaults = {
    min = 6,
    default = 8,
    max = 20,
    step = 1
}
```

## Commands 

When properly initializedn `fontsize` defines a few commands:

- `FontIncrease`: to increase the GUI font size by `step`
- `FontDecrease`: to decrease it by `step`
- `FontReset`: to reset the font size to the default value

## \*line integration

`require('fontsize').indicator` is a function that outputs a string representing the current fontsize. It can be used as a field in e.g. `lualine`.
