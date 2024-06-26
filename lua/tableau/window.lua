local utils = require('tableau.utils')
local Window = {}

-- {
--   hl = "TableauCurrentActive",
--   name = 'keymap.lua'
-- },
function Window:new(tab_id, win_id)
  local buf_id  = vim.api.nvim_win_get_buf(win_id)
  local bufname = vim.api.nvim_buf_get_name(buf_id)
  local name    = vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ":~:."))
  local ft      = vim.api.nvim_get_option_value("ft", { buf = buf_id })
  local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf_id })

  if utils.has_key(ft, buftype) then
    return nil
  end
  local o = {
    hl = utils.get_highlight_group_for_win(tab_id, win_id),
    name = name,
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Window:render()
  return self.hl .. ' ' .. self.name .. ' '
end

return Window
