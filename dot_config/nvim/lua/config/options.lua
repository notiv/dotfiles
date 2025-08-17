
vim.g.autoformat = true -- global var for toggling autoformat

-- The custom fold expression prevents expensive Treesitter fold calculations in buffers where it's not needed, while still using Treesitter folds for code
local function foldexpr()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    if vim.bo[buf].filetype:find("dashboard") then
      vim.b[buf].ts_folds = false
    else
      vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

_G.vnext.foldexpr = foldexpr

-- Options in alphabetical order
vim.opt.clipboard      = "unnamedplus" -- Sync with system clipboard
vim.opt.relativenumber = true
vim.opt.cursorline     = true -- Highlight current line
vim.opt.dir            = vim.fn.stdpath("data") .. "/swp" -- Custom swap file directory
vim.opt.expandtab      = true -- Convert tabs to spaces
vim.opt.diffopt        = "internal,filler,closeoff,linematch:60" -- Better diff view with line matching (as in github.com/Allaman
vim.opt.fillchars      = "eob: ,fold: ,foldopen: ,foldsep: ,foldclose: " -- hide ~ at the end of buffer and set fold symbols
vim.opt.foldenable     = true
vim.opt.foldexpr       = "v:lua.vnext.foldexpr()" -- Custom fold expression
vim.opt.foldlevel      = 99 -- Keep folds open by default
vim.opt.foldlevelstart = -1 -- Close only top-level folds initially
vim.opt.foldmethod     = "expr" -- Fold by expression 
vim.opt.foldnestmax    = 4 -- Limit nesting depth
vim.opt.foldtext       = "" -- Empty = use default fold text
vim.opt.ignorecase     = true
vim.opt.listchars      = {
  eol = "↲",
  tab = "→ ",
  trail = "+",
  extends = ">",
  precedes = "<",
  space = "·",
  nbsp = "␣",	
} -- Visualize invisible characters (tab, space, eol, etc.)
vim.opt.mouse          = "a" -- Mouse support in normal & visual modes
vim.opt.number         = false -- No absolute line numbers
vim.opt.scrolloff      = 10 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.signcolumn     = "yes" -- Prevent text shifting when signs appear.
vim.opt.shiftwidth     = 2 -- Indent size = 2 spaces
vim.opt.smartcase      = true -- Don't ignore case if query contains uppercase characters 
vim.opt.smartindent    = true -- Auto-indents code structures
vim.opt.splitbelow     = true -- Force horizontal splits to appear below the current window
vim.opt.splitright     = true -- Force vertical splits to appear to the right of the current window
vim.opt.tabstop        = 2 -- Tab characters are displayed as 2 spaces
vim.opt.softtabstop    = 2
vim.opt.timeoutlen     = 300 -- Time to wait for a mapped sequence to complete
vim.opt.ttimeoutlen    = 0 -- Immediate key code timeout
vim.opt.updatetime     = 250 -- Faster CursorHold events (good for LSP).

