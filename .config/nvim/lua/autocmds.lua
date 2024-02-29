-- removing trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- don't auto comment new lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
})

vim.api.nvim_command("autocmd InsertEnter * setlocal nohlsearch")
vim.api.nvim_command("autocmd InsertLeave * setlocal hlsearch")

-- automatically resize vim buffers
vim.api.nvim_command("autocmd VimResized * wincmd =")

-- return to last position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.fn.setpos(".", vim.fn.getpos("'\""))
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})
