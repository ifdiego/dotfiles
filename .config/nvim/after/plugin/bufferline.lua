require("bufferline").setup{
  highlights = {
    fill = {
      bg = {
        attribute = "fg",
        highlight = "black"
      }
    }
  },
  options = {
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true
      }
    },
  }
}
