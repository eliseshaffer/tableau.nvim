local Config = require('tableau.config').current()
local utils = {}

utils.has_key = function(ft, buftype)
  for _, type in ipairs(Config.hidden_buffer_types) do
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

utils.create_highlight_groups = function()
  for _, hl in ipairs(Config.hl_groups) do
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
  local buf           = vim.api.nvim_win_get_buf(win_id)
  local current_tab   = vim.api.nvim_get_current_tabpage()
  local active_on_tab = vim.api.nvim_tabpage_get_win(tab_id)
  local current_buf   = vim.api.nvim_get_current_win()
  local ft            = vim.api.nvim_buf_get_option(buf, "ft")
  local buftype       = vim.api.nvim_buf_get_option(buf, "buftype")
  local hl            = ""

  if win_id == current_buf then
    hl = "%#TableauCurrentActive#"
  elseif win_id ~= current_buf and tab_id == current_tab then
    hl = "%#TableauCurrentInactive#"
  elseif tab_id ~= current_tab and win_id == win_id ~= current_buf then
    hl = "%#TableauOtherInactive#"
  elseif win_id == active_on_tab then
    hl = "%#TableauOtherActive#*"
  end

  return hl
end

return utils
