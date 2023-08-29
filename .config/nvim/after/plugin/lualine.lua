local lsp = function()
  local client = vim.lsp.get_active_clients()[1]
  if client then
    return client.name
  end
  return ''
end

require("lualine").setup {
  options = {
    theme = "auto",
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{'filename', path = 3}},
    lualine_x = {lsp, 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {lsp, 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
