
-- Highlight text right after a yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight on yank",
})

-- Stop auto-commenting on new lines
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable new line comment",
})

-- Jump to the last cursor position when reopening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last cursor position when opening a buffer",
})

-- Make certain buffers unlisted and easy to close with `q`
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "grug-far",
    "help",
    "qf",
    "query",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true } )
  end,
  desc = "Make certain utility buffer unlisted and easy to close with q"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "man",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "ZQ", { buffer = event.buf, silent = true } )
  end,
  desc = "Quit man page",
})

-- Auto-apply chezmoi changes after writing dotfiles in the chezmoi repo
local chezmoi_path = vim.fn.resolve(vim.fn.expand("~/.local/share/chezmoi"))
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    chezmoi_path .. "/**/*", -- files in subdirectories
  },
  callback = function()
    vim.notify("Applying chezmoi changes", vim.log.levels.INFO)
    vim.system({ "chezmoi", "apply", "-k" }) -- Runs asynchronously, the UI won't freeze 
  end,
})


