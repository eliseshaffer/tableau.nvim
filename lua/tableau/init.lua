-- TODO: Add configuration to setup
-- TODO: Clean up global render function scope; maybe this is not possible?
-- TODO: Add expression matching to hidden buffers
-- FIX: Fix focused window when that window is hidden
-- FIX: fix devicons integration
-- TODO: Handle buffer clicks transitioning focus within a tab
-- TODO: collapse init.lua filenames
-- FIX: highlight group defs on colorscheme change

local devicons = require("nvim-web-devicons")
local M = {}
local utils = require('tableau.utils')
local Tab = require('tableau.tab')
local Config = require('tableau.config')

local function set_tabline()
  local tabline = "%#TableauBackground#"
  local tabpages = vim.api.nvim_list_tabpages()

  for _, tab_id in ipairs(tabpages) do
    local tab = Tab:new(tab_id)
    tab:add_buffers()
    tabline = tabline .. "" .. tab:render() .. "%#TableauBackground#"
  end

  return tabline
end

M.setup = function(config)
  Config.load(config)
  utils.create_highlight_groups()
  vim.o.tabline = "%!v:lua.render_tableau()"
end

function _G.render_tableau()
  return set_tabline()
end

return M
