-- automatically switch to insert mode when entering a Term buffer
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
  group = vim.api.nvim_create_augroup("openTermInsert", {}),
  callback = function(args)
    -- we don't use vim.startswith() and look for test:// because of vim-test
    -- vim-test starts tests in a terminal, which we want to keep in normal mode
    if vim.endswith(vim.api.nvim_buf_get_name(args.buf), "fish") then
      vim.cmd("startinsert")
    end
  end,
})

-- don"t show number
vim.api.nvim_create_autocmd("TermOpen", {
  command = [[setlocal nonumber norelativenumber statusline=%{b:term_title}]],
})

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
