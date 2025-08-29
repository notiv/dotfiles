
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

-- LaTeX-specific file settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "tex", "plaintex" },
	callback = function()
		-- Enable spell checking for LaTeX files
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
		
		-- Text formatting settings
		vim.opt_local.textwidth = 80
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
		
		-- Indentation settings
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
		
		-- Better completion
		vim.opt_local.iskeyword:append(":")
		vim.opt_local.conceallevel = 2
		
		-- Let VimTeX handle folding (it sets up folding automatically)
		-- Don't override fold settings here to avoid conflicts
	end,
	desc = "LaTeX file settings",
})

-- BibTeX-specific file settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "bib",
	callback = function()
		-- Indentation settings
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
		
		-- Enable spell checking
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end,
	desc = "BibTeX file settings",
})

-- LaTeX compilation autocommands
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileSuccess",
	callback = function()
		vim.notify("LaTeX compilation successful", vim.log.levels.INFO)
	end,
	desc = "Notify on successful LaTeX compilation",
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventCompileFailed",
	callback = function()
		vim.notify("LaTeX compilation failed", vim.log.levels.ERROR)
	end,
	desc = "Notify on failed LaTeX compilation",
})


