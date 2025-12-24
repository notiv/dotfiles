-- Tiny wrapper around vim.keymap.set so that we use map instead of vim.keymap.set 
local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

-- Remap for dealing with visual line wraps
-- If no count is given, k/j act on screen lines (gk/gj); if a count is given (e.g. 5j), they act on real lines
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ESC clears search highlights
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })


-- Window management (<leader>w...)
-- window
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close" })
map("n", "<leader>wT", "<cmd>wincmd T<cr>", { desc = "Move window to new tab" })
map("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "rotate down/right" })
map("n", "<leader>wR", "<cmd>wincmd R<cr>", { desc = "rotate up/left" })
map("n", "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Move left" })
map("n", "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Move down" })
map("n", "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Move up" })
map("n", "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Move right" })
map("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize size" })
map("n", "<leader>wk", "<cmd>resize +5<cr>", { desc = "Up" })
map("n", "<leader>wj", "<cmd>resize -5<cr>", { desc = "Down" })
map("n", "<leader>wh", "<cmd>vertical resize +3<cr>", { desc = "Left" })
map("n", "<leader>wl", "<cmd>vertical resize -3<cr>", { desc = "Right" })

-- buffers
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all buffers but the current" })

-- Disable default mappings to declutter which-key
vim.api.nvim_del_keymap("n", "gra") -- vim.lsp.buf...
vim.api.nvim_del_keymap("x", "gra") -- vim.lsp.buf...
vim.api.nvim_del_keymap("n", "gri") -- vim.lsp.buf...
vim.api.nvim_del_keymap("n", "grn") -- vim.lsp.buf...
vim.api.nvim_del_keymap("n", "grr") -- vim.lsp.buf...
vim.api.nvim_del_keymap("n", "gO") -- vim.lsp.buf...

vim.api.nvim_del_keymap("n", "]d") -- vim.lsp.buf...
vim.api.nvim_del_keymap("n", "]D") -- vim.lsp.buf...

vim.api.nvim_del_keymap("n", "gx") -- open filepath under cursor
vim.api.nvim_del_keymap("x", "gx") -- open filepath under cursor

-- "Enter" toggles fold (smart)
vim.keymap.set("n", "<CR>", function()
  if vim.bo.buftype == "quickfix" then
    -- Execute the default Enter behavior in quickfix list
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end
  -- Get the current line number
  local line = vim.fn.line(".")
  -- Get the fold level of the current line
  local foldlevel = vim.fn.foldlevel(line)
  if foldlevel == 0 then
    vim.notify("No fold found", vim.log.levels.INFO)
  else
    vim.cmd("normal! za")
    vim.cmd("normal! zz") -- center the cursor line on screen
  end
end, { desc = "Toggle fold" })

map("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory in Oil" })

map("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostics in float" })

map("n", "<leader>uI", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, { desc = "Inspect tree" })
