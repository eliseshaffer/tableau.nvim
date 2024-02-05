<div align="center">
  
# tableau.nvim
An opinionated tabline plugin for Neovim  

</div>

> ⚠️ Tableau.nvim is very experimental. It currently doesn't have any configuration and the features and API are subject to frequent changes. 

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
      require('tableau').setup({})
    end,
  },
```

## Contributing
While in development, pull requests will only be accepted from contributors. 
