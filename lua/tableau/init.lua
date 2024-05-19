-- TODO: Add configuration to setup
-- TODO: Clean up global render function scope; maybe this is not possible?
-- TODO: Add expression matching to hidden buffers
-- TODO: Handle buffer clicks transitioning focus within a tab
-- TODO: collapse init.lua filenames

local devicons = require("nvim-web-devicons")
local M = {}
local Tab = require('tableau.tab')
local Config = require('tableau.config')
local utils = require('tableau.utils')

local function set_tabline()
  local tabline = "%#TableauBackground#"
  local tabpages = vim.api.nvim_list_tabpages()

  for _, tab_id in ipairs(tabpages) do
    local tab = Tab:new(tab_id)
    tab:add_windows()
    tabline = tabline .. "" .. tab:render() .. "%#TableauBackground#"
  end

  return tabline
end

M.setup = function(config)
  Config.load(config)
  utils.create_highlight_groups(Config.current().hl_groups)
  vim.o.tabline = "%!v:lua.render_tableau()"

  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    pattern = "*",
    command = "lua require('tableau').reset_colors()"
  })
end

M.reset_colors = function()
  utils.create_highlight_groups(Config.current().hl_groups)
end

function _G.render_tableau()
  return set_tabline()
end

return M
