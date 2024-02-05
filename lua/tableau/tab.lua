local utils = require('tableau.utils')
local Buffer = require("tableau.buffer")
local Tab = {}

-- tab = {
--   hl = "TableauCurrentInactive",
--   place = 1,
--   tab_id = 1015,
--   buffers = {
--     Buffer:new(),
--   }
-- }
function Tab:new(tab_id)
  local o = {
    tab_id = tab_id,
    place = vim.api.nvim_tabpage_get_number(tab_id),
    hl = utils.get_highlight_group_for_tab(tab_id),
    buffers = {},
  }

  setmetatable(o, self)
  self.__index = self
  return o
end

function Tab:add_buffers()
  local wins    = vim.api.nvim_tabpage_list_wins(self.tab_id)
  for _, win_id in ipairs(wins) do
    table.insert(self.buffers, Buffer:new(self.tab_id, win_id))
  end
end

function Tab:render()
  return self:render_place() .. self:render_buffers() .. self:render_close()
end

function Tab:render_place()
  return self.hl .. "%" .. self.place .. "T" .. self.hl .. " " .. self.place .. ":"
end

function Tab:render_close()
  return self.hl .. "%" .. self.place .. "X — %X"
end

function Tab:render_buffers()
  local rendered_buffers = ""
  for _, buffer in ipairs(self.buffers) do
    rendered_buffers = rendered_buffers .. buffer:render()
  end
  return rendered_buffers
end

return Tab
