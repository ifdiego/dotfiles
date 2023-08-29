-- removing trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- don"t auto comment new line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = [[setlocal nohlsearch]],
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = [[setlocal hlsearch]],
})

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
    vim.highlight.on_yank{ timeout=200 }
  end,
})

-- :W sudo saves the file
-- (useful for handling the permission-denied error)
vim.api.nvim_create_user_command("W", "w !sudo tee > /dev/null %", {})
