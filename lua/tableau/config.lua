local M = {}

_TableauConfig = _TableauConfig or {
  hl_groups = {
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
  hidden_buffer_types = {
    "NeogitStatus",
    "NeogitPopup",
    "NeogitCommitMessage",
    "nofile",
    "prompt",
    "TelescopePrompt",
  }
}

M.current = function()
  return _TableauConfig
end

M.load = function(new_config)
  _TableauConfig = new_config
end

return M
