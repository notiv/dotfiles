-- Shorthand in order to write map(...) instead of vim.keymap.set(...)
local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

-- Highlight the line number by severity
vim.diagnostic.config({
  -- Set diagnostic signs enabled and sets `numhl` so the line number itself is colored per severity
  signs = {
    -- text = {
    --   [vim.diagnostic.severity.ERROR] = "",
    --   [vim.diagnostic.severity.WARN] = "",
    --   [vim.diagnostic.severity.INFO] = "",
    --   [vim.diagnostic.severity.HINT] = "",
    -- },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    },
  },
})

-- Keymaps for diagnostics
-- Jump to the next diagnostic 
map("n", "<leader>dj", function() vim.diagnostic.jump({ count = 1 }) end,  { desc = "Next Diagnostic" })
-- Jump to the previous diagnostic
map("n", "<leader>dk", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev Diagnostic" })
-- Show a floating window with diagnostics for the current cursor position/line
map("n", "<leader>dc", function() vim.diagnostic.open_float() end,         { desc = "Toggle current diagnostic" })
-- Put all diagnostics into the quickfix list and open it
map("n", "<leader>dd", function() vim.diagnostic.setqflist() end,          { desc = "Open quickfix" })

