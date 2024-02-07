<div align="center">

# tableau.nvim
An opinionated tabline plugin for Neovim

</div>

> ⚠️ Tableau.nvim is very experimental. It currently has limited configuration and the features and API are subject to frequent changes and breakages. 

## Purpose
Unlike other tabline plugins, which try to replace the tabline functionality entirely, Tableau tries to improve upon the built-in tab functionality. It's mainly an attempt to optimize my personal workflow.

It is not trying to be the ultimate tabline plugin. Here's a list of the primary features of Tableau:

1. Displays all the tabs in order with all the open windows in each tab
2. Highlights the active windows in each tab
3. Preserve vim tab movement commands
4. Supports hidding windows based on filetype 
5. Supports devicons
6. Supports custom themes

## Installation
Using lazy:
```lua
  {
    "eliseshaffer/tableau.nvim",
    config = function()
      require('tableau').setup()
    end,
  },
```

## Configuration
Tableau.nvim supports the following configuration options:
```lua
  hl_groups = { -- highlight groups for each segment
    {
      name = "TableauBackground",
      fg = "#24273a",
      bg = "#24273a"
    },
    {
      name = "TableauCurrentInactive",
      fg = "#24273a",
      bg = "#d0b0ff"
    },
    {
      name = "TableauCurrentActive",
      fg = "#24273a",
      bg = "#b690d6",
    },
    {
      name = "TableauOtherInactive",
      fg = "#d0b0ff",
      bg = "#24273a",
    },
    {
      name = "TableauOtherActive",
      fg = "#b690d6",
      bg = "#24273a",
    },
  },
  hidden_buffer_types = {} -- buffer types that you want to hide from the tabline
```

## Contributing
At this early stage of development, pull requests are only being accepted from contributors
