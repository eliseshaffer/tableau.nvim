local Config = require('tableau.config')
local devicons = require("nvim-web-devicons")
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

  -- return "%#" .. hl .. "#" .. icon
  return icon
end

utils.create_highlight_groups = function(hl_groups)
  for _, hl in ipairs(hl_groups) do
    vim.api.nvim_set_hl(0, hl.name, { fg = hl.fg, bg = hl.bg })
  end
end

utils.get_highlight_group_for_tab = function(tab_id)
  local current_tab   = vim.api.nvim_get_current_tabpage()
  local hl            = ""

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

return utils
