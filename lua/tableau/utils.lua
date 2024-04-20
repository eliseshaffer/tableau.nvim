local Config = require('tableau.config')
local utils = {}

utils.has_key = function(ft, buftype)
  for _, type in pairs(Config.current().hidden_buffer_types) do
    if type == ft or type == buftype then
      return true
    end
  end

  return false
end

utils.render_icon = function(bufname)
  local extension = vim.fn.fnamemodify(bufname, ":e")
  local icon, hl = devicons.get_icon(bufname, extension, { default = true })

  return "%#" .. hl .. "#" .. icon
end

utils.create_highlight_groups = function(hl_groups)
  local n_hl_groups = utils.get_hl_config_for_current_colorscheme()
  for _, hl in pairs(n_hl_groups) do
    vim.api.nvim_set_hl(0, hl.name, { fg = hl.fg, bg = hl.bg })
  end
end

utils.get_highlight_group_for_tab = function(tab_id)
  local current_tab = vim.api.nvim_get_current_tabpage()
  local hl          = ""

  if tab_id == current_tab then
    hl = "%#TableauCurrentInactive#"
  elseif tab_id ~= current_tab then
    hl = "%#TableauOtherInactive#"
  end

  return hl
end

utils.get_highlight_group_for_win = function(tab_id, win_id)
  local current_tab   = vim.api.nvim_get_current_tabpage()
  local active_on_tab = vim.api.nvim_tabpage_get_win(tab_id)
  local current_win   = vim.api.nvim_get_current_win()
  local hl            = ""

  if tab_id == current_tab then
    if win_id == current_win then
      hl = "%#TableauCurrentActive#"
    else
      hl = "%#TableauCurrentInactive#"
    end
  else
    if win_id == active_on_tab then
      hl = "%#TableauOtherActive#"
    else
      hl = "%#TableauOtherInactive#"
    end
  end

  return hl
end

utils.get_hl_config_for_current_colorscheme = function()
  local colorscheme_hl = {
    ["catppuccin-macchiato"] = {
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
        bg = "#363a4f",
      },
      {
        name = "TableauOtherActive",
        fg = "#a576cc",
        bg = "#363a4f",
      },
    },
    ["catppuccin-latte"] = {
      {
        name = "TableauBackground",
        fg = "#eff1f5",
        bg = "#eff1f5"
      },
      {
        name = "TableauCurrentInactive",
        fg = "#eff1f5",
        bg = "#78a3f9",
      },
      {
        name = "TableauCurrentActive",
        fg = "#eff1f5",
        bg = "#1e66f5",
      },
      {
        name = "TableauOtherInactive",
        fg = "#78a3f9",
        bg = "#ccd0da",
      },
      {
        name = "TableauOtherActive",
        fg = "#1e66f5",
        bg = "#ccd0da",
      },
    },
  }
  local current_colorscheme = vim.g.colors_name

  return colorscheme_hl[current_colorscheme]
end

return utils
